Scriptname ASPr:Plexers:Multiplexer Extends ASPr:Component

int Property Size = 2 Auto

ASPr:Input[] Inputs
ASPr:Output Output
ASPr:Input Enable
ASPr:Receiver Select

Function Init()
  Height = Size
  Width = 2
  ComponentName = "Multiplexer"
EndFunction

Function Placed()
  Inputs = InitInputs(Size, SIDE_LEFT, ORIGIN_UP, 0, TRIGGER_CHANGE, "UpdateState")
  Output = InitOutput(SIDE_RIGHT)
  Enable = InitInput(SIDE_BOTTOM, ORIGIN_RIGHT, 0, TRIGGER_CHANGE, "UpdateState")
  Select = InitReceiver(SIDE_BOTTOM, ORIGIN_LEFT, 0, TRIGGER_DATA, "UpdateState")
EndFunction

Function UpdateState()
  If (Enable.IsLow())
    Output.SetLow()
    Return
  EndIf

  Output.Set(Inputs[Select.Value % Size].Value())
EndFunction
