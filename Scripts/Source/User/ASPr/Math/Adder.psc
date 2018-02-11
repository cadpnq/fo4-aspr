Scriptname ASPr:Math:Adder Extends ASPr:Component

ASPr:Receiver A
ASPr:Receiver B
ASPr:Transmitter Out

ASPr:Input CarryIn
ASPr:Output CarryOut

Function Init()
  Height = 2
  Width = 1
  ComponentName = "Adder"
EndFunction

Function Placed()
  A = InitReceiver(SIDE_LEFT, ORIGIN_DEFAULT, 0, TRIGGER_DATA, "UpdateState")
  B = InitReceiver(SIDE_LEFT, ORIGIN_DEFAULT, 2, TRIGGER_DATA, "UpdateState")
  Out = InitTransmitter(SIDE_RIGHT)

  CarryIn = InitInput(SIDE_TOP, ORIGIN_DEFAULT, 0, TRIGGER_CHANGE, "UpdateState")
  CarryOut = InitOutput(SIDE_BOTTOM)
  Out.enabled = True
  UpdateState()
EndFunction

Function Die()
EndFunction

Function UpdateState()
  int sum = A.value + B.value
  If (CarryIn.IsHigh())
    sum += 1
  EndIf
  Out.value = sum
  ; TODO: actually set carry out
EndFunction
