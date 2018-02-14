Scriptname ASPr:Memory:GatedDLatch Extends ASPr:Memory:Latch

ASPr:Input Property D Auto
ASPr:Input Property Enable Auto

Function Init()
  Parent.Init()
  ComponentName = "Gated D Latch"
EndFunction

Function Placed()
  Parent.Placed()
  D = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 0, TRIGGER_CHANGE, "UpdateState")
  Enable = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "UpdateState")
EndFunction

Function UpdateState()
  If (Enable.IsHigh())
    Value = D.Value()
  EndIf
EndFunction
