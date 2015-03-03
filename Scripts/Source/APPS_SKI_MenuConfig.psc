Scriptname APPS_SKI_MenuConfig Extends SKI_ConfigBase
Import StorageUtil

String Property ANAL_MOD = "APPS.Settings.AnalModifier" AutoReadOnly Hidden
String Property AUTO_SAVE = "APPS.Settings.AutoSave" AutoReadOnly Hidden
String Property BASE_PAYMENT = "APPS.Settings.BasePayment" AutoReadOnly Hidden
String Property BASE_PAYMENT_WHORE = "APPS.Settings.BasePaymentWhore" AutoReadOnly Hidden
String Property DANCE_ORDERS_ACCEPTED = "APPS.Stats.DanceOrdersAccepted" AutoReadOnly Hidden
String Property DANCE_ORDERS_ACCEPTED_TOTAL = "APPS.Stats.DanceOrdersAccepted" AutoReadOnly Hidden
String Property DANCE_ORDERS_DECLINED = "APPS.Stats.DanceOrdersDeclined" AutoReadOnly Hidden
String Property DANCE_ORDERS_DECLINED_TOTAL = "APPS.Stats.DanceOrdersDeclined" AutoReadOnly Hidden
String Property DANCE_ORDERS_REQUESTED = "APPS.Stats.DanceOrdersRequested" AutoReadOnly Hidden
String Property DANCE_ORDERS_REQUESTED_TOTAL = "APPS.Stats.DanceOrdersRequestedTotal" AutoReadOnly Hidden
String Property DAYS_WORKED = "APPS.Stats.DaysWorked" AutoReadOnly Hidden
String Property DB_BONUS = "APPS.Settings.DragonbornBonus" AutoReadOnly Hidden
String Property FOOD_ORDERS_FAILED = "APPS.Stats.FoodOrdersFailed" AutoReadOnly Hidden
String Property FOOD_ORDERS_FAILED_TOTAL = "APPS.Stats.FoodOrdersFailedTotal" AutoReadOnly Hidden
String Property FOOD_ORDERS_REQUESTED = "APPS.Stats.FoodOrdersRequested" AutoReadOnly Hidden
String Property FOOD_ORDERS_REQUESTED_TOTAL = "APPS.Stats.FoodOrdersRequestedTotal" AutoReadOnly Hidden
String Property FOOD_ORDERS_SUCCEEDED = "APPS.Stats.FoodOrdersSucceeded" AutoReadOnly Hidden
String Property FOOD_ORDERS_SUCCEEDED_TOTAL = "APPS.Stats.FoodOrdersSucceededTotal" AutoReadOnly Hidden
String Property GUESTS_HAPPY = "APPS.Stats.GuestsHappy" AutoReadOnly Hidden
String Property GUESTS_HAPPY_TOTAL = "APPS.Stats.GuestsHappyTotal" AutoReadOnly Hidden
String Property GUESTS_SERVED = "APPS.Stats.GuestsServed" AutoReadOnly Hidden
String Property GUESTS_SERVED_TOTAL = "APPS.Stats.GuestsServedTotal" AutoReadOnly Hidden
String Property GUESTS_UNHAPPY = "APPS.GuestsUnhappy" AutoReadOnly Hidden
String Property GUESTS_UNHAPPY_TOTAL = "APPS.Stats.GuestsUnhappyTotal" AutoReadOnly Hidden
String Property HOURS_TO_WORK = "APPS.Settings.HoursToWork" AutoReadOnly Hidden
String Property HOURS_TO_WORK_EXPECTED = "APPS.Settings.HoursToWorkExpected" AutoReadOnly Hidden
String Property MAX_DANCE_REWARD = "APPS.Settings.MaxDanceReward" AutoReadOnly Hidden
String Property MIN_DANCE_REWARD = "APPS.Settings.MinDanceReward" AutoReadOnly Hidden
String Property MAX_TIP = "APPS.Settings.MaxTip" AutoReadOnly Hidden
String Property MAX_TIP_SC = "APPS.Settings.MaxTipSC" AutoReadOnly Hidden
String Property MIN_TIP = "APPS.Settings.MinTip" AutoReadOnly Hidden
String Property MIN_TIP_SC = "APPS.Settings.MinTipSC" AutoReadOnly Hidden
String Property ORAL_MOD = "APPS.Settings.OralModifier" AutoReadOnly Hidden
String Property SEX_ORDERS_ACCEPTED = "APPS.Stats.SexOrdersAccepted" AutoReadOnly Hidden
String Property SEX_ORDERS_ACCEPTED_TOTAL = "APPS.Stats.SexOrdersAcceptedTotal" AutoReadOnly Hidden
String Property SEX_ORDERS_DECLINED = "APPS.Stats.SexOrdersDeclined" AutoReadOnly Hidden
String Property SEX_ORDERS_DECLINED_TOTAL = "APPS.Stats.SexOrdersDeclinedTotal" AutoReadOnly Hidden
String Property SEX_ORDERS_REQUESTED = "APPS.Stats.SexOrdersRequested" AutoReadOnly Hidden
String Property SEX_ORDERS_REQUESTED_TOTAL = "APPS.Stats.SexOrdersRequestedTotal" AutoReadOnly Hidden
String Property VAGINAL_MOD = "APPS.Settings.VaginalModifier" AutoReadOnly Hidden
String Property WHORE_MOD = "APPS.Settings.WhoreModifier" AutoReadOnly Hidden
String Property WORLD = "APPS.Settings.World" AutoReadOnly Hidden

