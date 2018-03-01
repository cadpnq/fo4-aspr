# Advanced Settlement Power (redux)

## Items Added
* Logic gates (AND, OR, NAND, NOR, XOR, XNOR)
* Multibit logic gates
* Latches & Flip-Flops (SR, JK, D, T)
* Relays (NO, NC, Delay-on-break, Delay-on-make)
* RAM modules
* Multiplexers, Demultiplexers, Decoders
* Adders, Subtractors, and Comparators
* Multibit splitters and combiners

**note:** some items have been written but have not been added to the build menu yet

## DataWire!
The previous iteration of ASP introduced "multibit" wires which could carry 32-bit values between components. This functionality was eventually spun off as a standalone library named DataWire. DW is, compared to the old code, blazing fast and much more robust. All of the multibit components in ASP now rely on DW.

What, exactly, does all of that even mean? Say you needed to AND two 4-bit values together in some circuit. You could use four AND gates in parallel, but you could simplify it down to a single multibit AND gate. Fewer components, fewer wires, and fewer chances to make a mistake.

## User Components
```papyrus
Scriptname ASPr:User:cadpnq:example:example Extends ASPr:Component

ASPr:Input In

Function Init()
  Height = 1
  Width = 1
  ComponentName = "Example Component"
EndFunction

Function Placed()
  In = InitInput(SIDE_LEFT, ORIGIN_DEFAULT, 0, TRIGGER_HIGH, "MessageBox")
EndFunction

Function MessageBox()
  Debug.MessageBox("derp")
EndFunction
```

## Component API
### `Init`, `Placed`, and `Die`
### Connector types
* Input
* Output
* Contact
* Transmitter
* Receiver

### Initializing connectors

 ```papyrus
ASPr:Input Function InitInput(int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
ASPr:Output Function InitOutput(int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
ASPr:Contact Function InitContact(int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
ASPr:Transmitter Function InitTransmitter(int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
ASPr:Receiver Function InitReceiver(int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
 ```

* `int Side` - which side of the component to spawn the connector on
    * `SIDE_TOP`
    * `SIDE_BOTTOM`
    * `SIDE_LEFT`
    * `SIDE_RIGHT`
* `int Origin`
    * `ORIGIN_DEFAULT`, `ORIGIN_UP`, `ORIGIN_LEFT`
    * `ORIGIN_REVERSE`, `ORIGIN_DOWN`, `ORIGIN_RIGHT`
    * `ORIGIN_MIDDLE`
* `int Offset` - offset from origin
* `int Trig` - determines when the handler function is called
    * `TRIGGER_NONE` - never
    * `TRIGGER_DATA` - whenever data comes into the receiver
    * `TRIGGER_CHANGE` - on both a high-low and low-high transition
    * `TRIGGER_LOW` - on a high-low transition
    * `TRIGGER_HIGH` - on a low-high transition
* `string Handler` - the name of the handler function for the connector

```papyrus
ASPr:Input[] Function InitInputs(int Count, int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
ASPr:Output[] Function InitOutputs(int Count, int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
ASPr:Contact[] Function InitContacts(int Count, int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
ASPr:Transmitter[] Function InitTransmitters(int Count, int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
ASPr:Receiver[] Function InitReceivers(int Count, int Side, int Origin = 0, int Offset = 0, int Trig = 0, String Handler = "")
 ```

### Connector scripts
#### ASPr:Input
* `bool Function Value()`
* `bool Function IsHigh()`
* `bool Function IsLow()`

#### ASPr:Output
* `Function Output.Set(bool value)`
* `Function Output.SetHigh()`
* `Function Output.SetLow()`

#### ASPr:Contact
* `Function Contact.Set(bool value)`
* `Function Contact.Open()`
* `Function Contact.Close()`

#### ASPr:Transmitter
* `int Value`
* `bool Enabled`

#### ASPr:Receiver
* `int Value`
