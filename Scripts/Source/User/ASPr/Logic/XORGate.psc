Scriptname ASPr:Logic:XORGate Extends ASPr:Logic:LogicGate

import ASPr:lib:Binlib

Function Init()
  Parent.Init()
  ComponentName = "XORGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return LogicalXOR(A1, A2)
EndFunction
