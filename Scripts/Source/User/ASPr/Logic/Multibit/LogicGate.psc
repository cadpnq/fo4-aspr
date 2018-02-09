Scriptname ASPr:Logic:Multibit:LogicGate Extends ASPr:Component

import Binlib

ASPr:Receiver A
ASPr:Receiver B
ASPr:Transmitter Out

Function Init()
  Height = 1
  Width = 1
  ComponentName = "MultibitLogicGate"
EndFunction

Function Placed()
  A = InitReceiver(SIDE_TOP, ORIGIN_DEFAULT, 0, TRIGGER_DATA, "UpdateState")
  B = InitReceiver(SIDE_BOTTOM, ORIGIN_DEFAULT, 0, TRIGGER_DATA, "UpdateState")
  Out = InitTransmitter(SIDE_RIGHT, ORIGIN_DEFAULT, 0)
  Out.Enabled = True
EndFunction

Function Die()
EndFunction

Function UpdateState()
  Out.Value = LogicFunction(A.value, B.value)
EndFunction

int Function LogicFunction(int A1, int A2)
  Return 0
EndFunction
