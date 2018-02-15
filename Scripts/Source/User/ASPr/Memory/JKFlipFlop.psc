Scriptname ASPr:Memory:JKFlipFlop Extends ASPr:Memory:Latch

ASPr:Input Property J Auto
ASPr:Input Property K Auto
ASPr:Input Property Clock Auto

Function Init()
  Parent.Init()
  ComponentName = "JK Flip-Flop"
EndFunction

Function Placed()
  Parent.Placed()
  J = InitInput(SIDE_LEFT, ORIGIN_DEFAULT)
  K = InitInput(SIDE_LEFT, ORIGIN_DOWN)
  Clock = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "OnClock")
EndFunction

Function OnClock()
  If (J.IsHigh() && K.IsHigh())
    Value = !Value
  ElseIf (J.IsHigh())
    Value = True
  ElseIf (K.IsHigh())
    Value = False
  EndIf
EndFunction
