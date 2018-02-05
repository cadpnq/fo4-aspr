Scriptname ASPr:Contact Extends ObjectReference

Function Open()
  Set(True)
EndFunction

Function Close()
  Set(False)
EndFunction

Function Set(bool value)
  SetOpen(!value)
EndFunction
