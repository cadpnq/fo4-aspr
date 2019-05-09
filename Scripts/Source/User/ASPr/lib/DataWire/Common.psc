Scriptname ASPr:lib:DataWire:Common extends ObjectReference

Struct Data
  int Value
  float Time
  ASPr:lib:DataWire:Transmitter Source
  bool Enabled
EndStruct

ObjectReference Function GetWorkshop() Global
  Return (Game.GetFormFromFile(0x2058E, "Fallout4.esm") as \
    workshopparentscript).CurrentWorkshop.GetReference()
EndFunction
