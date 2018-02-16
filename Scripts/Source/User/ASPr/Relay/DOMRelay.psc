Scriptname ASPr:Relay:DOMRelay Extends ASPr:Relay:DelayedRelay

Function Init()
  Parent.Init()
  ComponentName = "Delay-On-Make Relay"
EndFunction

Function On()
  Utility.Wait(Delay)
  Parent.On()
EndFunction
