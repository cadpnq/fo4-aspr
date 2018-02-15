Scriptname ASPr:Memory:RandomFlipFlop Extends ASPr:Memory:Latch

ASPr:Input Property Enable Auto
ASPr:Input Property Clock Auto

Function Init()
  Parent.Init()
  ComponentName = "Random Flip-Flop"
EndFunction

Function Placed()
  Parent.Placed()
  Enable = InitInput(SIDE_LEFT)
  Clock = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "OnClock")
EndFunction

Function OnClock()
  If (Enable.IsHigh())
    If (Utility.RandomInt(0, 100) >= 50)
      Value = True
    Else
      Value = False
    EndIf
  EndIf
EndFunction
