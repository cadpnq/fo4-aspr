Scriptname ASPr:Logic:XNORGate Extends ASPr:Logic:LogicGate

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "XNORGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return LogicalXNOR(A1, A2)
EndFunction
