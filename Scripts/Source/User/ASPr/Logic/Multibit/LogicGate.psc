Scriptname ASPr:Logic:Multibit:LogicGate Extends ASPr:Component

int Property InputCount = 2 Auto

ASPr:Receiver[] Inputs
ASPr:Transmitter Out

Function Init()
  Height = InputCount
  Width = 1
EndFunction

Function Placed()
  Inputs = InitReceivers(InputCount, SIDE_LEFT, ORIGIN_DEFAULT, 0, TRIGGER_DATA, "UpdateState")
  Out = InitTransmitter(SIDE_RIGHT, ORIGIN_MIDDLE)
  Out.Enabled = True
  UpdateState()
EndFunction

Function UpdateState()
  int Value = Inputs[0].Value
  int i = 0
  While (i < InputCount)
    Value = LogicFunction(Value, Inputs[i].Value)
    i += 1
  EndWhile
  Out.Value = Value
EndFunction

int Function LogicFunction(int A1, int A2)
  Return 0
EndFunction
