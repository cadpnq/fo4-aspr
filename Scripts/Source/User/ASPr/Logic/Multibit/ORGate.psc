Scriptname ASPr:Logic:Multibit:ORGate Extends ASPr:Logic:Multibit:LogicGate

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "MultibitORGate"
EndFunction

int Function LogicFunction(int A1, int A2)
  Return BitwiseOR(A1, A2)
EndFunction
