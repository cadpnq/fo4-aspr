Scriptname ASPr:Logic:Multibit:LogicGate Extends ASPr:Component

import Binlib

DataWire:Receiver A
DataWire:Receiver B
DataWire:Transmitter Out

Function Init()
  Height = 1
  Width = 1
  ComponentName = "MultibitLogicGate"
EndFunction

Function Placed()
  A = SpawnConnector(TYPE_RECEIVER, SIDE_TOP, ORIGIN_DEFAULT, 0, TRIGGER_DATA, "UpdateState") as DataWire:Receiver
  B = SpawnConnector(TYPE_RECEIVER, SIDE_BOTTOM, ORIGIN_DEFAULT, 0, TRIGGER_DATA, "UpdateState") as DataWire:Receiver
  Out = SpawnConnector(TYPE_TRANSMITTER, SIDE_RIGHT, ORIGIN_DEFAULT, 0) as DataWire:Transmitter
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
