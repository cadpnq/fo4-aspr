Scriptname ASPr:Memory:Register Extends ASPr:Component

ASPr:Input Clock
ASPr:Input Clear
ASPr:Receiver DataIn
ASPr:Transmitter DataOut

int Value = 0

Function Init()
  Height = 1
  Width = 2
  ComponentName = "Register"
EndFunction

Function Placed()
  DataIn = InitReceiver(SIDE_LEFT, ORIGIN_DEFAULT, 0)
  DataOut = InitTransmitter(SIDE_RIGHT, ORIGIN_DEFAULT, 0)
  Clock = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 0, TRIGGER_HIGH, "OnClock")
  Clear = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "OnClear")
  DataOut.Enabled = True
EndFunction

Function Die()
EndFunction

Function OnClock()
  Value = DataIn.value
  DataOut.value = Value
EndFunction

Function OnClear()
  Value = 0
  DataOut.value = 0
EndFunction
