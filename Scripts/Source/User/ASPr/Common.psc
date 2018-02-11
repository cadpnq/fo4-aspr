Scriptname ASPr:Common

import Math
import Binlib

ObjectReference[] Function MakeObjects(ObjectReference ParentObject, Form Object, int Count) Global
	ObjectReference[] Objects = new ObjectReference[Count]

	int i = 0
	While (i < Count)
		Objects[i] = ParentObject.placeAtMe(Object as Form, 1, True, False, True)
		i += 1
	EndWhile

	return Objects
EndFunction

Function DeleteObjects(ObjectReference[] Objects) Global
	int i = Objects.Length
	While (i)
		i -= 1
		Objects[i].Delete()
		Objects.RemoveLast()
	EndWhile
EndFunction

Function PositionObjectsInline(ObjectReference ParentObject, ObjectReference[] Objects, int OffsetX, int OffsetY, int OffsetZ, int StepX, int StepY, int StepZ) Global
  int Xpos = OffsetX
  int Ypos = OffsetY
  int Zpos = OffsetZ

  int i = 0
  While (i < Objects.Length)
    MoveRelativeTo(ParentObject, Objects[i], Xpos, Ypos, Zpos, True)
    Xpos += StepX
    Ypos += StepY
    Zpos += StepZ
    i += 1
  EndWhile
EndFunction

Function MoveRelativeTo(ObjectReference ParentObject, ObjectReference ObjectToMove, float OffsetX, float OffsetY, float OffsetZ, bool MatchAngle = True) Global
	float Xpos
	float Ypos
	float Zpos = OffsetZ

	float Angle
	float AngleZ = ParentObject.GetAngleZ()

	float Distance = sqrt(pow(OffsetX, 2) + pow(OffsetY, 2))

	If (OffsetX == 0 && OffsetY == 0)
		Angle = 0
	ElseIf (OffsetX == 0)
		If (OffsetY >= 0)
			Angle = 0
		Else
			Angle == 180
		EndIf
	ElseIf (OffsetY == 0)
		If (OffsetX >= 0)
			Angle = 90
		Else
			Angle = 270
		EndIf
	Else
		Angle = atan(OffsetY / OffsetX)
	EndIf

	AngleZ += Angle
	Xpos = Distance * Sin(AngleZ)
	Ypos = Distance * Cos(AngleZ)

	ObjectToMove.MoveTo(ParentObject, Xpos, Ypos, Zpos, MatchAngle)
EndFunction

int Function ReadInputs(ObjectReference[] Connectors) Global
	int retval

	int i = 0
	While (i < Connectors.Length)
		If (Connectors[i].IsPowered())
			retval += pow(2, i) as int
		EndIf

		i += 1
	EndWhile

	return retval
EndFunction

Function WriteOutputs(ObjectReference[] Connectors, int Value) Global
	int i = 0
	While (i < Connectors.Length)
		Connectors[i].SetOpen(GetBit(Value, i) == 0)

		i += 1
	EndWhile
EndFunction
