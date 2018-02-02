Scriptname ASPr:Logic:XORGate Extends ASPr:Component

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "XORGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return LogicalXOR(A1, A2)
EndFunction
