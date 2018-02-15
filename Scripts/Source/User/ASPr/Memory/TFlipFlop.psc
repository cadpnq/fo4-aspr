Scriptname ASPr:Memory:TFlipFlop Extends ASPr:Memory:Latch

ASPr:Input Property T Auto
ASPr:Input Property Clock Auto

Function Init()
  Parent.Init()
  ComponentName = "T Flip Flop"
EndFunction

Function Placed()
  Parent.Placed()
  T = InitInput(SIDE_LEFT)
  Clock = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "OnClock")
EndFunction

Function OnClock()
  If (T.IsHigh())
    Value = !Value
  EndIf
EndFunction
