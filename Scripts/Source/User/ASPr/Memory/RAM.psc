Scriptname ASPr:Memory:RAM Extends ASPr:Component

ASPr:Receiver DataIn
ASPr:Receiver AddressIn
ASPr:Transmitter DataOut

ASPr:Input Store
ASPr:Input Select
ASPr:Input Clock
ASPr:Input OutputEnable
ASPr:Input Clear

int[] Chunk0
int[] Chunk1
int[] Chunk2
int[] Chunk3
int[] Chunk4
int[] Chunk5
int[] Chunk6
int[] Chunk7

Function Init()
  Height = 2
  Width = 5
  ComponentName = "1Kx32 RAM"
  Chunk0 = new int[128]
  Chunk1 = new int[128]
  Chunk2 = new int[128]
  Chunk3 = new int[128]
  Chunk4 = new int[128]
  Chunk5 = new int[128]
  Chunk6 = new int[128]
  Chunk7 = new int[128]
EndFunction

Function Placed()
  DataIn = InitReceiver(SIDE_LEFT, ORIGIN_DEFAULT, 0)
  AddressIn = InitReceiver(SIDE_LEFT, ORIGIN_DEFAULT, 1)
  DataOut = InitTransmitter(SIDE_RIGHT, ORIGIN_DEFAULT, 0)

  Store = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 0)
  Select = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 1, TRIGGER_HIGH, "OnSelect")
  Clock = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 2, TRIGGER_HIGH, "OnClock")
  OutputEnable = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 3, TRIGGER_HIGH, "OnOutput")
  Clear = InitInput(SIDE_BOTTOM, ORIGIN_DEFAULT, 4, TRIGGER_HIGH, "OnClear")
EndFunction

Function OnSelect()
  HandleOutput()
EndFunction

Function OnClock()
  If (Select.IsHigh() && Store.IsHigh())
    Write(AddressIn.value, DataIn.value)
  EndIf
EndFunction

Function OnOutput()
  HandleOutput()
EndFunction

Function HandleOutput()
  If (Select.IsHigh() && OutputEnable.IsHigh())
    DataOut.value = Read(AddressIn.value)
    DataOut.Enabled = true
  Else
    DataOut.Enabled = false
  EndIf
EndFunction

Function OnClear()
  int i = 0
  While (i < 128)
    Chunk0[i] = 0
    Chunk1[i] = 0
    Chunk2[i] = 0
    Chunk3[i] = 0
    Chunk4[i] = 0
    Chunk5[i] = 0
    Chunk6[i] = 0
    Chunk7[i] = 0

    i += 1
  EndWhile
EndFunction

int[] Function GetChunk(int Number)
  If(Number == 0)
    Return Chunk0
  ElseIf (Number == 1)
    Return Chunk1
  ElseIf (Number == 2)
    Return Chunk2
  ElseIf (Number == 3)
    Return Chunk3
  ElseIf (Number == 4)
    Return Chunk4
  ElseIf (Number == 5)
    Return Chunk5
  ElseIf (Number == 6)
    Return Chunk6
  ElseIf (Number == 7)
    Return Chunk7
  EndIf
EndFunction

int Function Read(int address)
	int ChunkNumber = Math.floor(address / 128)
	int ChunkAddress = address % 128
	Return GetChunk(ChunkNumber)[ChunkAddress]
EndFunction

Function Write(int address, int value)
	int ChunkNumber = Math.floor(address / 128)
	int ChunkAddress = address % 128
	GetChunk(ChunkNumber)[ChunkAddress] = value
EndFunction
