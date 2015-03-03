Scriptname APPS_DI_Functions extends Quest
Import StorageUtil

String Property GROUP_CALLBACK = "APPS.Menu.Groups.Callback." AutoReadOnly Hidden
String Property GROUP_CALLBACK_PARAMETERS = "APPS.Menu.Groups.Callback.Parameters." AutoReadOnly Hidden
String Property GROUP_COLOR = "APPS.Menu.Groups.Color." AutoReadOnly Hidden
String Property GROUP_ISACTIVE = "APPS.Menu.Groups.IsActive." AutoReadOnly Hidden
String Property GROUP_ISEXCLUSIVE = "APPS.Menu.Groups.IsExclusive." AutoReadOnly Hidden
String Property GROUP_LABEL = "APPS.Menu.Groups.Label." AutoReadOnly Hidden
String Property GROUPS = "APPS.Menu.Groups" AutoReadOnly Hidden
String Property TEMP_GROUPS = "APPS.Temp.Groups" AutoReadOnly Hidden
String Property TEMP_GROUPS_LBL = "APPS.Temp.Groups.Label" AutoReadOnly Hidden
String Property TEMP_XGROUPS = "APPS.Temp.Groups.Exclusive" AutoReadOnly Hidden
String Property TEMP_XGROUPS_LBL = "APPS.Temp.Groups.Label.Exclusive" AutoReadOnly Hidden
String Property ENTRY = "APPS.Menu.Groups.Entries" AutoReadOnly Hidden
Actor Property PlayerRef Auto

Event OnKeyUp(Int aiKeyCode, Float afHoldTime)
	If(Utility.IsInMenuMode() || PlayerRef.GetSitState() > 0 )
		Return
	EndIf

	GoToState("MainMenuShown")
	InteractiveMenu()
EndEvent

Function SetKey(Int auiKey)
	UnregisterForAllKeys()
	RegisterForKey(auiKey)
EndFunction

Function InteractiveMenu()

EndFunction

Function InteractiveSubMenu(String asGROUPSName)

EndFunction

Int Function AddMenuGroup(String asGroupName, String asGroupLabel, Bool abIsExclusive = False)
	Int ID = StringListCount(None, GROUPS) + 1

	If(StringListAdd(None, GROUPS, asGroupName, False) == -1)
		Exception.Warn("APPS", "Group " + asGroupName + " already exists", "Invalid arguments", True)
		Return 0
	EndIf

	SetStringValue(None, GROUP_LABEL + ID, asGroupLabel)
	SetIntValue(None, GROUP_ISEXCLUSIVE + ID, abIsExclusive As Int)
	SetIntValue(None, GROUP_ISACTIVE + ID, 1)

	Return ID
EndFunction

Bool Function SetMenuGroupActive(Int auiGroupID, Bool abIsActive = True)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS))
		Return False
	EndIf

	SetIntValue(None, GROUP_ISACTIVE + auiGroupID, abIsActive As Int)
	Return True
EndFunction

Int Function AddMenuEntry(String asGroupName, String asEntry, String asEntryLabel, Bool abIsActive = True, Int auiEntryColor = 0)
	Int ID = StringListFind(None, GROUPS, asGroupName) + 1
	Int EntryID = StringListCount(None, GROUPS + "." + ID) + 1

	If(ID == 0)
		Exception.Warn("APPS", "Can't add entries to a group which doesn't exists", "Invalid arguments", True)
		Return 0
	EndIf

	If(StringListAdd(None, GROUPS + "." + ID, asEntry, False) == -1)
		Exception.Warn("APPS", "Entry already exists for group " + asGroupName + ".", True)
		Return 0
	Else
		SetStringValue(None, GROUP_LABEL + ID + "." + EntryID, asEntryLabel)
		SetIntValue(None, GROUP_ISACTIVE + ID + "." + EntryID, abIsActive As Int)
		SetIntValue(None, GROUP_COLOR + ID + "." + EntryID, auiEntryColor)
	EndIf

	Return StringListCount(None, GROUPS + "." + ID)
EndFunction

String Function AddMenuEntryCallback(String asGroupName, Int auiEntryID, String asEventName)
	Int ID = StringListFind(None, GROUPS, asGroupName) + 1

	If(ID == 0)
		Exception.Warn("APPS", "Can't add entries to a group which doesn't exists", "Invalid arguments", True)
		Return 0
	EndIf

	If(HasStringValue(None, GROUP_CALLBACK + "." + ID + "." + auiEntryID))
		Exception.Warn("APPS", "This entry already has a callback registered.", "Invalid arguments", True)
		Return ""
	Else
		SetStringValue(None, GROUP_CALLBACK + ID + "." + auiEntryID, "APPS_" + asEventName)
	EndIf

	Return "APPS_" + asEventName
EndFunction

Bool Function AddCallbackParameterFloat(String asGroupName, Int auiEntryID, Float afValue)
	Int ID = StringListFind(None, GROUPS, asGroupName) + 1

	If(ID <= 0)
		Return False
	EndIf

	FloatListAdd(None, GROUP_CALLBACK_PARAMETERS + ID + "." + auiEntryID, afValue)

	Return True
EndFunction

Bool Function AddCallbackParameterForm(String asGroupName, Int auiEntryID, Form akValue)
	Int ID = StringListFind(None, GROUPS, asGroupName) + 1

	If(ID <= 0)
		Return False
	EndIf

	FormListAdd(None, GROUP_CALLBACK_PARAMETERS + ID + "." + auiEntryID, akValue)

	Return True
EndFunction

