Scriptname APPS_PlayerAlias extends ReferenceAlias  
Import StorageUtil

Event OnInit()
	If(!GetOwningQuest().IsRunning())
		Return
	EndIf

	RegisterForModEvent("APPS_MapKey", "OnKeyMapping")
EndEvent

Event OnPlayerLoadGame()
	RegisterForModEvent("APPS_MapKey", "OnKeyMapping")
EndEvent

Event OnKeyMapping(Form akSender, Int aiNewKey)
	UnregisterForAllKeys()
	RegisterForKey(aiNewKey)
EndEvent

Event OnKeyDown(Int aiKeyCode)
	If(aiKeyCode == GetIntValue(None, "APPS.KeyMap.DynamicInteraction"))
		GoToState("Test")
		InteractiveMenu()
	EndIf
EndEvent

Function InteractiveMenu()

EndFunction

State Test
	Function InteractiveMenu()
		Debug.Notification("Test state landing")
		Int CommandStripOnePart = 0
		Int CommandStripAll = 1
		Int CommandLeave = 2
		Int SelectedMenu

		UIMenuBase WheelMenu = UIExtensions.GetMenu("UIWheelMenu")

		If(WheelMenu)
			WheelMenu.SetPropertyIndexString("optionText", CommandStripOnePart, "$STRIP_ONE_PART")
			WheelMenu.SetPropertyIndexString("optionText", CommandStripAll, "$STRIP_ALL")
			WheelMenu.SetPropertyIndexString("optionText", CommandLeave, "$LEAVE")
			WheelMenu.SetPropertyIndexString("optionLabelText", CommandStripOnePart, "$STRIP_ONE_PART_LBL")
			WheelMenu.SetPropertyIndexString("optionLabelText", CommandStripAll, "$STRIP_ALL_LBL")
			WheelMenu.SetPropertyIndexString("optionLabelText", CommandLeave, "$LEAVE")
			WheelMenu.SetPropertyIndexBool("optionEnabled", CommandStripOnePart, True)
			WheelMenu.SetPropertyIndexBool("optionEnabled", CommandStripAll, True)
			WheelMenu.SetPropertyIndexBool("optionEnabled", CommandLeave, True)

			SelectedMenu = WheelMenu.OpenMenu(Self.GetActorRef())

			If(SelectedMenu == CommandLeave || SelectedMenu == -1)
				GoToState("")
			EndIf

			GoToState("")
		EndIf
	EndFunction
EndState