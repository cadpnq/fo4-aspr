Scriptname ASPr:Component Extends ASPr:Constants

import ASPr:Common

int Property Height = 1 Auto
int Property Width = 1 Auto
int Property ConnectorSpacing = 20 Auto
String Property ComponentName = "base_script" Auto

Form Input_Connector
Form Output_Connector
Form Receiver_Connector
Form Transmitter_Connector
Form Contact_Connector

Struct Connector_Data
  int type
  int trigger_type
  String handler
  ObjectReference object
  float x
  float z
EndStruct

Connector_Data[] Top
Connector_Data[] Bottom
Connector_Data[] Left
Connector_Data[] Right

Connector_Data[] All

Function Init()
EndFunction

Function Placed()
EndFunction

Function Die()
EndFunction

Event OnInit()
  Init()
  If (Height < 0)
    Trace("Height must be at least 1", 1)
    Height = 1
  EndIf
  If (Width < 0)
    Trace("Width must be at least 1", 1)
    Width = 1
  EndIf

  Top = new Connector_Data[Width]
  Bottom = new Connector_Data[Width]
  Left = new Connector_Data[Height]
  Right = new Connector_Data[Height]
  All = new Connector_Data[Height * 2 + Width * 2]

  float HorizontalWidth = (Width - 1) * ConnectorSpacing
  float VerticalWidth = (Height - 1) * ConnectorSpacing

  float VerticalOffset = (HorizontalWidth / 2) + ConnectorSpacing
  float HorizontalOffset = (VerticalWidth / 2) + ConnectorSpacing

  float xPos = -(HorizontalWidth / 2)
  float zPos = -(VerticalWidth / 2)

  int number = 0;

  int i = 0
  While (i < Width)
    Top[i] = new Connector_Data
    Bottom[i] = new Connector_Data

    Top[i].x = xPos
    Bottom[i].x = xPos
    Top[i].z = -VerticalOffset
    Bottom[i].z = VerticalOffset

    xPos += ConnectorSpacing

    All[number] = Top[i]
    number += 1
    All[number] = Bottom[i]
    number += 1

    i += 1
  EndWhile

  i = 0
  While (i < Height)
    Left[i] = new Connector_Data
    Right[i] = new Connector_Data

    Left[i].x = -HorizontalOffset
    Right[i].x = HorizontalOffset
    Left[i].z = zPos
    Right[i].z = zPos

    zPos += ConnectorSpacing

    All[number] = Left[i]
    number += 1
    All[number] = Right[i]
    number += 1

    i += 1
  EndWhile

  Input_Connector = Game.GetFormFromFile(Input_id, Plugin)
  Output_Connector = Game.GetFormFromFile(Output_id, Plugin)
  Receiver_Connector = Game.GetFormFromFile(Receiver_id, Plugin)
  Transmitter_Connector = Game.GetFormFromFile(Transmitter_id, Plugin)
  Contact_Connector = Game.GetFormFromFile(Contact_id, Plugin)
EndEvent

Event OnWorkshopObjectPlaced(ObjectReference akReference)
  Placed()
EndEvent

Event ObjectReference.OnPowerOn(ObjectReference Sender,  ObjectReference ref)
  Handle_Event(Sender, TRIGGER_HIGH)
EndEvent

Event ObjectReference.OnPowerOff(ObjectReference Sender)
  Handle_Event(Sender, TRIGGER_LOW)
EndEvent

Event DataWire:Receiver.OnData(DataWire:Receiver akSender, Var[] akArgs)
  Handle_Event(akSender, TRIGGER_DATA)
EndEvent

Event OnWorkshopObjectDestroyed(ObjectReference akActionRef)
  Die()
  UnregisterForAllRemoteEvents()

  ObjectReference Connector
  int i = 0
  While (i < All.Length)
    Connector = All[i].object
    If (Connector is DataWire:Receiver)
      DataWire:Receiver.AsReceiver(Connector).Die()
    Else
      Connector.Delete()
    EndIf

    i += 1
  EndWhile
EndEvent

Function Trace(String Text, int Level)
  Debug.TraceUser("ASPr", ComponentName + ": " + Text, Level)
EndFunction

