Scriptname ASPr:Memory:DFlipFlop Extends ASPr:Memory:Latch

ASPr:Input Property D Auto
ASPr:Input Property Clock Auto

Function Init()
  Parent.Init()
  ComponentName = "D Flip-Flop"
EndFunction

Function Placed()
  Parent.Placed()
  D = InitInput(SIDE_LEFT)
  Clock = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "OnClock")
EndFunction

Function OnClock()
  Value = D.Value()
EndFunction
