Scriptname ASPr:Relay:Base Extends ASPr:Component

ASPr:Input Property In Auto
ASPr:Contact Property Contact Auto

Function Init()
  Height = 1
  Width = 1
EndFunction

Function Placed()
  In = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 0, TRIGGER_CHANGE, "UpdateState")
  Contact = InitContact(SIDE_RIGHT)
  UpdateState()
EndFunction

; consider using script states here
Function UpdateState()
  If (In.IsHigh())
    On()
  Else
    Off()
  EndIf
EndFunction

Function On()
EndFunction

Function Off()
EndFunction
