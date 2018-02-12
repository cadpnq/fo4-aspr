Scriptname ASPr:Logic:Multibit:XORGate Extends ASPr:Logic:Multibit:LogicGate

import Binlib

Function Init()
  Parent.Init()
  ComponentName = "MultibitXORGate"
EndFunction

int Function LogicFunction(int A1, int A2)
  Return BitwiseXOR(A1, A2)
EndFunction
