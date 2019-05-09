Scriptname ASPr:Logic:ORGate Extends ASPr:Logic:LogicGate

import ASPr:lib:Binlib

Function Init()
  Parent.Init()
  ComponentName = "ORGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return A1 || A2
EndFunction
