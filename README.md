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
### Initializing connectors
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
* `Contact.Set(bool value)`
* `Contact.Open()`
* `Contact.Close()`

#### ASPr:Transmitter
* `int Value`
* `bool Enabled`

#### ASPr:Receiver
* `int Value`