;-------------------------------------------------------
;	SKI control refs
;-------------------------------------------------------
String[] DifficultyList
String[] WorldSettingList
Int[] OptionFlag
Int AnalModSlider
Int AutoSaveToggle
Int DifficultyMenu
Int DragonbornBonusSlider
Int DynamicInteraction
Int HoursToWorkSlider
Int MaxTipSlider
Int MaxTipSCSlider
Int MinTipSlider
Int MinTipSCSlider
Int OralModSlider
Int PaymentSlider
Int VaginalModSlider
Int WhoreBasePaymentSlider
Int WhoreModSlider
Int WorldSettingMenu

;-------------------------------------------------------
;	SKI control boundary variables
;-------------------------------------------------------
Int iDifficultyChoice = 1
Int iWorldSettingChoice = 1
Float fMinWork = 2.00
Float fMaxWork = 12.00
Float fMinTip = 0.00
Float fMaxTip = 0.25
Float fMinTipSC = 0.05
Float fMaxTipSC = 0.40
Float fMinPayment = 1.00
Float fMaxPayment = 25.00
Float fMinWhoreBasePayment = 10.00
Float fMaxWhoreBasePayment = 50.00
Float fMinWhoreMod = 50.00
Float fMaxWhoreMod = 250.00
Float fMinDragonBornBonus = 0.00
Float fMaxDragonbornBonus = 100.00
Float fMinAnalMod = 15.00
Float fMaxAnalMod = 125.00
Float fMinOralMod = 5.00
Float fMaxOralMod = 115.00
Float fMinVaginalMod = 10.00
Float fMaxVaginalMod = 120.00

Event OnInit()
	If(!Self.IsRunning())
		Return
	EndIf

	SetIntValue(None, AUTO_SAVE, 1)
	SetIntValue(None, HOURS_TO_WORK, 8)
	SetIntValue(None, HOURS_TO_WORK_EXPECTED, 4)
	SetFloatValue(None, MIN_TIP, 0.05)
	SetFloatValue(None, MAX_TIP, 0.10)
	SetFloatValue(None, MIN_TIP_SC, 0.10)
	SetFloatValue(None, MAX_TIP_SC, 0.20)
	SetIntValue(None, BASE_PAYMENT, 15)
	SetIntValue(None, BASE_PAYMENT_WHORE, 20)
	SetFloatValue(None, WHORE_MOD, 1.00)
	SetFloatValue(None, DB_BONUS, 0.15)
	SetFloatValue(None, ANAL_MOD, 0.50)
	SetFloatValue(None, ORAL_MOD, 0.25)
	SetFloatValue(None, VAGINAL_MOD, 1.00)

	Parent.OnInit()
EndEvent

