Scriptname ASPr:Logic:Multibit:XNORGate Extends ASPr:Logic:Multibit:LogicGate

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "MultibitXNORGate"
EndFunction

int Function LogicFunction(int A1, int A2)
  Return BitwiseXNOR(A1, A2)
EndFunction
