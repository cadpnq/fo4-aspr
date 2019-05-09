Scriptname ASPr:Logic:Multibit:NORGate Extends ASPr:Logic:Multibit:LogicGate

import ASPr:lib:Binlib

Function Init()
  Parent.Init()
  ComponentName = "MultibitNORGate"
EndFunction

int Function LogicFunction(int A1, int A2)
  Return BitwiseNOR(A1, A2)
EndFunction
