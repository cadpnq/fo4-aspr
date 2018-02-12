Scriptname ASPr:Relay:NC Extends ASPr:Relay:Base

Function Init()
  Parent.Init()
  ComponentName = "NCRelay"
EndFunction

Function On()
  Contact.Open()
EndFunction

Function Off()
  Contact.Close()
EndFunction
