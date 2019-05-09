Scriptname ASPr:Logic:Multibit:NANDGate Extends ASPr:Logic:Multibit:LogicGate

import ASPr:lib:Binlib

Function Init()
  Parent.Init()
  ComponentName = "MultibitNANDGate"
EndFunction

int Function LogicFunction(int A1, int A2)
  Return BitwiseNAND(A1, A2)
EndFunction
