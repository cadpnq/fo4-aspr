Scriptname ASPr:Logic:Multibit:NORGate Extends ASPr:Logic:Multibit:LogicGate

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "MultibitNORGate"
EndFunction

int Function LogicFunction(int A1, int A2)
  Return BitwiseNOR(A1, A2)
EndFunction