;-------------------------------------------------------
;	SKI page setup event
;-------------------------------------------------------
Event OnConfigInit()
	Pages = New String[4]
	Pages[0] = "$GENERAL_PAGE"
	Pages[1] = "$TAVERNJOB_PAGE"
	Pages[2] = "$WHOREJOB_PAGE"
	Pages[3] = "$STAT_PAGE"

	DifficultyList = New String[4]
	DifficultyList[0] = "$DIFF_EASY"
	DifficultyList[1] = "$DIFF_MEDIUM"
	DifficultyList[2] = "$DIFF_HARD"
	DifficultyList[3] = "$DIFF_INDIE"
	
	WorldSettingList = New String[2]
	WorldSettingList[0] = "$AMBI"
	WorldSettingList[1] = "$HETERO"
	
	OptionFlag = New Int[4]
	OptionFlag[0] = OPTION_FLAG_DISABLED
	OptionFlag[1] = OPTION_FLAG_DISABLED
	OptionFlag[2] = OPTION_FLAG_DISABLED
	OptionFlag[3] = OPTION_FLAG_NONE
EndEvent

;-------------------------------------------------------
;	SKI page control setup event
;-------------------------------------------------------
Event OnPageReset(string Page)
	If(Page == Pages[0])
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$GLOBAL_SETTINGS")
		DifficultyMenu = AddMenuOption("$DIFFICULTY", DifficultyList[iDifficultyChoice])
		AutoSaveToggle = AddToggleOption("$AUTOSAVE_ON", GetIntValue(None, AUTO_SAVE))
		WorldSettingMenu = AddMenuOption("$WORLD_SETTING", WorldSettingList[iWorldSettingChoice])
		DynamicInteraction = AddKeymapOption("$DYNAMIC_INTERACTION", GetIntValue(None, "APPS.KeyMap.DynamicInteraction"))
	ElseIf(Page == Pages[1])
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$TAVERN_JOB", OptionFlag[iDifficultyChoice])
		HoursToWorkSlider = AddSliderOption("$HOURS_TO_WORK", GetIntValue(None, HOURS_TO_WORK), "{0}", OptionFlag[iDifficultyChoice])
		PaymentSlider = AddSliderOption("$PAYMENT_PER_HOUR", GetIntValue(None, BASE_PAYMENT), "{0} Gold", OptionFlag[iDifficultyChoice])
		AddHeaderOption("$TIP", OptionFlag[iDifficultyChoice])
		MinTipSlider = AddSliderOption("$MIN_TIP", GetFloatValue(None, MIN_TIP) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		MaxTipSlider = AddSliderOption("$MAX_TIP", GetFloatValue(None, MAX_TIP) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		AddEmptyOption()
		MinTipSCSlider = AddSliderOption("$MIN_TIP_BONUS", GetFloatValue(None, MIN_TIP_SC) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		MaxTipSCSlider = AddSliderOption("$MAX_TIP_BONUS", GetFloatValue(None, MIN_TIP_SC) * 100, "{0}%", OptionFlag[iDifficultyChoice])
	ElseIf(Page == Pages[2])
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$WHORE_BASE_PAYMENT", OptionFlag[iDifficultyChoice])
		SetCursorPosition(2)
		WhoreBasePaymentSlider = AddSliderOption("$WHORE_BASE", GetIntValue(None, BASE_PAYMENT_WHORE), "{0} Gold", OptionFlag[iDifficultyChoice])
		SetCursorPosition(4)
		AddHeaderOption("$SEX_MOD_SERVICES")
		SetCursorPosition(6)
		WhoreModSlider = AddSliderOption("$WHORE_BASE_MOD", GetFloatValue(None, WHORE_MOD) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(8)
		DragonbornBonusSlider = AddSliderOption("$DRAGONBORN_BONUS", GetFloatValue(None, DB_BONUS) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(1)
		AddHeaderOption("$SEX_MODS", OptionFlag[iDifficultyChoice])
		SetCursorPosition(3)
		AnalModSlider = AddSliderOption("$ANAL_MOD", GetFloatValue(None, ANAL_MOD) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(5)
		OralModSlider = AddSliderOption("$ORAL_MOD", GetFloatValue(None, ORAL_MOD) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(7)
		VaginalModSlider = AddSliderOption("$VAGINAL_MOD", GetFloatValue(None, VAGINAL_MOD) * 100, "{0}%", OptionFlag[iDifficultyChoice])
	ElseIf(Page == Pages[3])
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$TOTAL")
		SetCursorPosition(2)
		AddTextOption("$DAYS_WORKED", GetIntValue(None, DAYS_WORKED))
		SetCursorPosition(4)
		AddTextOption("$GUESTS_SERVED", GetIntValue(None, GUESTS_SERVED_TOTAL))
		SetCursorPosition(6)
		AddTextOption("$GUESTS_HAPPY", GetIntValue(None, GUESTS_HAPPY_TOTAL))
		SetCursorPosition(8)
		AddTextOption("$GUESTS_UNHAPPY", GetIntValue(None, GUESTS_UNHAPPY_TOTAL))
		SetCursorPosition(10)
		AddHeaderOption("$FOODORDERS")
		SetCursorPosition(12)
		AddTextOption("$REQUESTED", GetIntValue(None, FOOD_ORDERS_REQUESTED_TOTAL))
		SetCursorPosition(14)
		AddTextOption("$SUCCEEDED", GetIntValue(None, FOOD_ORDERS_SUCCEEDED_TOTAL))
		SetCursorPosition(16)
		AddTextOption("$FAILED", GetIntValue(None, FOOD_ORDERS_FAILED_TOTAL))
		SetCursorPosition(18)
		AddHeaderOption("$SEXORDERS")
		SetCursorPosition(20)
		AddTextOption("$REQUESTED", GetIntValue(None, SEX_ORDERS_REQUESTED_TOTAL))
		SetCursorPosition(22)
		AddTextOption("$ACCEPTED", GetIntValue(None, SEX_ORDERS_ACCEPTED_TOTAL))
		SetCursorPosition(24)
		AddTextOption("$DECLINED", GetIntValue(None, SEX_ORDERS_DECLINED_TOTAL))
		SetCursorPosition(26)
		AddHeaderOption("$DANCEORDERS")
		SetCursorPosition(28)
		AddTextOption("$REQUESTED", GetIntValue(None, DANCE_ORDERS_REQUESTED_TOTAL))
		SetCursorPosition(30)
		AddTextOption("$ACCEPTED", GetIntValue(None, DANCE_ORDERS_ACCEPTED_TOTAL))
		SetCursorPosition(32)
		AddTextOption("$DECLINED", GetIntValue(None, DANCE_ORDERS_DECLINED_TOTAL))
		SetCursorPosition(3)
		AddHeaderOption("$THIS_SHIFT")
		SetCursorPosition(5)
		AddTextOption("$GUESTS_SERVED", GetIntValue(None, GUESTS_SERVED))
		SetCursorPosition(7)
		AddTextOption("$GUESTS_HAPPY", GetIntValue(None, GUESTS_HAPPY))
		SetCursorPosition(9)
		AddTextOption("$GUESTS_UNHAPPY", GetIntValue(None, GUESTS_UNHAPPY))
		SetCursorPosition(11)
		AddHeaderOption("$FOODORDERS")
		SetCursorPosition(13)
		AddTextOption("$REQUESTED", GetIntValue(None, FOOD_ORDERS_REQUESTED))
		SetCursorPosition(15)
		AddTextOption("$SUCCEEDED", GetIntValue(None, FOOD_ORDERS_SUCCEEDED))
		SetCursorPosition(17)
		AddTextOption("$FAILED", GetIntValue(None, FOOD_ORDERS_FAILED))
		SetCursorPosition(19)
		AddHeaderOption("$SEXORDERS")
		SetCursorPosition(21)
		AddTextOption("$REQUESTED", GetIntValue(None, SEX_ORDERS_REQUESTED))
		SetCursorPosition(23)
		AddTextOption("$ACCEPTED", GetIntValue(None, SEX_ORDERS_ACCEPTED))
		SetCursorPosition(25)
		AddTextOption("$DECLINED", GetIntValue(None, SEX_ORDERS_DECLINED))
		SetCursorPosition(27)
		AddHeaderOption("$DANCEORDERS")
		SetCursorPosition(29)
		AddTextOption("$REQUESTED", GetIntValue(None, DANCE_ORDERS_REQUESTED))
		SetCursorPosition(31)
		AddTextOption("$ACCEPTED", GetIntValue(None, DANCE_ORDERS_ACCEPTED))
		SetCursorPosition(33)
		AddTextOption("$DECLINED", GetIntValue(None, DANCE_ORDERS_DECLINED))
	EndIf
EndEvent

;-------------------------------------------------------
;	SKI control help event
;-------------------------------------------------------
Event OnOptionHighlight(Int Entry)
	If(Entry == DifficultyMenu)
		SetInfoText("$EXPLAIN_DIFFICULTY")
	ElseIf(Entry == AutoSaveToggle)
		SetInfoText("$EXPLAIN_AUTOSAVE")
	ElseIf(Entry == WorldSettingMenu)
		SetInfoText("$EXPLAIN_WORLD_SETTING")
	ElseIf(Entry == HoursToWorkSlider)
		SetInfoText("$EXPLAIN_HOURS_TO_WORK")
	ElseIf(Entry == PaymentSlider)
		SetInfoText("$EXPLAIN_PAYMENT")
	ElseIf(Entry == MinTipSlider || Entry == MaxTipSlider)
		SetInfoText("$EXPLAIN_TIP")
	ElseIf(Entry == MinTipSCSlider || Entry == MaxTipSCSlider)
		SetInfoText("$EXPLAIN_TIP_SC")
	ElseIf(Entry == WhoreBasePaymentSlider)
		SetInfoText("$EXPLAIN_WHORE_BASE_PAYMENT")
	ElseIf(Entry == WhoreModSlider)
		SetInfoText("$EXPLAIN_WHORE_MOD")
	ElseIf(Entry == DragonbornBonusSlider)
		SetInfoText("$EXPLAIN_DRAGONBORN_BONUS")
	ElseIf(Entry == AnalModSlider)
		SetInfoText("$EXPLAIN_ANAL_MOD")
	ElseIf(Entry == OralModSlider)
		SetInfoText("$EXPLAIN_ORAL_MOD")
	ElseIf(Entry == VaginalModSlider)
		SetInfoText("$EXPLAIN_VAGINAL_MOD")
	EndIf
EndEvent

;-------------------------------------------------------
;	SKI page option control events
;-------------------------------------------------------
Event OnOptionMenuOpen(Int SelectedOption)
	If(SelectedOption == DifficultyMenu)
		SetMenuDialogStartIndex(iDifficultyChoice)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(DifficultyList)
	ElseIf(SelectedOption == WorldSettingMenu)
		SetMenuDialogStartIndex(iWorldSettingChoice)
		SetMenuDialogDefaultIndex(1)
		SetMenuDialogOptions(WorldSettingList)
	EndIf
EndEvent

Event OnOptionMenuAccept(Int SelectedMenu, Int SelectedOption)
	If(SelectedMenu == DifficultyMenu)
		iDifficultyChoice = SelectedOption
		SetMenuOptionValue(SelectedMenu, DifficultyList[iDifficultyChoice])
		LoadPreset(iDifficultyChoice)
	ElseIf(SelectedMenu == WorldSettingMenu)
		iWorldSettingChoice = SelectedOption
		SetMenuOptionValue(SelectedMenu, WorldSettingList[iWorldSettingChoice])
		SetIntValue(None, WORLD, SelectedOption)
	EndIf
EndEvent

;-------------------------------------------------------
;	SKI toggle control events
;-------------------------------------------------------
Event OnOptionSelect(int SelectedToggle)
	If(SelectedToggle == AutoSaveToggle)
		If(GetIntValue(None, AUTO_SAVE) == 0)
			SetIntValue(None, AUTO_SAVE, 1)
			SetToggleOptionValue(AutoSaveToggle, True)
		Else
			SetIntValue(None, AUTO_SAVE, 0)
			SetToggleOptionValue(AutoSaveToggle, False)
		EndIf
	EndIf
EndEvent
			
;-------------------------------------------------------
;	SKI slider control events
;-------------------------------------------------------
Event OnOptionSliderOpen(Int SelectedSlider)
	If(SelectedSlider == HoursToWorkSlider)
		SetSliderDialogStartValue(GetIntValue(None, HOURS_TO_WORK))
		SetSliderDialogDefaultValue(GetIntValue(None, HOURS_TO_WORK))
		SetSliderDialogRange(fMinWork, fMaxWork)
		SetSliderDialogInterval(2)
	ElseIf(SelectedSlider == MinTipSlider)
		SetSliderDialogStartValue(GetFloatValue(None, MIN_TIP) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, MIN_TIP) * 100)
		SetSliderDialogRange(fMinTip * 100, fMaxTip * 100 - 5)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == MaxTipSlider)
		SetSliderDialogStartValue(GetFloatValue(None, MAX_TIP) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, MAX_TIP) * 100)
		SetSliderDialogRange(fMinTip * 100 + 5,fMaxTip * 100)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == MinTipSCSlider)
		SetSliderDialogStartValue(GetFloatValue(None, MIN_TIP_SC) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, MIN_TIP_SC) * 100)
		SetSliderDialogRange(fMinTipSC * 100, fMaxTipSC * 100 - 5)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == MaxTipSCSlider)
		SetSliderDialogStartValue(GetFloatValue(None, MAX_TIP_SC) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, MAX_TIP_SC) * 100)
		SetSliderDialogRange(fMinTipSC * 100 + 5, fMaxTipSC * 100)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == PaymentSlider)
		SetSliderDialogStartValue(GetIntValue(None, BASE_PAYMENT))
		SetSliderDialogDefaultValue(GetIntValue(None, BASE_PAYMENT))
		SetSliderDialogRange(fMinPayment, fMaxPayment)
		SetSliderDialogInterval(1)
	ElseIf(SelectedSlider == WhoreBasePaymentSlider)
		SetSliderDialogStartValue(GetIntValue(None, BASE_PAYMENT_WHORE))
		SetSliderDialogDefaultValue(GetIntValue(None, BASE_PAYMENT_WHORE))
		SetSliderDialogRange(fMinWhoreBasePayment, fMaxWhoreBasePayment)
		SetSliderDialogInterval(1)
	ElseIf(SelectedSlider == WhoreModSlider)
		SetSliderDialogStartValue(GetFloatValue(None, WHORE_MOD) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, WHORE_MOD) * 100)
		SetSliderDialogRange(fMinWhoreMod, fMaxWhoreMod)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == DragonbornBonusSlider)
		SetSliderDialogStartValue(GetFloatValue(None, DB_BONUS) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, DB_BONUS) * 100)
		SetSliderDialogRange(fMinDragonbornBonus, fMaxDragonbornBonus)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == AnalModSlider)
		SetSliderDialogStartValue(GetFloatValue(None, ANAL_MOD) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, ANAL_MOD) * 100)
		SetSliderDialogRange(fMinAnalMod, fMaxAnalMod)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == OralModSlider)
		SetSliderDialogStartValue(GetFloatValue(None, ORAL_MOD) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, ORAL_MOD) * 100)
		SetSliderDialogRange(fMinOralMod, fMaxOralMod)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == VaginalModSlider)
		SetSliderDialogStartValue(GetFloatValue(None, VAGINAL_MOD) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, VAGINAL_MOD) * 100)
		SetSliderDialogRange(fMinVaginalMod, fMaxVaginalMod)
		SetSliderDialogInterval(5)
	EndIf
