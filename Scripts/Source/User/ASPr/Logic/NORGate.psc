Scriptname ASPr:Logic:NORGate Extends ASPr:Logic:LogicGate

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "NORGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return LogicalNOR(A1, A2)
EndFunction
