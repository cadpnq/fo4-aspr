Scriptname ASPr:Logic:Multibit:ORGate Extends ASPr:Logic:Multibit:LogicGate

import ASPr:lib:Binlib

Function Init()
  Parent.Init()
  ComponentName = "MultibitORGate"
EndFunction

int Function LogicFunction(int A1, int A2)
  Return BitwiseOR(A1, A2)
EndFunction
