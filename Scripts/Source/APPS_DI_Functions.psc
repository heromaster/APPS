Scriptname APPS_DI_Functions extends Quest
Import StorageUtil

String Property IS_ACTIVE = "APPS.Menu.IsActive" AutoReadOnly Hidden
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
String Property TEMP_XGROUPS_LBL = "APPS.Temp.Groups.Exclusive.Label" AutoReadOnly Hidden
String Property ENTRY = "APPS.Menu.Groups.Entries" AutoReadOnly Hidden
Actor Property PlayerRef Auto

Event OnKeyUp(Int aiKeyCode, Float afHoldTime)
	Int EventHandle

	;Don't do anything if the game has a menu or the console opened
	If(Utility.IsInMenuMode())
		Return
	EndIf

	If(!IsWheelMenuActive())
		EventHandle = ModEvent.Create("APPS_WheelMenuNotActive")

		If(EventHandle)
			ModEvent.PushForm(EventHandle, Self)
			ModEvent.Send(EventHandle)
		Else
			Exception.Throw("APPS", "Could not create an event handle, aborting!", "Unexpected exception")
		EndIf

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

Function InteractiveSubMenu(String asGroupName)

EndFunction

Bool Function SetWheelMenuActive(Bool abIsActive = True)
	If(abIsActive)
		SetIntValue(None, IS_ACTIVE, 1)
	Else
		UnsetIntValue(None, IS_ACTIVE)
	EndIf

	Return True
EndFunction

Bool Function IsWheelMenuActive()
	If(HasIntValue(None, IS_ACTIVE))
		Return True
	Else
		Return False
	EndIf
EndFunction

;Adds a main group for the actions the mod wants to deliver
Int Function AddMenuGroup(String asGroupName, String asGroupLabel, Bool abIsExclusive = False)
	Int ID = StringListCount(None, GROUPS) + 1

	;Try adding the new menu group, it will return -1 if the group already exists
	If(StringListAdd(None, GROUPS, asGroupName, False) == -1)
		Exception.Warn("APPS", "Group " + asGroupName + " already exists", "Invalid argument in function AddMenuGroup", True)
		Return 0
	EndIf

	SetStringValue(None, GROUP_LABEL + ID, asGroupLabel)
	SetIntValue(None, GROUP_ISACTIVE + ID, 1)

	Return ID
EndFunction

Bool Function ChangeMenuGroupDescription(Int auiGroupID, String asGroupName = "", String asGroupLabel = "")
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "Can't change attributes of a group which doesn't exists", "Invalid argument in function ChangeMenuGroupDescription")
		Return False
	EndIf

	If(asGroupName)
		If(!StringListHas(None, GROUPS, asGroupName))
			StringListSet(None, GROUPS, auiGroupID - 1, asGroupName)
		Else
			Exception.Warn("APPS", "Can't rename to the name for group ID " + auiGroupID + " because this menu group already exists.", "Invalid argument in function ChangeMenuGroupDescription")
			Return False
		EndIf
	EndIf

	If(asGroupLabel)
		SetStringValue(None, GROUP_LABEL + auiGroupID, asGroupLabel)
	EndIf

	Return True
EndFunction

Bool Function SetMenuGroupExclusive(Int auiGroupID, Bool abIsExclusive = True)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "Can't change attributes of a group which doesn't exists", "Invalid argument in function SetMenuGroupExclusive", True)
		Return False
	EndIf

	If(abIsExclusive)
		SetIntValue(None, GROUP_ISEXCLUSIVE + auiGroupID, 1)
	Else
		UnsetIntValue(None, GROUP_ISEXCLUSIVE + auiGroupID)
	EndIf

	Return True
EndFunction

Bool Function SetMenuGroupActive(Int auiGroupID, Bool abIsActive = True)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "Can't change attributes of a group which doesn't exists", "Invalid argument in function SetMenuGroupActive", True)
		Return False
	EndIf

	If(abIsActive)
		SetIntValue(None, GROUP_ISACTIVE + auiGroupID, 1)
	Else
		UnsetIntValue(None, GROUP_ISACTIVE + auiGroupID)
	EndIf

	Return True
