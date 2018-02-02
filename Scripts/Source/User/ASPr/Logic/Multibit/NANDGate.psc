Scriptname ASPr:Logic:Multibit:NANDGate Extends ASPr:Logic:Multibit:LogicGate

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "MultibitNANDGate"
EndFunction

int Function LogicFunction(int A1, int A2)
  Return BitwiseNAND(A1, A2)
EndFunction
