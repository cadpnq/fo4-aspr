Scriptname ASPr:Logic:NANDGate Extends ASPr:Logic:LogicGate

import ASPr:lib:Binlib

Function Init()
  Parent.Init()
  ComponentName = "NAND Gate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return LogicalNAND(A1, A2)
EndFunction