EndFunction

Bool Function RemoveMenuGroup(Int auiGroupID)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "Can't remove a group which doesn't exists", "Invalid argument in function RemoveMenuGroup", True)
		Return False
	EndIf

	Int Entries = StringListCount(None, GROUPS + "." + auiGroupID)
	Int i

	StringListClear(None, GROUPS + "." + auiGroupID)
	StringListSet(None, GROUPS, auiGroupID - 1, "")
	UnsetStringValue(None, GROUP_LABEL + auiGroupID)
	UnsetIntValue(None, GROUP_ISACTIVE + auiGroupID)
	UnsetIntValue(None, GROUP_ISEXCLUSIVE + auiGroupID)

	While(i < Entries)
		UnsetIntValue(None, GROUP_ISACTIVE + auiGroupID + "." + (i + 1))
		UnsetIntValue(None, GROUP_COLOR + auiGroupID + "." + (i + 1))
		UnsetStringValue(None, GROUP_CALLBACK + auiGroupID + "." + (i + 1))
		UnsetStringValue(None, GROUP_LABEL + auiGroupID + "." + (i + 1))
		FormListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + (i + 1))
		FloatListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + (i + 1))
		IntListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + (i + 1))
		StringListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + (i + 1))
		
		i += 1
	EndWhile
EndFunction

Int Function GetMenuGroup(String asMenuGroup)
	Return StringListFind(None, GROUPS, asMenuGroup) + 1
EndFunction

Bool Function IsMenuGroupActive(Int auiGroupID)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "Menu group with ID " + auiGroupID + " doesn't exists", "Invalid argument in function IsMenuGroupActive", True)
		Return False
	EndIf

	Return HasIntValue(None, GROUP_ISACTIVE + auiGroupID)
EndFunction

Bool Function IsMenuGroupExclusive(Int auiGroupID)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "Menu group with ID " + auiGroupID + " doesn't exists", "Invalid argument in function IsMenuGroupExclusive", True)
		Return False
	EndIf

	Return HasIntValue(None, GROUP_ISEXCLUSIVE + auiGroupID)
EndFunction

Int Function AddMenuEntry(Int auiGroupID, String asEntry, String asEntryLabel, Bool abIsActive = True, Int auiEntryColor = 0)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "Can't add entries to a group which doesn't exists", "Invalid argument in function AddMenuEntry", True)
		Return 0
	EndIf

	Int EntryID = StringListCount(None, GROUPS + "." + auiGroupID) + 1

	If(StringListAdd(None, GROUPS + "." + auiGroupID, asEntry, False) == -1)
		Exception.Warn("APPS", "Entry " + asEntry + " already exists in group with ID " + auiGroupID + ".", "Invalid argument in function AddMenuEntry", True)
		Return 0
	Else
		SetStringValue(None, GROUP_LABEL + auiGroupID + "." + EntryID, asEntryLabel)

		If(abIsActive)
			SetIntValue(None, GROUP_ISACTIVE + auiGroupID + "." + EntryID, abIsActive As Int)
		EndIf

		If(auiEntryColor > 0)
			SetIntValue(None, GROUP_COLOR + auiGroupID + "." + EntryID, auiEntryColor)
		EndIf
	EndIf

	Return EntryID
EndFunction

Bool Function ChangeMenuEntryDescription(Int auiGroupID, Int auiEntryID, String asEntry = "", String asEntryLabel = "")
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "The group with the ID " + auiGroupID + " doesn't exist.", "Invalid argument in function ChangeMenuEntryDescription")
		Return False
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + auiGroupID + "." + auiEntryID) || !StringListGet(None, GROUPS + auiGroupID, auiEntryID))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function ChangeMenuEntryDescription")
		Return False
	EndIf

	If(asEntry)
		If(!StringListHas(None, GROUPS + "." + auiGroupID, asEntry))
			StringListSet(None, GROUPS + "." + auiGroupID, auiEntryID - 1, asEntry)
		Else
			Exception.Warn("APPS", "Can't rename to the name for menu entry ID " + auiEntryID + " because this menu entry already exists.", "Invalid argument in function ChangeMenuEntryDescription")
			Return False
		EndIf
	EndIf

	If(asEntryLabel)
		SetStringValue(None, GROUP_LABEL + auiGroupID + "." + auiEntryID, asEntryLabel)
	EndIf

	Return True
