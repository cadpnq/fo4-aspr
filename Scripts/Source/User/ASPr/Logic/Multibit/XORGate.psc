Scriptname ASPr:Logic:Multibit:XORGate Extends ASPr:Logic:Multibit:LogicGate

import ASPr:lib:Binlib

Function Init()
  Parent.Init()
  ComponentName = "Multibit XOR Gate"
EndFunction

int Function LogicFunction(int A1, int A2)
  Return BitwiseXOR(A1, A2)
EndFunction
