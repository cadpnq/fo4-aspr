Scriptname ASPr:Logic:XNORGate Extends ASPr:Logic:LogicGate

import ASPr:lib:Binlib

Function Init()
  Parent.Init()
  ComponentName = "XNORGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return LogicalXNOR(A1, A2)
EndFunction
