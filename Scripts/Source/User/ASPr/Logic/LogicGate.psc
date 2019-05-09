Scriptname ASPr:Logic:LogicGate Extends ASPr:Component

import ASPr:lib:Binlib

int Property InputCount = 2 Auto

ASPr:Input[] Inputs
ASPr:Output Out

Function Init()
  Height = InputCount
  Width = 1
EndFunction

Function Placed()
  Inputs = InitInputs(InputCount, SIDE_LEFT, ORIGIN_UP, 0, TRIGGER_CHANGE, "UpdateState")
  Out = InitOutput(SIDE_RIGHT, ORIGIN_MIDDLE)
  UpdateState()
EndFunction

Function UpdateState()
  bool Value = Inputs[0].Value()
  int i = 1
  While (i < InputCount)
    Value = LogicFunction(Value, Inputs[i].Value())
    i += 1
  EndWhile
  Out.Set(Value)
EndFunction

bool Function LogicFunction(bool A1, bool A2)
  Return False
EndFunction
