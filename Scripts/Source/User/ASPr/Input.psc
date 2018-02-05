Scriptname ASPr:Input Extends ObjectReference

bool Function IsHigh()
  return Value()
EndFunction

bool Function IsLow()
  return !Value()
EndFunction

bool Function Value()
  return IsPowered()
EndFunction
