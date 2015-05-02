Scriptname APPS_PlayerAlias extends ReferenceAlias  

Event OnInit()
	RegisterForModEvent("APPS_MapKey", "OnKeyMapping")
EndEvent

Event OnPlayerLoadGame()
	If(StorageUtil.GetIntValue(None, "APPS.KeyMap.DynamicInteractions") > -1)
		RegisterForModEvent("APPS_MapKey", "OnKeyMapping")
	EndIf
EndEvent

Event OnKeyMapping(Form akSender, Int aiNewKey)
	(GetOwningQuest() As APPS_DI_Functions).SetKey(aiNewKey)
EndEvent