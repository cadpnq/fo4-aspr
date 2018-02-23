Scriptname ASPr:Math:Subtractor Extends ASPr:Component

ASPr:Receiver A
ASPr:Receiver B
ASPr:Transmitter Out

ASPr:Input BorrowIn
ASPr:Output BorrowOut

Function Init()
  Height = 2
  Width = 1
  ComponentName = "Subtractor"
EndFunction

Function Placed()
  A = InitReceiver(SIDE_LEFT, ORIGIN_DEFAULT, 0, TRIGGER_DATA, "UpdateState")
  B = InitReceiver(SIDE_LEFT, ORIGIN_DOWN, 0, TRIGGER_DATA, "UpdateState")
  Out = InitTransmitter(SIDE_RIGHT)

  BorrowIn = InitInput(SIDE_TOP, ORIGIN_DEFAULT, 0, TRIGGER_CHANGE, "UpdateState")
  BorrowOut = InitOutput(SIDE_BOTTOM)
  Out.enabled = True
  UpdateState()
EndFunction

Function UpdateState()
  int i = A.value - B.value
  If (BorrowIn.IsHigh())
    i -= 1
  EndIf
  Out.value = i
  BorrowOut.Set(i < 0)
EndFunction
