Scriptname ASPr:Plexers:MBMultiplexer Extends ASPr:Component

int Property Size = 2 Auto

ASPr:Receiver[] Inputs
ASPr:Transmitter Output
ASPr:Input Enable
ASPr:Receiver Select

Function Init()
  Height = Size
  Width = 2
  ComponentName = "Multibit Multiplexer"
EndFunction

Function Placed()
  Inputs = InitReceivers(Size, SIDE_LEFT, ORIGIN_UP, 0, TRIGGER_DATA, "UpdateState")
  Output = InitTransmitter(SIDE_RIGHT)
  Enable = InitInput(SIDE_BOTTOM, ORIGIN_RIGHT, 0, TRIGGER_CHANGE, "UpdateState")
  Select = InitReceiver(SIDE_BOTTOM, ORIGIN_LEFT, 0, TRIGGER_DATA, "UpdateState")
EndFunction

Function UpdateState()
  Output.Enabled = Enable.Value()
  Output.Value = Inputs[Select.Value % Size].Value
EndFunction
