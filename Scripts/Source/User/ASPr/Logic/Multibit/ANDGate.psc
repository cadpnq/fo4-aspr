Scriptname ASPr:Logic:Multibit:ANDGate Extends AASPr:Logic:Multibit:LogicGate

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "MultibitANDGate"
EndFunction

int Function LogicFunction(int A1, int A2)
  Return BitwiseAND(A1, A2)
EndFunction
