ScriptName ASPr:lib:DataWire:Receiver extends ObjectReference

import ASPr:lib:DataWire:Common

CustomEvent OnData

Keyword Property dw_transmitter Auto Const
int Property Value Auto

ASPr:lib:DataWire:Common:Data[] Values

Event OnInit()
  Values = new ASPr:lib:DataWire:Common:Data[0]
  RegisterForRemoteEvent(GetWorkshop(), "OnWorkshopMode")
EndEvent

Event OnWorkshopObjectDestroyed(ObjectReference akActionRef)
  Die()
EndEvent

Event DataWire:Transmitter.OnDataInternal(ASPr:lib:DataWire:Transmitter Source, Var[] Args)
  ProcessData(Args[0] as ASPr:lib:DataWire:Common:Data)
EndEvent

; Coming into a OnDataInternal event we can speed things up by splitting things into three cases. They are:
;  * There are no previous values in Values[]. Just add the received value to it
;  * There is one value in Values[] and it came from the same transmitter as the value we just received. Update the value and time in the struct we already have.
;  * We get a value from a new transmitter while holding values from other transmitters. Walk through Values[] and insert the new struct in the right place with respect to the Time value.
Function ProcessData(ASPr:lib:DataWire:Common:Data Data)
  int NewValue = 0

  If (Values.Length == 0 && Data.Enabled)
    Values.Add(Data)
  ElseIf (Values.Length == 1 && Data.Source == Values[0].Source)
    If (!Data.Enabled)
      Values.Remove(0)
    Else
      Values[0].Value = Data.Value
      Values[0].Time = Data.Time
    EndIf
  Else
    int i = Values.FindStruct("Source", Data.Source)
    If (i > -1)
      Values.Remove(i)
    EndIf
    If (Data.Enabled)
      i = 0
      While (i < Values.Length && Values[i].Time > Data.Time)
        i += 1
      EndWhile
      Values.Insert(Data, i)
    EndIf
  EndIf

  UpdateValue()
EndFunction

Event ObjectReference.OnWorkshopMode(ObjectReference akSender, bool aStart)
  If (aStart)
    Return
  EndIf

  UnregisterForAllCustomEvents()
  int i = 0
  DataWire:Transmitter Transmitter
  ObjectReference[] Transmitters = GetWorkshop().GetRefsLinkedToMe(dw_transmitter)

  While (i < Transmitters.Length)
    Transmitter = Transmitters[i] as DataWire:Transmitter
    If (Transmitter.HasSharedPowerGrid(Self))
      RegisterForCustomEvent(Transmitter, "OnDataInternal")
      ProcessData(Transmitter.Data)
    EndIf
    i += 1
  EndWhile

  ; it is possible that we'll receive data from a transmitter and then the user removes the wire connecting us to them. That would result in us having a phantom value in the Values array. The fix? Simple, when leaving workshop mode verify that any value we're currently holding came from a transmitter we're still connected to.
  i = Values.Length - 1
  While (i >= 0)
    If (!Values[i].Source.HasSharedPowerGrid(Self))
      Values.Remove(i)
    EndIf
    i -= 1
  EndWhile

  UpdateValue()
EndEvent

Function UpdateValue()
  int CurrentValue = 0
  If (Values.Length)
    CurrentValue = Values[0].Value
  EndIf

  If (CurrentValue == Value)
    Return
  EndIf

  Value = CurrentValue
  Var[] Args = New Var[1]
  Args[0] = Value
  SendCustomEvent("OnData", Args)
EndFunction

Function Die()
  UnregisterForAllCustomEvents()
  UnregisterForAllRemoteEvents()
  Delete()
EndFunction

DataWire:Receiver Function AsReceiver(ObjectReference This) Global
  Return This as DataWire:Receiver
EndFunction

Function Register(ObjectReference This) Global
  This.RegisterForCustomEvent(AsReceiver(This), "OnData")
EndFunction

Function Unregister(ObjectReference This) Global
  This.UnregisterForCustomEvent(AsReceiver(This), "OnData")
EndFunction
