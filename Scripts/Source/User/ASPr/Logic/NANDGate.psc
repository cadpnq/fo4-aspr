Scriptname ASPr:Logic:NANDGate Extends ASPr:Logic:LogicGate

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "NANDGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return LogicalNAND(A1, A2)
EndFunction
