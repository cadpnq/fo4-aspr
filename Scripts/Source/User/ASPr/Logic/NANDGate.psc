Scriptname ASPr:Logic:NANDGate Extends ASPr:Logic:LogicGate

import Binlib

Function Init()
  Parent.Init()
  ComponentName = "NANDGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return LogicalNAND(A1, A2)
EndFunction