EndFunction

Bool Function SetMenuEntryActive(Int auiGroupID, Int auiEntryID, Bool abIsActive = True)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "The group with the ID " + auiGroupID + " doesn't exist.", "Invalid argument in function SetMenuEntryActive")
		Return False
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + "." + auiGroupID) || !StringListGet(None, GROUPS + "." + auiGroupID, auiEntryID - 1))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function SetMenuEntryActive")
		Return False
	EndIf

	If(abIsActive)
		SetIntValue(None, GROUP_ISACTIVE + auiGroupID + "." + auiEntryID, 1)
	Else
		UnsetIntValue(None, GROUP_ISACTIVE + auiGroupID + "." + auiEntryID)
	EndIf

	Return True
EndFunction

Bool Function SetMenuEntryColor(Int auiGroupID, Int auiEntryID, Int auiEntryColor)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "The group with the ID " + auiGroupID + " doesn't exist.", "Invalid argument in function SetMenuEntryColor")
		Return False
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + "." + auiGroupID) || !StringListGet(None, GROUPS + "." + auiGroupID, auiEntryID - 1))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function SetMenuEntryColor")
		Return False
	EndIf

	If(auiEntryColor > 0)
		SetIntValue(None, GROUP_COLOR + auiGroupID + "." + auiEntryID, auiEntryColor)
	Else
		UnsetIntValue(None, GROUP_COLOR + auiGroupID + "." + auiEntryID)
	EndIf

	Return True
EndFunction

Bool Function RemoveMenuEntry(Int auiGroupID, Int auiEntryID)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "Can't remove an entry from a group which doesn't exists", "Invalid argument in function RemoveMenuEntry", True)
		Return False
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + "." + auiGroupID) || !StringListGet(None, GROUPS + "." + auiGroupID, auiEntryID - 1))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function RemoveMenuEntry")
		Return False
	EndIf

	StringListSet(None, GROUPS + "." + auiGroupID, auiEntryID - 1, "")
	UnsetStringValue(None, GROUP_LABEL + auiGroupID + "." + auiEntryID)
	UnsetIntValue(None, GROUP_ISACTIVE + auiGroupID + "." + auiEntryID)
	UnsetIntValue(None, GROUP_COLOR + auiGroupID + "." + auiEntryID)
	UnsetStringValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID)
	FormListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID)
	FloatListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID)
	IntListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID)
	StringListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID)

	Return True
EndFunction

Int Function GetMenuEntry(String asMenuGroup, String asMenuEntry)
	Int GroupID = StringListFind(None, GROUPS, asMenuGroup) + 1

	If(GroupID > 0)
		Return StringListFind(None, GROUPS + "." + GroupID, asMenuEntry) + 1
	Else
		Return 0
	EndIf
EndFunction

Bool Function IsMenuEntryActive(Int auiGroupID, Int auiEntryID)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "Menu group with ID " + auiGroupID + " doesn't exists", "Invalid argument in function IsMenuEntryActive", True)
		Return 0
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + "." + auiGroupID) || !StringListGet(None, GROUPS + "." + auiGroupID, auiEntryID - 1))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function IsMenuEntryActive")
		Return False
	EndIf

	Return HasIntValue(None, GROUP_ISACTIVE + auiGroupID + "." + auiEntryID)
EndFunction

