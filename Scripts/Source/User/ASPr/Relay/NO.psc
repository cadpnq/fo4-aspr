Scriptname ASPr:Relay:NO Extends ASPr:Relay:Base

Function Init()
  Parent.Init()
  ComponentName = "NORelay"
EndFunction

Function On()
  Contact.Close()
EndFunction

Function Off()
  Contact.Open()
EndFunction
