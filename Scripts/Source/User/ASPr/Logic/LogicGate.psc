Scriptname ASPr:Logic:LogicGate Extends ASPr:Component

Import Binlib

ObjectReference A
ObjectReference B
ObjectReference Out

Function Init()
  Height = 1
  Width = 1
  ComponentName = "LogicGate"
EndFunction

Function Placed()
  A = SpawnConnector(TYPE_INPUT, SIDE_TOP, ORIGIN_DEFAULT, 0, TRIGGER_CHANGE, "UpdateState")
  B = SpawnConnector(TYPE_INPUT, SIDE_BOTTOM, ORIGIN_DEFAULT, 0, TRIGGER_CHANGE, "UpdateState")
  Out = SpawnConnector(TYPE_OUTPUT, SIDE_RIGHT)
EndFunction

Function UpdateState()
  Out.SetOpen(!LogicFunction(A.IsPowered(), B.IsPowered()))
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return False
EndFunction