String Function AddMenuEntryCallback(Int auiGroupID, Int auiEntryID, String asEventName)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "The group with the ID " + auiGroupID + " doesn't exist.", "Invalid argument in function AddMenuEntryCallback")
		Return False
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + "." + auiGroupID) || !StringListGet(None, GROUPS + "." + auiGroupID, auiEntryID - 1))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function AddMenuEntryCallback")
		Return False
	EndIf

	If(HasStringValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID))
		Exception.Warn("APPS", "This entry already has a callback registered.", "Invalid argument in function AddMenuEntryCallback", True)
		Return ""
	Else
		SetStringValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID, "APPS_" + asEventName)
	EndIf

	Return "APPS_" + asEventName
EndFunction

Bool Function RemoveMenuEntryCallback(Int auiGroupID, Int auiEntryID)
	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "The group with the ID " + auiGroupID + " doesn't exist.", "Invalid argument in function RemoveMenuEntryCallback")
		Return False
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + "." + auiGroupID) || !StringListGet(None, GROUPS + "." + auiGroupID, auiEntryID - 1))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function RemoveMenuEntryCallback")
		Return False
	EndIf

	If(!HasStringValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID))
		Exception.Warn("APPS", "The menu entry had no callback registered yet or is already removed", "No callback registered in function RemoveMenuEntryCallback")
		Return False
	EndIf

	FloatListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID)
	FormListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID)
	IntListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID)
	StringListClear(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID)
	UnsetStringValue(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID)
	UnsetIntValue(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID)

	Return True
EndFunction

Bool Function AddCallbackParameterFloat(Int auiGroupID, Int auiEntryID, Float afValue)
	If(GetIntValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID) > 9)
		Exception.Warn("APPS", "Maximum number of arguments exceeded.", "Too many arguments for callback in function AddCallbackParameterFloat")
		Return False
	EndIf

	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "The group with the ID " + auiGroupID + " doesn't exist.", "Invalid argument in function AddCallbackParameterFloat")
		Return False
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + "." + auiGroupID) || !StringListGet(None, GROUPS + "." + auiGroupID, auiEntryID - 1))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function AddCallbackParameterFloat")
		Return False
	EndIf

	FloatListAdd(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID, afValue)
	AdjustIntValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID, 1)

	Return True
EndFunction

Bool Function AddCallbackParameterForm(Int auiGroupID, Int auiEntryID, Form akValue)
	If(GetIntValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID) > 9)
		Exception.Warn("APPS", "Maximum number of arguments exceeded.", "Too many arguments for callback in function AddCallbackParameterForm")
		Return False
	EndIf

	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "The group with the ID " + auiGroupID + " doesn't exist.", "Invalid argument in function AddCallbackParameterForm")
		Return False
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + "." + auiGroupID) || !StringListGet(None, GROUPS + "." + auiGroupID, auiEntryID - 1))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function AddCallbackParameterForm")
		Return False
	EndIf

	FormListAdd(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID, akValue)
	AdjustIntValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID, 1)

	Return True
EndFunction

Bool Function AddCallbackParameterInt(Int auiGroupID, Int auiEntryID, Int aiValue)
	If(GetIntValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID) > 9)
		Exception.Warn("APPS", "Maximum number of arguments exceeded.", "Too many arguments for callback in function AddCallbackParameterInt")
		Return False
	EndIf

	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "The group with the ID " + auiGroupID + " doesn't exist.", "Invalid argument in function AddCallbackParameterInt")
		Return False
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + "." + auiGroupID) || !StringListGet(None, GROUPS + "." + auiGroupID, auiEntryID - 1))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function AddCallbackParameterInt")
		Return False
	EndIf

	IntListAdd(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID, aiValue)
	AdjustIntValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID, 1)

	Return True
EndFunction

