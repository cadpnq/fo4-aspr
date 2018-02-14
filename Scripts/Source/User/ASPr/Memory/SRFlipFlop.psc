Scriptname ASPr:Memory:SRFlipFlop Extends ASPr:Memory:SRLatch

ASPr:Input Property Clock Auto

Function Init()
  Parent.Init()
  ComponentName = "SR Flip Flop"
EndFunction

Function Placed()
  Parent.Placed()
  Clock = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "OnClock")
EndFunction

Function OnS()
EndFunction

Function OnR()
EndFunction

Function OnClock()
  If (S.IsHigh() && R.IsHigh())
    Return
  ElseIf (S.IsHigh())
    Parent.OnS()
  ElseIf (R.IsHigh())
    Parent.OnR()
  EndIf
EndFunction
