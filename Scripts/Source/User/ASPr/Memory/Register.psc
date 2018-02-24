Scriptname ASPr:Memory:Register Extends ASPr:Component

ASPr:Input Clock
ASPr:Input Clear
ASPr:Input Enable
ASPr:Receiver DataIn
ASPr:Transmitter DataOut

int Value = 0

Function Init()
  Height = 1
  Width = 3
  ComponentName = "Register"
EndFunction

Function Placed()
  DataIn = InitReceiver(SIDE_LEFT)
  DataOut = InitTransmitter(SIDE_RIGHT)
  Enable = InitInput(SIDE_BOTTOM)
  Clock = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "OnClock")
  Clear = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 2, TRIGGER_HIGH, "OnClear")
  DataOut.Enabled = True
EndFunction

Function OnClock()
  If (Enable.IsHigh() && Clear.IsLow())
    Value = DataIn.value
    DataOut.value = Value
  EndIf
EndFunction

Function OnClear()
  Value = 0
  DataOut.value = 0
EndFunction