Bool Function AddCallbackParameterString(Int auiGroupID, Int auiEntryID, String asValue)
	If(GetIntValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID) > 9)
		Exception.Warn("APPS", "Maximum number of arguments exceeded.", "Too many arguments for callback in function AddCallbackParameterString")
		Return False
	EndIf

	If(auiGroupID < 1 || auiGroupID > StringListCount(None, GROUPS) || !StringListGet(None, GROUPS, auiGroupID - 1))
		Exception.Warn("APPS", "The group with the ID " + auiGroupID + " doesn't exist.", "Invalid argument in function AddCallbackParameterString")
		Return False
	EndIf

	If(auiEntryID < 1 || auiEntryID > StringListCount(None, GROUPS + "." + auiGroupID) || !StringListGet(None, GROUPS + "." + auiGroupID, auiEntryID - 1))
		Exception.Warn("APPS", "The menu entry with the ID " + auiEntryID + " doesn't exist.", "Invalid argument in function AddCallbackParameterString")
		Return False
	EndIf

	StringListAdd(None, GROUP_CALLBACK_PARAMETERS + auiGroupID + "." + auiEntryID, asValue)
	AdjustIntValue(None, GROUP_CALLBACK + auiGroupID + "." + auiEntryID, 1)

	Return True
EndFunction

State MainMenuShown
	Event OnKeyUp(Int aiKeyCode, Float afHoldingTime)

	EndEvent

	Bool Function SetWheelMenuActive(Bool abIsActive = True)
		Exception.Warn("APPS", "Can't change the activation state of the wheel menu while it is open.", False)

		Return False
	EndFunction

	Function InteractiveMenu()
		Int i
		Int SelectedMenu
		String TempListKey
		String TempListLabelKey

		StringListClear(None, TEMP_XGROUPS)
		StringListClear(None, TEMP_XGROUPS_LBL)
		StringListClear(None, TEMP_GROUPS)
		StringListClear(None, TEMP_GROUPS_LBL)

		UIMenuBase WheelMenu = UIExtensions.GetMenu("UIWheelMenu")

		If(!WheelMenu)
			Exception.Throw("APPS", "UIExtensions is not properly installed or malfunctioning.", "Critical error")
			Return
		EndIf

		While(i < StringListCount(None, GROUPS))
			If(HasIntValue(None, GROUP_ISACTIVE + (i + 1)))
				If(HasIntValue(None, GROUP_ISEXCLUSIVE + (i + 1)))
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

	Bool Function SetWheelMenuActive(Bool abIsActive = True)
		Exception.Warn("APPS", "Can't change the activation state of the wheel menu while it is open.", False)

		Return False
	EndFunction

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
			EventHandle = ModEvent.Create(GetStringValue(None, GROUP_CALLBACK + ID + "." + (SelectedMenu + 1)))

			If(EventHandle)
				ModEvent.PushForm(EventHandle, Self)

				Int j

				While(j < FormListCount(None, GROUP_CALLBACK_PARAMETERS + ID + "." + (SelectedMenu + 1)))
					ModEvent.PushForm(EventHandle, FormListGet(None, GROUP_CALLBACK_PARAMETERS + ID + "." + (SelectedMenu + 1), j))

					j += 1
				EndWhile

				j = 0

				While(j < IntListCount(None, GROUP_CALLBACK_PARAMETERS + ID + "." + (SelectedMenu + 1)))
					ModEvent.PushInt(EventHandle, IntListGet(None, GROUP_CALLBACK_PARAMETERS + ID + "." + (SelectedMenu + 1), j))

					j += 1
				EndWhile

				j = 0

				While(j < FloatListCount(None, GROUP_CALLBACK_PARAMETERS + ID + "." + (SelectedMenu + 1)))
					ModEvent.PushFloat(EventHandle, FloatListGet(None, GROUP_CALLBACK_PARAMETERS + ID + "." + (SelectedMenu + 1), j))

					j += 1
				EndWhile

				j = 0

				While(j < StringListCount(None, GROUP_CALLBACK_PARAMETERS + ID + "." + (SelectedMenu + 1)))
					ModEvent.PushString(EventHandle, StringListGet(None, GROUP_CALLBACK_PARAMETERS + ID + "." + (SelectedMenu + 1), j))

					j += 1
				EndWhile

				ModEvent.Send(EventHandle)
			Else
				Exception.Throw("APPS", "Could not create an event handle, aborting!", "Unexpected exception")
			EndIf

			GoToState("")
		EndIf
	EndFunction
EndState
