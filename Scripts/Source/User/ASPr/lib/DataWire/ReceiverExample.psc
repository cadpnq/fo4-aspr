ScriptName ASPr:lib:DataWire:ReceiverExample extends ObjectReference

Event OnWorkshopObjectPlaced(ObjectReference akReference)
  ASPr:lib:DataWire:Receiver.Register(Self)
EndEvent

Event OnWorkshopObjectDestroyed(ObjectReference akActionRef)
  ASPr:lib:DataWire:Receiver.Unregister(Self)
EndEvent

Event ASPr:lib:DataWire:Receiver.OnData(ASPr:lib:DataWire:Receiver akSender, Var[] akArgs)
	Debug.MessageBox(akArgs[0])
EndEvent
