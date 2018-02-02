Scriptname ASPr:Logic:ORGate Extends ASPr:Component

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "ORGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return A1 || A2
EndFunction