Bool Function AddCallbackParameterInt(String asGroupName, Int auiEntryID, Int aiValue)
	Int ID = StringListFind(None, GROUPS, asGroupName) + 1

	If(ID <= 0)
		Return False
	EndIf

	IntListAdd(None, GROUP_CALLBACK_PARAMETERS + ID + "." + auiEntryID, aiValue)

	Return True
EndFunction

Bool Function AddCallbackParameterString(String asGroupName, Int auiEntryID, String asValue)
	Int ID = StringListFind(None, GROUPS, asGroupName) + 1

	If(ID <= 0)
		Return False
	EndIf

	StringListAdd(None, GROUP_CALLBACK_PARAMETERS + ID + "." + auiEntryID, asValue)

	Return True
EndFunction

State MainMenuShown
	Event OnKeyUp(Int aiKeyCode, Float afHoldingTime)

	EndEvent

	Function InteractiveMenu()
		Int i
		Int SelectedMenu
		String TempListKey
		String TempListLabelKey

		FormListClear(None, TEMP_XGROUPS)
		FormListClear(None, TEMP_XGROUPS_LBL)
		FormListClear(None, TEMP_GROUPS)
		FormListClear(None, TEMP_GROUPS_LBL)

		UIMenuBase WheelMenu = UIExtensions.GetMenu("UIWheelMenu")

		If(!WheelMenu)
			Exception.Throw("APPS", "UIExtensions is not properly installed or malfunctioning.", "Critical error")
			Return
		EndIf

		While(i < StringListCount(None, GROUPS))
			If(GetIntValue(None, GROUP_ISACTIVE + (i + 1)))
				If(GetIntValue(None, GROUP_ISEXCLUSIVE + (i + 1)))
					StringListAdd(None, TEMP_XGROUPS, StringListGet(None, GROUPS, i))
					StringListAdd(None, TEMP_XGROUPS_LBL, GetStringValue(None, GROUP_LABEL + (i + 1)))
				Else
					StringListAdd(None, TEMP_GROUPS, StringListGet(None, GROUPS, i))
					StringListAdd(None, TEMP_GROUPS_LBL, GetStringValue(None, GROUP_LABEL + (i + 1)))
				EndIf
			EndIf

			i += 1
		EndWhile

		If(StringListCount(None, TEMP_XGROUPS) > 0)
			TempListKey = TEMP_XGROUPS
			TempListLabelKey = TEMP_XGROUPS_LBL
		Else
			TempListKey = TEMP_GROUPS
			TempListLabelKey = TEMP_GROUPS_LBL
		EndIf

		i = 0

		While(i < StringListCount(None, TempListKey))
			WheelMenu.SetPropertyIndexString("optionText", i, StringListGet(None, TempListKey, i))
			WheelMenu.SetPropertyIndexString("optionLabelText", i, StringListGet(None, TempListLabelKey, i))
			WheelMenu.SetPropertyIndexBool("optionEnabled", i, True)

			i += 1
		EndWhile

		WheelMenu.SetPropertyIndexString("optionText", i + 1, "$BACK")
		WheelMenu.SetPropertyIndexString("optionLabelText", i + 1, "$BACK")
		WheelMenu.SetPropertyIndexBool("optionEnabled", i + 1, True)

		SelectedMenu = WheelMenu.OpenMenu()

		If(SelectedMenu == i + 1 || SelectedMenu == -1)
			GoToState("")
		Else
			GoToState("SubMenuShown")
			InteractiveSubMenu(StringListGet(None, TempListKey, SelectedMenu))
		EndIf
	EndFunction
EndState

State SubMenuShown
	Event OnKeyUp(Int aiKeyCode, Float afHoldingTime)

	EndEvent

	Function InteractiveSubMenu(String asGroupName)
		Int EventHandle
		Int i
		Int ID = StringListFind(None, GROUPS, asGroupName) + 1
		Int SelectedMenu

		UIMenuBase WheelMenu = UIExtensions.GetMenu("UIWheelMenu")

		If(!WheelMenu)
			Exception.Throw("APPS", "UIExtensions is not properly installed or malfunctioning.", "Critical error")
			Return
		EndIf

		While(i < StringListCount(None, GROUPS + "." + ID))
			WheelMenu.SetPropertyIndexString("optionText", i, StringListGet(None, GROUPS + "." + ID, i))
			WheelMenu.SetPropertyIndexString("optionLabelText", i, GetStringValue(None, GROUP_LABEL + ID + "." + (i + 1)))
			WheelMenu.SetPropertyIndexBool("optionEnabled", i, GetIntValue(None, GROUP_ISACTIVE + ID + "." + (i + 1)))

			If(GetIntValue(None, GROUP_COLOR + ID + "." + (i + 1)) > 0 && GetIntValue(None, GROUP_ISACTIVE + ID + "." + (i + 1)))
				WheelMenu.SetPropertyIndexInt("optionTextColor", i, GetIntValue(None, GROUP_COLOR + ID + "." + (i + 1)))
			EndIf

			i += 1
		EndWhile

		WheelMenu.SetPropertyIndexString("optionText", i + 1, "$BACK")
		WheelMenu.SetPropertyIndexString("optionLabelText", i + 1, "$BACK")
		WheelMenu.SetPropertyIndexBool("optionEnabled", i + 1, True)

		SelectedMenu = WheelMenu.OpenMenu()

		If(SelectedMenu == i + 1 || SelectedMenu == -1)
			GoToState("MainMenuShown")
			InteractiveMenu()
		Else
			GoToState("Busy")

			EventHandle = ModEvent.Create(GetStringValue(None, GROUP_CALLBACK + ID + "." + (i + 1)))

			If(EventHandle)
				ModEvent.PushForm(EventHandle, Self)
				ModEvent.Send(EventHandle)
			EndIf
		EndIf
	EndFunction
EndState
