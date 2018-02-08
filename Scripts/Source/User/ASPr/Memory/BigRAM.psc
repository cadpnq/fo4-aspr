Scriptname ASPr:Memory:BigRAM Extends ASPr:Memory:RAM

import Math

int Property Size = 8 Auto
int DataSize
int[] Data

Function Init()
  Height = 2
  Width = 5
  DataSize = Math.pow(2, Size) as int
  ComponentName = DataSize + "x32 RAM"
  Data = bigarray.intarray(DataSize)
EndFunction

Function OnClear()
  int i = 0
  While (i < DataSize)
    Data[i] = 0
    i += 1
  EndWhile
EndFunction

int Function Read(int address)
  If (address > DataSize)
    return 0
  EndIf
  return Data[address]
EndFunction

Function Write(int address, int value)
  If (address > DataSize)
    return
  EndIf
  Data[address] = value
EndFunction
