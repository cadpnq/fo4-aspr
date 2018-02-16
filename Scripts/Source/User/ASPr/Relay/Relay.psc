Scriptname ASPr:Relay:Relay Extends ASPr:Component

ASPr:Input Property In Auto
ASPr:Contact Property NOContact Auto
ASPr:Contact Property NCContact Auto

bool _Energized
bool Property Energized
  bool Function Get()
    Return _Energized
  EndFunction
  Function Set(bool Val)
    _Energized = Val
    UpdateContacts()
  EndFunction
EndProperty

Function Init()
  Height = 1
  Width = 1
  ComponentName = "Relay"
EndFunction

Function Placed()
  In = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 0, TRIGGER_CHANGE, "UpdateState")
  NOContact = InitContact(SIDE_TOP)
  NCContact = InitContact(SIDE_BOTTOM)
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
  Energized = True
EndFunction

Function Off()
  Energized = False
EndFunction

Function UpdateContacts()
  NOContact.Set(Energized)
  NCContact.Set(!Energized)
EndFunction