EndEvent

Event OnOptionSliderAccept(Int SelectedSlider, Float Value)
		If(SelectedSlider == HoursToWorkSlider)
			SetIntValue(None, HOURS_TO_WORK, Value As Int)
			SetIntValue(None, HOURS_TO_WORK_EXPECTED, (Value / 2) As Int)
			SetSliderOptionValue(HoursToWorkSlider, Value)
		ElseIf(SelectedSlider == PaymentSlider)
			SetIntValue(None, BASE_PAYMENT, Value As Int)
			SetSliderOptionValue(PaymentSlider, Value, "{0} Gold")
		ElseIf(SelectedSlider == MinTipSlider)
			SetFloatValue(None, MIN_TIP, Value / 100)
			SetSliderOptionValue(MinTipSlider, Value, "{0}%")
			
			If(Value / 100 >= GetFloatValue(None, MAX_TIP))
				SetFloatValue(None, MAX_TIP, Value / 100 + 0.05)
				SetSliderOptionValue(MaxTipSlider, Value + 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == MaxTipSlider)
			SetFloatValue(None, MAX_TIP, Value / 100)
			SetSliderOptionValue(MaxTipSlider, Value, "{0}%")

			If(Value / 100 <= GetFloatValue(None, MIN_TIP))
				SetFloatValue(None, MIN_TIP, Value / 100 - 0.05)
				SetSliderOptionValue(MinTipSlider, Value - 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == MinTipSCSlider)
			SetFloatValue(None, MIN_TIP_SC, Value / 100)
			SetSliderOptionValue(MinTipSCSlider, Value, "{0}%")
			
			If(Value / 100 >= GetFloatValue(None, MAX_TIP_SC))
				SetFloatValue(None, MAX_TIP_SC, Value / 100 + 0.05)
				SetSliderOptionValue(MaxTipSCSlider, Value + 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == MaxTipSCSlider)
			SetFloatValue(None, MAX_TIP_SC, Value / 100)
			SetSliderOptionValue(MaxTipSCSlider, Value + 5, "{0}%")
			
			If(Value / 100 <= GetFloatValue(None, MIN_TIP_SC))
				SetFloatValue(None, MIN_TIP_SC, Value / 100 - 0.05)
				SetSliderOptionValue(MinTipSCSlider, Value - 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == WhoreBasePaymentSlider)
			SetIntValue(None, BASE_PAYMENT_WHORE, Value As Int)
			SetSliderOptionValue(WhoreBasePaymentSlider, Value, "{0} Gold")
		ElseIf(SelectedSlider == WhoreModSlider)
			SetFloatValue(None, WHORE_MOD, Value / 100)
			SetSliderOptionValue(WhoreModSlider, Value, "{0}%")
		ElseIf(SelectedSlider == DragonbornBonusSlider)
			SetFloatValue(None, DB_BONUS, Value / 100)
			SetSliderOptionValue(DragonbornBonusSlider, Value, "{0}%")
		ElseIf(SelectedSlider == AnalModSlider)
			SetFloatValue(None, ANAL_MOD, Value / 100)
			SetSliderOptionValue(AnalModSlider, Value, "{0}%")
			
			If(Value / 100 <= GetFloatValue(None, VAGINAL_MOD))
				SetFloatValue(None, VAGINAL_MOD, (Value - 5 ) / 100)
				SetSliderOptionValue(VaginalModSlider, Value - 5, "{0}%")
			EndIf
			
			If(Value / 100 <= GetFloatValue(None, ORAL_MOD))
				SetFloatValue(None, ORAL_MOD, (Value - 10) / 100)
				SetSliderOptionValue(OralModSlider, Value - 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == OralModSlider)
			SetFloatValue(None, ORAL_MOD, Value / 100)
			SetSliderOptionValue(OralModSlider, Value, "{0}%")
			
			If(Value / 100 >= GetFloatValue(None, VAGINAL_MOD))
				SetFloatValue(None, VAGINAL_MOD, (Value + 5) / 100)
				SetSliderOptionValue(VaginalModSlider, Value + 5, "{0}%")
			EndIf

			If(Value / 100 >= GetFloatValue(None, ANAL_MOD))
				SetFloatValue(None, ANAL_MOD, (Value + 5) / 100)
				SetSliderOptionValue(AnalModSlider, Value + 10, "{0}%")
			EndIf
		ElseIf(SelectedSlider == VaginalModSlider)
			SetFloatValue(None, VAGINAL_MOD, Value / 100)
			SetSliderOptionValue(VaginalModSlider, Value, "{0}%")
			
			If(Value / 100 >= GetFloatValue(None, ANAL_MOD))
				SetFloatValue(None, ANAL_MOD, (Value + 5) / 100)
				SetSliderOptionValue(AnalModSlider, Value + 5, "{0}%")
			ElseIf(Value / 100 <= GetFloatValue(None, ORAL_MOD))
				SetFloatValue(None, ORAL_MOD, (Value - 5) / 100)
				SetSliderOptionValue(OralModSlider, Value - 5, "{0}%")
			EndIf
		EndIf
