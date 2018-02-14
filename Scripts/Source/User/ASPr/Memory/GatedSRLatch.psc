Scriptname ASPr:Memory:GatedSRLatch Extends ASPr:Memory:SRLatch

ASPr:Input Property Enable Auto

Function Init()
  Parent.Init()
  ComponentName = "Gated SR Latch"
EndFunction

Function Placed()
  Parent.Placed()
  Enable = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "OnEnable")
EndFunction

Function OnS()
  If (Enable.IsHigh())
    Parent.OnS()
  EndIf
EndFunction

Function OnR()
  If (Enable.IsHigh())
    Parent.OnS()
  EndIf
EndFunction

Function OnEnable()
  If (S.IsHigh() && R.IsHigh())
    Return
  ElseIf (S.IsHigh())
    OnS()
  ElseIf (R.IsHigh())
    OnR()
  EndIf
EndFunction
