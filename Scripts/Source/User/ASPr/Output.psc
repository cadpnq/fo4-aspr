Scriptname ASPr:Output Extends ObjectReference

Function SetHigh()
  Set(True)
EndFunction

Function SetLow()
  Set(False)
EndFunction

Function Set(bool value)
  SetOpen(!value)
EndFunction
