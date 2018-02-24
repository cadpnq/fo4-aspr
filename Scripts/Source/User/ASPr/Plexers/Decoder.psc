Scriptname ASPr:Plexers:Decoder Extends ASPr:Component

import Math
import ASPr:Common

int Property Size = 2 Auto

ASPr:Output[] Outputs
ASPr:Input Enable
ASPr:Receiver Select

Function Init()
  Height = Size
  Width = 2
  ComponentName = "Decoder"
EndFunction

Function Placed()
  Outputs = InitOutputs(Size, SIDE_RIGHT)
  Enable = InitInput(SIDE_BOTTOM, ORIGIN_RIGHT, 0, TRIGGER_CHANGE, "UpdateState")
  Select = InitReceiver(SIDE_BOTTOM, ORIGIN_LEFT, 0, TRIGGER_DATA, "UpdateState")
EndFunction

Function UpdateState()
  If (Enable.IsHigh())
    WriteOutputs(Outputs, pow(2, Select.Value % Size) as int)
  Else
    WriteOutputs(Outputs, 0)
  EndIf
EndFunction
