Scriptname APPS_PlayerAlias extends ReferenceAlias  

Event OnInit()
	RegisterForModEvent("APPS_MapKey", "OnKeyMapping")
EndEvent

Event OnPlayerLoadGame()
	RegisterForModEvent("APPS_MapKey", "OnKeyMapping")
EndEvent

Event OnKeyMapping(Form akSender, Int aiNewKey)
	Exception.Warn("APPS", "Received event, sending...")
	(GetOwningQuest() As APPS_DI_Functions).SetKey(aiNewKey)
EndEvent