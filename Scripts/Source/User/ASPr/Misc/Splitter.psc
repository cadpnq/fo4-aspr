Scriptname ASPr:Misc:Splitter Extends ASPr:Component

import ASPr:Common

int Property Size = 8 Auto

ASPr:Receiver In
ASPr:Output[] Outputs

Function Init()
  Height = 1
  Width = Size
  ComponentName = "Splitter"
EndFunction

Function Placed()
  In = InitReceiver(SIDE_BOTTOM, ORIGIN_DEFAULT, 0, TRIGGER_DATA, "UpdateState")
  Outputs = InitOutputs(Size, SIDE_TOP, ORIGIN_RIGHT)

  UpdateState()
EndFunction

Function UpdateState()
  WriteOutputs(Outputs, In.value)
EndFunction
