Scriptname ASPr:Math:Comparator Extends ASPr:Component

ASPr:Receiver A
ASPr:Receiver B

ASPr:Output Greater
ASPr:Output Equal
ASPr:Output Less

Function Init()
  Height = 3
  Width = 1
  ComponentName = "Comparator"
EndFunction

Function Placed()
  A = InitReceiver(SIDE_LEFT, ORIGIN_DEFAULT, 0, TRIGGER_DATA, "UpdateState")
  B = InitReceiver(SIDE_LEFT, ORIGIN_DEFAULT, 2, TRIGGER_DATA, "UpdateState")

  Greater = InitOutput(SIDE_RIGHT)
  Equal = InitOutput(SIDE_RIGHT, ORIGIN_DEFAULT, 1)
  Less = InitOutput(SIDE_RIGHT, ORIGIN_DEFAULT, 2)
  UpdateState()
EndFunction

Function Die()
EndFunction

Function UpdateState()
  If (A.value > B.value)
    Greater.SetHigh()
    Equal.SetLow()
    Less.SetLow()
  ElseIf (A.value == B.value)
    Greater.SetLow()
    Equal.SetHigh()
    Less.SetLow()
  ElseIf (A.value < B.value)
    Greater.SetLow()
    Equal.SetLow()
    Less.SetHigh()
  EndIf
EndFunction
