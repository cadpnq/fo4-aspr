Scriptname ASPr:Logic:LogicGate Extends ASPr:Component

Import Binlib

ASPr:Input A
ASPr:Input B
ASPr:Output Out

Function Init()
  Height = 1
  Width = 1
  ComponentName = "LogicGate"
EndFunction

Function Placed()
  A = SpawnConnector(TYPE_INPUT, SIDE_TOP, ORIGIN_DEFAULT, 0, TRIGGER_CHANGE, "UpdateState") as ASPr:Input
  B = SpawnConnector(TYPE_INPUT, SIDE_BOTTOM, ORIGIN_DEFAULT, 0, TRIGGER_CHANGE, "UpdateState") as ASPr:Input
  Out = SpawnConnector(TYPE_OUTPUT, SIDE_RIGHT) as ASPr:Output
EndFunction

Function UpdateState()
  Out.Set(LogicFunction(A.Value(), B.Value()))
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return False
EndFunction
