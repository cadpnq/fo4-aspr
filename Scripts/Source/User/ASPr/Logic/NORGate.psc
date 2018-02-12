Scriptname ASPr:Logic:NORGate Extends ASPr:Logic:LogicGate

import Binlib

Function Init()
  Parent.Init()
  ComponentName = "NORGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return LogicalNOR(A1, A2)
EndFunction
