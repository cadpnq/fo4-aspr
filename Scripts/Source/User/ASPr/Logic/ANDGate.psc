Scriptname ASPr:Logic:ANDGate Extends ASPr:Logic:LogicGate

import Binlib

Function Init()
  Parent.Init()
  ComponentName = "ANDGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return A1 && A2
EndFunction
