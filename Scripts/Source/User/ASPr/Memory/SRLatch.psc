Scriptname ASPr:Memory:SRLatch Extends ASPr:Memory:Latch

ASPr:Input Property S Auto
ASPr:Input Property R Auto

Function Init()
  Parent.Init()
  ComponentName = "SR Latch"
EndFunction

Function Placed()
  Parent.Placed()
  S = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 0, TRIGGER_HIGH, "OnS")
  R = InitInput(SIDE_LEFT, ORIGIN_DOWN, 0, TRIGGER_HIGH, "OnR")
EndFunction

Function OnS()
  If (R.IsLow())
    Value = True
  EndIf
EndFunction

Function OnR()
  If (S.IsLow())
    Value = False
  EndIf
EndFunction
