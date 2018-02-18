Scriptname ASPr:Misc:Combiner Extends ASPr:Component

import ASPr:Common

int Property Size = 8 Auto

ASPr:Input[] Inputs
ASPr:Transmitter Out

Function Init()
  Height = 1
  Width = Size
  ComponentName = "Combiner"
EndFunction

Function Placed()
  Inputs = InitInputs(Size, SIDE_BOTTOM, ORIGIN_RIGHT, 0, TRIGGER_CHANGE, "UpdateState")
  Out = InitTransmitter(SIDE_TOP, ORIGIN_RIGHT)
  Out.enabled = True
  UpdateState()
EndFunction

Function UpdateState()
  Out.value = ReadInputs(Inputs)
EndFunction
