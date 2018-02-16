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

Function Die()
EndFunction

Function MessageBox()
  Debug.MessageBox("derp")
EndFunction