; This is probably the single most important function in the whole codebase. We're pushing as much complexity as possible out of the component scripts and into the base script. All of that has to go somewhere, and that somewhere is here. This handles spawning in, positioning, and setting up all connectors.
ObjectReference[] Function SpawnConnectors(int Type, int Side, int Origin = 0, int Offset = 0, int Count = 1, int Trig = 0, String Handler = "")
  ; First we check for weirdness bad enough to justify bailing out and not spawning anything.
  If (Type < 0 || Type > 4)
    Trace("Invalid type", 2)
    Return None
  ElseIf (Side < 0 || Side > 3)
    Trace("Invalid location", 2)
    Return None
  ElseIf (Count <= 0)
    Trace("Cannot init 0 or fewer connectors", 2)
    Return None
  EndIf

  ; Next, some warnings.
  If (Trig == TRIGGER_NONE && Handler != "")
    Trace("Handler specified on connector with no trigger", 1)
  EndIf
  If ((Type != TYPE_INPUT || Type != TYPE_RECEIVER) && Handler != "")
    Trace("Handler specified on output connector", 1)
  EndIf
  If (Trig == TRIGGER_DATA && Type != TYPE_RECEIVER)
    Trace("Data trigger is only valid on DataWire inputs", 1)
    Trig = TRIGGER_NONE
  EndIf
  If (Trig != TRIGGER_NONE && Handler == "")
    Trace("No handler specified on connector with trigger", 1)
  EndIf
  If (Offset < 0)
    Trace("Offset cannot be negative - using an offset of 0", 1)
    Offset = 0
  EndIf

  Form ToSpawn
  If (Type == TYPE_INPUT)
    ToSpawn = Input_Connector
  ElseIf (Type == TYPE_OUTPUT)
    ToSpawn = Output_Connector
  ElseIF (Type == TYPE_RECEIVER)
    ToSpawn = Receiver_Connector
  ElseIf (Type == TYPE_TRANSMITTER)
    ToSpawn = Transmitter_Connector
  ElseIf (Type == TYPE_CONTACT)
    ToSpawn = Contact_Connector
  EndIf

  Connector_Data[] Where
  If (Side == SIDE_TOP)
    Where = Top
  ElseIf (Side == SIDE_BOTTOM)
    Where = Bottom
  ElseIf (Side == SIDE_LEFT)
    Where = Left
  ElseIf (Side == SIDE_RIGHT)
    Where = Right
  EndIf

  ObjectReference[] c = MakeObjects(self, ToSpawn, Count)

  int i = Offset
  int step = 1
  ; this handles both ORIGIN_DOWN and ORIGIN_RIGHT
  If (Origin == ORIGIN_DOWN)
    i = Where.Length - Offset
    step = -1
  EndIf

  While (i < c.Length)
    ; TODO: warnings about too many connectors and/or bad placement
    Where[i].type = Type
    Where[i].trigger_type = Trig
    Where[i].handler = Handler
    Where[i].object = c[i]

    ASPr:Common.MoveRelativeTo(self, c[i], Where[i].x, 0, Where[i].z)

    If (Type == TYPE_RECEIVER && Trig == TRIGGER_DATA)
      RegisterForCustomEvent(c[i] as DataWire:Receiver, "OnData")
    ElseIf (Type == TYPE_INPUT)
      If (Trig == TRIGGER_LOW || Trig == TRIGGER_CHANGE)
        RegisterForRemoteEvent(c[i], "OnPowerOff")
      EndIf
      If (Trig == TRIGGER_HIGH || Trig == TRIGGER_CHANGE)
        RegisterForRemoteEvent(c[i], "OnPowerOn")
      EndIf
    EndIf

    i += step
  EndWhile

  Return c
EndFunction

ObjectReference Function SpawnConnector(int Type, int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
  Return SpawnConnectors(Type, Side, Origin, Offset, 1, Trig, Handler)[0]
EndFunction

Function Handle_Event(ObjectReference Sender, int trig)
  var[] args = new var[0]
  Connector_Data Connector = All[All.FindStruct("object", Sender)]
  If (trig == Connector.trigger_type || (Connector.trigger_type == TRIGGER_CHANGE && (trig == TRIGGER_HIGH || trig == TRIGGER_LOW)))
     CallFunction(Connector.handler, args)
  EndIf
EndFunction
