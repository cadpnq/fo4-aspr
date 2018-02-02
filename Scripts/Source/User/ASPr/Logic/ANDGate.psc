Scriptname ASPr:Logic:ANDGate Extends ASPr:Component

import Binlib

Function Init()
  Height = 1
  Width = 1
  ComponentName = "ANDGate"
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return A1 && A2
EndFunction
