Scriptname ASPr:Relay:DOBRelay Extends ASPr:Relay:DelayedRelay

Function Init()
  Parent.Init()
  ComponentName = "Delay-On-Break Relay"
EndFunction

Function Off()
  Utility.Wait(Delay)
  Parent.Off()
EndFunction
