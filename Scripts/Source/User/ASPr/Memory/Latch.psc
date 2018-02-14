Scriptname ASPr:Memory:Latch Extends ASPr:Component

ASPr:Input Property Preset Auto
ASPr:Input Property Clear Auto
ASPr:Output Property Q Auto
ASPr:Output Property QNot Auto

bool _Value = False
bool Property Value
  bool Function Get()
    Return _Value
  EndFunction
  Function Set(bool Val)
    _Value = Val
    UpdateOutputs()
  EndFunction
EndProperty

Function Init()
  Height = 3
  Width = 2
EndFunction

Function Placed()
  Preset = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 0, TRIGGER_HIGH, "OnPreset")
  Clear = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "OnClear")

  Q = InitOutput(SIDE_RIGHT)
  QNot = InitOutput(SIDE_RIGHT, ORIGIN_DOWN)
  Value = False
EndFunction

Function OnPreset()
  Value = True
EndFunction

Function OnClear()
  Value = False
EndFunction

Function UpdateOutputs()
  Q.Set(Value)
  QNot.Set(!Value)
EndFunction