EndEvent

;-------------------------------------------------------
;	SKI keymapping events
;-------------------------------------------------------
Event OnOptionKeyMapChange(Int aiOption, Int aiNewKeyCode, String asConflictControl, String asConflictName)
	Bool Continue
	Int EventHandle
	String ConflictMessage

	If(asConflictControl != "")
		If(asConflictName != "")
			ConflictMessage = "$CONFLICT_KEY_MSG{" + asConflictControl + " (" + asConflictName + ")}"
		Else
			ConflictMessage = "$CONFLICT_KEY_MSG{" + asConflictControl + "}"
		EndIf

		Continue = ShowMessage(ConflictMessage, True, "$YES", "SNO")

		If(!Continue)
			Return
		EndIf
	EndIf

	SetIntValue(None, "APPS.KeyMap.DynamicInteraction", aiNewKeyCode)
	SetKeyMapOptionValue(DynamicInteraction, aiNewKeyCode)

	EventHandle = ModEvent.Create("APPS_MapKey")

	If(EventHandle)
		ModEvent.PushForm(EventHandle, Self)
		ModEvent.PushInt(EventHandle, aiNewKeyCode)
		ModEvent.Send(EventHandle)
	EndIf
EndEvent

;-------------------------------------------------------
;	Custom events
;-------------------------------------------------------
Function LoadPreset(Int Difficulty)
	If(Difficulty == 0)
		SetIntValue(None, AUTO_SAVE, 1)
		SetToggleOptionValue(AutoSaveToggle, True)
		SetIntValue(None, HOURS_TO_WORK, 6)
		SetIntValue(None, HOURS_TO_WORK_EXPECTED, 3)
		SetFloatValue(None, MIN_TIP, 0.10)
		SetFloatValue(None, MAX_TIP, 0.15)
		SetFloatValue(None, MIN_TIP_SC, 0.15)
		SetFloatValue(None, MAX_TIP_SC, 0.25)
		SetIntValue(None, BASE_PAYMENT, 20)
		SetIntValue(None, BASE_PAYMENT_WHORE, 30)
		SetFloatValue(None, WHORE_MOD, 1.25)
		SetFloatValue(None, DB_BONUS, 0.25)
		SetFloatValue(None, ANAL_MOD, 0.60)
		SetFloatValue(None, ORAL_MOD, 0.30)
		SetFloatValue(None, VAGINAL_MOD, 1.20)
	ElseIf(Difficulty == 1)
		SetIntValue(None, AUTO_SAVE, 1)
		SetToggleOptionValue(AutoSaveToggle, True)
		SetIntValue(None, HOURS_TO_WORK, 8)
		SetIntValue(None, HOURS_TO_WORK_EXPECTED, 4)
		SetFloatValue(None, MIN_TIP, 0.05)
		SetFloatValue(None, MAX_TIP, 0.10)
		SetFloatValue(None, MIN_TIP_SC, 0.10)
		SetFloatValue(None, MAX_TIP_SC, 0.20)
		SetIntValue(None, BASE_PAYMENT, 15)
		SetIntValue(None, BASE_PAYMENT_WHORE, 20)
		SetFloatValue(None, WHORE_MOD, 1.00)
		SetFloatValue(None, DB_BONUS, 0.15)
		SetFloatValue(None, ANAL_MOD, 0.50)
		SetFloatValue(None, ORAL_MOD, 0.25)
		SetFloatValue(None, VAGINAL_MOD, 1.00)
	ElseIf(Difficulty == 2)
		SetIntValue(None, AUTO_SAVE, 0)
		SetToggleOptionValue(AutoSaveToggle, True)
		SetIntValue(None, HOURS_TO_WORK, 10)
		SetIntValue(None, HOURS_TO_WORK_EXPECTED, 5)
		SetFloatValue(None, MIN_TIP, 0.00)
		SetFloatValue(None, MAX_TIP, 0.05)
		SetFloatValue(None, MIN_TIP_SC, 0.05)
		SetFloatValue(None, MAX_TIP_SC, 0.15)
		SetIntValue(None, BASE_PAYMENT, 10)
		SetIntValue(None, BASE_PAYMENT_WHORE, 10)
		SetFloatValue(None, WHORE_MOD, 0.75)
		SetFloatValue(None, DB_BONUS, 0.05)
		SetFloatValue(None, ANAL_MOD, 0.40)
		SetFloatValue(None, ORAL_MOD, 0.20)
		SetFloatValue(None, VAGINAL_MOD, 0.80)
	EndIf
EndFunction