# DataWire
DataWire implements a 32-bit tri-state bus for communication between settlement objects. If that sounds intimidating you're overthinking it. It all comes down to two things: transmitters and receivers. Transmitters transmit data and receivers... receive it. Ok, code speaks louder than words...


###### Receiver Example
```papyrus
ScriptName DataWire:ReceiverExample extends ObjectReference

Event OnWorkshopObjectPlaced(ObjectReference akReference)
  DataWire:Receiver.Register(Self)
EndEvent

Event OnWorkshopObjectDestroyed(ObjectReference akActionRef)
  DataWire:Receiver.Unregister(Self)
EndEvent

Event DataWire:Receiver.OnData(DataWire:Receiver akSender, Var[] akArgs)
	Debug.MessageBox(akArgs[0])
EndEvent
```

The receiver end of a DataWire connection is based around a custom event named `OnData`. It is sent every time the value on the DataWire bus changes.

##### Transmitter Example
```papyrus
Scriptname DataWire:TransmitterExample extends ObjectReference

DataWire:Transmitter Transmitter
int i = 0

Event OnWorkshopObjectPlaced(ObjectReference akReference)
  Transmitter = DataWire:Transmitter.AsTransmitter(Self)
  Transmitter.Enabled = True
EndEvent

Event OnActivate(ObjectReference akActionRef)
  i += 1
  Transmitter.Value = i
EndEvent
```

Once you have a reference to the transmitter, sending data is just a matter of setting a property. There are two relevant properties: `Value` and `Enabled`. `Value` explains itself, but `Enabled` is a little more complicated.

Remember when I said DataWire was was a tri-state bus? That means that transmitters can disable their outputs. Say you had two transmitters connected to the same receiver. Transmitter1 would have to be disabled for Transmitter2 to say anything.

...Ideally. In practice, the value on the DataWire bus in a situation with multiple transmitters on the same net is the most recent change. Transmitter1 sets it to 42. All the receivers now see 42. Transmitter2 sets it to 11235 and they get 11235.

But what happens if Transmitter2 is then disabled? In that case the DataWire library is smart enough to figure out that the receivers should be seeing 42.


## FAQ:
**Q:** If DataWire can make every wire carry information does that mean it is going to slow my game down?

**A:** Not inherently. The DataWire code only comes into play when you build DataWire enabled objects. If you have it installed but haven't built anything using it then you'll see no change at all.
___

**Q:** Can DataWire be extended to carry things other than an integer?

**A:** Probably. At first it was going to carry a Var instead of an Int (which would have let you pass whatever you wanted), but internally DataWire holds the value in a struct and structs can't have Var variables. It could be worked into the code, but I'm not sure if it would ever be needed so it hasn't been done.
___
