Scriptname ASPr:Plexers:Decoder Extends ASPr:Component

import Math
import ASPr:Common

int Property Size = 2 Auto

ASPr:Output[] Outputs
ASPr:Input Enable
ASPr:Receiver Select

Function Init()
  Height = 1
  Width = Size
  ComponentName = "Decoder"
EndFunction

Function Placed()
  Outputs = InitOutputs(Size, SIDE_TOP, ORIGIN_RIGHT)
  Enable = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 0, TRIGGER_CHANGE, "UpdateState")
  Select = InitReceiver(SIDE_BOTTOM, ORIGIN_DEFAULT, 1, TRIGGER_DATA, "UpdateState")
EndFunction

Function UpdateState()
  If (Enable.IsHigh())
    WriteOutputs(Outputs, pow(2, Select.Value % Size) as int)
  Else
    WriteOutputs(Outputs, 0)
  EndIf
EndFunction
