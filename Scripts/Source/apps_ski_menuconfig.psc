Scriptname APPS_SKI_MenuConfig Extends SKI_ConfigBase
Import StorageUtil

String AutoSave = "APPS.Settings.AutoSave"
String HoursToWork = "APPS.Settings.HoursToWork"
String HoursToWorkExpected = "APPS.Settings.HoursToWorkExpected"
String MinTip = "APPS.Settings.MinTip"
String MaxTip = "APPS.Settings.MaxTip"
String MinTipSC = "APPS.Settings.MinTipSC"
String MaxTipSC = "APPS.Settings.MaxTipSC"
String Payment = "APPS.Settings.Payment"
String WhoreBasePayment = "APPS.Settings.WhoreBasePayment"
String WhoreMod = "APPS.Settings.WhoreMod"
String DragonbornBonus = "APPS.Settings.DragonbornBonus"
String AnalMod = "APPS.Settings.AnalMod"
String OralMod = "APPS.Settings.OralMod"
String VaginalMod = "APPS.Settings.VaginalMod"
String WorldSetting = "APPS.Settings.WorldSetting"
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
		AutoSaveToggle = AddToggleOption("$AUTOSAVE_ON", HasIntValue(None, AutoSave))
		WorldSettingMenu = AddMenuOption("$WORLD_SETTING", WorldSettingList[iWorldSettingChoice])
	ElseIf(Page == Pages[1])
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$TAVERN_JOB", OptionFlag[iDifficultyChoice])
		HoursToWorkSlider = AddSliderOption("$HOURS_TO_WORK", GetIntValue(None, HoursToWork), "{0}", OptionFlag[iDifficultyChoice])
		PaymentSlider = AddSliderOption("$PAYMENT_PER_HOUR", GetIntValue(None, Payment), "{0} Gold", OptionFlag[iDifficultyChoice])
		AddHeaderOption("$TIP", OptionFlag[iDifficultyChoice])
		MinTipSlider = AddSliderOption("$MIN_TIP", GetIntValue(None, MinTip) * 5, "{0}%", OptionFlag[iDifficultyChoice])
		MaxTipSlider = AddSliderOption("$MAX_TIP", GetIntValue(None, MaxTip) * 5, "{0}%", OptionFlag[iDifficultyChoice])
		AddEmptyOption()
		MinTipSCSlider = AddSliderOption("$MIN_TIP_BONUS", GetIntValue(None, MinTipSC) * 5, "{0}%", OptionFlag[iDifficultyChoice])
		MaxTipSCSlider = AddSliderOption("$MAX_TIP_BONUS", GetIntValue(None, MaxTipSC) * 5, "{0}%", OptionFlag[iDifficultyChoice])
	ElseIf(Page == Pages[2])
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$WHORE_BASE_PAYMENT", OptionFlag[iDifficultyChoice])
		SetCursorPosition(2)
		WhoreBasePaymentSlider = AddSliderOption("$WHORE_BASE", GetIntValue(None, WhoreBasePayment), "{0} Gold", OptionFlag[iDifficultyChoice])
		SetCursorPosition(4)
		AddHeaderOption("$SEX_MOD_SERVICES")
		SetCursorPosition(6)
		WhoreModSlider = AddSliderOption("$WHORE_BASE_MOD", GetFloatValue(None, WhoreMod) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(8)
		DragonbornBonusSlider = AddSliderOption("$DRAGONBORN_BONUS", GetFloatValue(None, DragonbornBonus) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(1)
		AddHeaderOption("$SEX_MODS", OptionFlag[iDifficultyChoice])
		SetCursorPosition(3)
		AnalModSlider = AddSliderOption("$ANAL_MOD", GetFloatValue(None, AnalMod) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(5)
		OralModSlider = AddSliderOption("$ORAL_MOD", GetFloatValue(None, OralMod) * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(7)
		VaginalModSlider = AddSliderOption("$VAGINAL_MOD", GetFloatValue(None, VaginalMod) * 100, "{0}%", OptionFlag[iDifficultyChoice])
	ElseIf(Page == Pages[3])
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$TOTAL")
		SetCursorPosition(2)
		AddTextOption("$DAYS_WORKED", GetIntValue(None, "APPS.Stats.DaysWorked"))
		SetCursorPosition(4)
		AddTextOption("$GUESTS_SERVED", GetIntValue(None, "APPS.Stats.TotalGuestsServed"))
		SetCursorPosition(6)
		AddTextOption("$GUESTS_HAPPY", GetIntValue(None, "APPS.TotalGuestsHappy"))
		SetCursorPosition(8)
		AddTextOption("$GUESTS_UNHAPPY", GetIntValue(None, "APPS.TotalGuestsUnhappy"))
		SetCursorPosition(10)
		AddHeaderOption("$FOODORDERS")
		SetCursorPosition(12)
		AddTextOption("$REQUESTED", GetIntValue(None, "APPS.TotalFoodOrdersRequested"))
		SetCursorPosition(14)
		AddTextOption("$SUCCEEDED", GetIntValue(None,"APPS.TotalFoodOrdersSucceeded"))
		SetCursorPosition(16)
		AddTextOption("$FAILED", GetIntValue(None,"APPS.TotalFoodOrdersFailed"))
		SetCursorPosition(18)
		AddHeaderOption("$SEXORDERS")
		SetCursorPosition(20)
		AddTextOption("$REQUESTED", GetIntValue(None, "APPS.TotalSexOrdersRequested"))
		SetCursorPosition(22)
		AddTextOption("$ACCEPTED", GetIntValue(None, "APPS.TotalSexOrdersAccepted"))
		SetCursorPosition(24)
		AddTextOption("$DECLINED", GetIntValue(None, "APPS.TotalSexOrdersDeclined"))
		SetCursorPosition(26)
		AddHeaderOption("$DANCEORDERS")
		SetCursorPosition(28)
		AddTextOption("$REQUESTED", GetIntValue(None, "APPS.TotalDanceOrdersRequested"))
		SetCursorPosition(30)
		AddTextOption("$ACCEPTED", GetIntValue(None, "APPS.TotalDanceOrdersAccepted"))
		SetCursorPosition(32)
		AddTextOption("$DECLINED", GetIntValue(None, "APPS.TotalDanceOrdersDeclined"))
		SetCursorPosition(3)
		AddHeaderOption("$THIS_SHIFT")
		SetCursorPosition(5)
		AddTextOption("$GUESTS_SERVED", GetIntValue(None, "APPS.GuestsServed"))
		SetCursorPosition(7)
		AddTextOption("$GUESTS_HAPPY", GetIntValue(None, "APPS.GuestsHappy"))
		SetCursorPosition(9)
		AddTextOption("$GUESTS_UNHAPPY", GetIntValue(None, "APPS.GuestsUnhappy"))
		SetCursorPosition(11)
		AddHeaderOption("$FOODORDERS")
		SetCursorPosition(13)
		AddTextOption("$REQUESTED", GetIntValue(None, "APPS.TotalFoodOrdersRequested"))
		SetCursorPosition(15)
		AddTextOption("$SUCCEEDED", GetIntValue(None, "APPS.TotalFoodOrdersSucceeded"))
		SetCursorPosition(17)
		AddTextOption("$FAILED", GetIntValue(None, "APPS.TotalFoodOrdersFailed"))
		SetCursorPosition(19)
		AddHeaderOption("$SEXORDERS")
		SetCursorPosition(21)
		AddTextOption("$REQUESTED", GetIntValue(None, "APPS.SexOrdersRequested"))
		SetCursorPosition(23)
		AddTextOption("$ACCEPTED", GetIntValue(None, "APPS.SexOrdersAccepted"))
		SetCursorPosition(25)
		AddTextOption("$DECLINED", GetIntValue(None, "APPS.SexOrdersDeclined"))
		SetCursorPosition(27)
		AddHeaderOption("$DANCEORDERS")
		SetCursorPosition(29)
		AddTextOption("$REQUESTED", GetIntValue(None, "APPS.DanceOrdersRequested"))
		SetCursorPosition(31)
		AddTextOption("$ACCEPTED", GetIntValue(None, "APPS.DanceOrdersAccepted"))
		SetCursorPosition(33)
		AddTextOption("$DECLINED", GetIntValue(None, "APPS.DanceOrdersDeclined"))
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
		SetIntValue(None, WorldSetting, SelectedOption)
	EndIf
EndEvent

;-------------------------------------------------------
;	SKI toggle control events
;-------------------------------------------------------
Event OnOptionSelect(int SelectedToggle)
	If(SelectedToggle == AutoSaveToggle)
		If(!HasIntValue(None, AutoSave))
			SetIntValue(None, AutoSave, 1)
			SetToggleOptionValue(AutoSaveToggle, True)
		Else
			UnsetIntValue(None, AutoSave)
			SetToggleOptionValue(AutoSaveToggle, False)
		EndIf
	EndIf
EndEvent
			
;-------------------------------------------------------
;	SKI slider control events
;-------------------------------------------------------
Event OnOptionSliderOpen(Int SelectedSlider)
	If(SelectedSlider == HoursToWorkSlider)
		SetSliderDialogStartValue(GetIntValue(None,HoursToWork))
		SetSliderDialogDefaultValue(GetIntValue(None,HoursToWork))
		SetSliderDialogRange(fMinWork, fMaxWork)
		SetSliderDialogInterval(2)
	ElseIf(SelectedSlider == MinTipSlider)
		SetSliderDialogStartValue(GetIntValue(None, MinTip) * 5)
		SetSliderDialogDefaultValue(GetIntValue(None, MinTip) * 5)
		SetSliderDialogRange(fMinTip * 100, fMaxTip * 100 - 5)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == MaxTipSlider)
		SetSliderDialogStartValue(GetIntValue(None, MaxTip) * 5)
		SetSliderDialogDefaultValue(GetIntValue(None, MaxTip) * 5)
		SetSliderDialogRange(fMinTip * 100 + 5,fMaxTip * 100)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == MinTipSCSlider)
		SetSliderDialogStartValue(GetIntValue(None, MinTipSC) * 5)
		SetSliderDialogDefaultValue(GetIntValue(None, MinTipSC) * 5)
		SetSliderDialogRange(fMinTipSC * 100, fMaxTipSC * 100 - 5)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == MaxTipSCSlider)
		SetSliderDialogStartValue(GetIntValue(None, MaxTipSC) * 5)
		SetSliderDialogDefaultValue(GetIntValue(None, MaxTipSC) * 5)
		SetSliderDialogRange(fMinTipSC * 100 + 5, fMaxTipSC * 100)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == PaymentSlider)
		SetSliderDialogStartValue(GetIntValue(None,Payment))
		SetSliderDialogDefaultValue(GetIntValue(None,Payment))
		SetSliderDialogRange(fMinPayment, fMaxPayment)
		SetSliderDialogInterval(1)
	ElseIf(SelectedSlider == WhoreBasePaymentSlider)
		SetSliderDialogStartValue(GetIntValue(None, WhoreBasePayment))
		SetSliderDialogDefaultValue(GetIntValue(None, WhoreBasePayment))
		SetSliderDialogRange(fMinWhoreBasePayment, fMaxWhoreBasePayment)
		SetSliderDialogInterval(1)
	ElseIf(SelectedSlider == WhoreModSlider)
		SetSliderDialogStartValue(GetFloatValue(None, WhoreMod) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, WhoreMod) * 100)
		SetSliderDialogRange(fMinWhoreMod, fMaxWhoreMod)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == DragonbornBonusSlider)
		SetSliderDialogStartValue(GetFloatValue(None, DragonbornBonus) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, DragonbornBonus) * 100)
		SetSliderDialogRange(fMinDragonbornBonus, fMaxDragonbornBonus)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == AnalModSlider)
		SetSliderDialogStartValue(GetFloatValue(None, AnalMod) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, AnalMod) * 100)
		SetSliderDialogRange(fMinAnalMod, fMaxAnalMod)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == OralModSlider)
		SetSliderDialogStartValue(GetFloatValue(None, OralMod) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, OralMod) * 100)
		SetSliderDialogRange(fMinOralMod, fMaxOralMod)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == VaginalModSlider)
		SetSliderDialogStartValue(GetFloatValue(None, VaginalMod) * 100)
		SetSliderDialogDefaultValue(GetFloatValue(None, VaginalMod) * 100)
		SetSliderDialogRange(fMinVaginalMod, fMaxVaginalMod)
		SetSliderDialogInterval(5)
	EndIf
EndEvent

Event OnOptionSliderAccept(Int SelectedSlider, Float Value)
		If(SelectedSlider == HoursToWorkSlider)
			SetIntValue(None, HoursToWork, Value As Int)
			SetIntValue(None, HoursToWorkExpected, (Value / 2) As Int)
			SetSliderOptionValue(HoursToWorkSlider, Value)
		ElseIf(SelectedSlider == PaymentSlider)
			SetIntValue(None, Payment, Value As Int)
			SetSliderOptionValue(PaymentSlider, Value, "{0} Gold")
		ElseIf(SelectedSlider == MinTipSlider)
			SetIntValue(None, MinTip, (Value / 5) As Int)
			SetSliderOptionValue(MinTipSlider, Value, "{0}%")
			
			If(Value >= GetIntValue(None, MaxTip) * 5)
				SetIntValue(None, MaxTip, (Value / 5 + 5) As Int)
				SetSliderOptionValue(MaxTipSlider, Value + 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == MaxTipSlider)
			SetIntValue(None, MaxTip, (Value / 5) As Int)
			SetSliderOptionValue(MaxTipSlider, Value, "{0}%")

			If(Value <= GetIntValue(None, MinTip) * 5)
				SetIntValue(None, MinTip, (Value / 5 - 5) As Int)
				SetSliderOptionValue(MinTipSlider, Value - 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == MinTipSCSlider)
			SetIntValue(None, MinTipSC, (Value / 5) As Int)
			SetSliderOptionValue(MinTipSCSlider, Value, "{0}%")
			
			If(Value >= GetIntValue(None, MaxTipSC) * 5)
				SetIntValue(None, MaxTipSC, (Value / 5 + 5) As Int)
				SetSliderOptionValue(MaxTipSCSlider, Value + 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == MaxTipSCSlider)
			SetIntValue(None, MaxTipSC, (Value / 5) As Int)
			SetSliderOptionValue(MaxTipSCSlider, Value + 5, "{0}%")
			
			If(Value <= GetIntValue(None, MinTipSC) * 5)
				SetIntValue(None, MinTipSC, (Value / 5 - 5) As Int)
				SetSliderOptionValue(MinTipSCSlider, Value - 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == WhoreBasePaymentSlider)
			SetIntValue(None, WhoreBasePayment, Value As Int)
			SetSliderOptionValue(WhoreBasePaymentSlider, Value, "{0} Gold")
		ElseIf(SelectedSlider == WhoreModSlider)
			SetFloatValue(None, WhoreMod, Value / 100)
			SetSliderOptionValue(WhoreModSlider, Value, "{0}%")
		ElseIf(SelectedSlider == DragonbornBonusSlider)
			SetFloatValue(None, DragonbornBonus, Value / 100)
			SetSliderOptionValue(DragonbornBonusSlider, Value, "{0}%")
		ElseIf(SelectedSlider == AnalModSlider)
			SetFloatValue(None, AnalMod, Value / 100)
			SetSliderOptionValue(AnalModSlider, Value, "{0}%")
			
			If(Value <= GetFloatValue(None, VaginalMod) * 100)
				SetFloatValue(None, VaginalMod, (Value - 5 ) / 100)
				SetSliderOptionValue(VaginalModSlider, Value - 5, "{0}%")
			EndIf
			
			If(Value <= GetFloatValue(None, OralMod) * 100)
				SetFloatValue(None, OralMod, (Value - 10) / 100)
				SetSliderOptionValue(OralModSlider, Value - 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == OralModSlider)
			SetFloatValue(None, OralMod, (Value / 100))
			SetSliderOptionValue(OralModSlider, Value, "{0}%")
			
			If(Value >= GetFloatValue(None, VaginalMod) * 100)
				SetFloatValue(None, VaginalMod, (Value + 5) / 100)
				SetSliderOptionValue(VaginalModSlider, Value + 5, "{0}%")
			EndIf

			If(Value >= GetFloatValue(None, AnalMod) * 100)
				SetFloatValue(None, AnalMod, (Value + 5) / 100)
				SetSliderOptionValue(AnalModSlider, Value + 10, "{0}%")
			EndIf
		ElseIf(SelectedSlider == VaginalModSlider)
			SetFloatValue(None, VaginalMod, Value / 100)
			SetSliderOptionValue(VaginalModSlider, Value, "{0}%")
			
			If(Value >= GetFloatValue(None, AnalMod) * 100)
				SetFloatValue(None, AnalMod, (Value + 5) / 100)
				SetSliderOptionValue(AnalModSlider, Value + 5, "{0}%")
			ElseIf(Value <= GetFloatValue(None, OralMod) / 100)
				SetFloatValue(None, OralMod, (Value - 5) / 100)
				SetSliderOptionValue(OralModSlider, Value - 5, "{0}%")
			EndIf
		EndIf
EndEvent

;-------------------------------------------------------
;	Custom events
;-------------------------------------------------------
Function LoadPreset(Int Difficulty)
	If(Difficulty == 0)
		SetIntValue(None, AutoSave, 1)
		SetToggleOptionValue(AutoSaveToggle, True)
		SetIntValue(None, HoursToWork, 6)
		SetIntValue(None, HoursToWorkExpected, 3)
		SetIntValue(None, MinTip, 2)
		SetIntValue(None, MaxTip, 3)
		SetIntValue(None, MinTipSC, 3)
		SetIntValue(None, MaxTipSC, 5)
		SetIntValue(None, Payment, 20)
		SetIntValue(None, WhoreBasePayment, 45)
		SetFloatValue(None, WhoreMod, 1.20)
		SetFloatValue(None, DragonbornBonus, 0.15)
		SetFloatValue(None, AnalMod, 0.75)
		SetFloatValue(None, OralMod, 0.25)
		SetFloatValue(None, VaginalMod, 1.00)
	ElseIf(Difficulty == 1)
		SetIntValue(None, AutoSave, 1)
		SetToggleOptionValue(AutoSaveToggle, True)
		SetIntValue(None, HoursToWork, 8)
		SetIntValue(None, HoursToWorkExpected, 4)
		SetIntValue(None, MinTip, 1)
		SetIntValue(None, MaxTip, 2)
		SetIntValue(None, MinTipSC, 2)
		SetIntValue(None, MaxTipSC, 4)
		SetIntValue(None, Payment, 15)
		SetIntValue(None, WhoreBasePayment, 30)
		SetFloatValue(None, WhoreMod, 1.00)
		SetFloatValue(None, DragonbornBonus, 0.10)
		SetFloatValue(None, AnalMod, 0.60)
		SetFloatValue(None, OralMod, 0.20)
		SetFloatValue(None, VaginalMod, 0.80)
	ElseIf(Difficulty == 2)
		UnsetIntValue(None, AutoSave)
		SetToggleOptionValue(AutoSaveToggle, True)
		SetIntValue(None, HoursToWork, 10)
		SetIntValue(None, HoursToWorkExpected, 5)
		SetIntValue(None, MinTip, 0)
		SetIntValue(None, MaxTip, 1)
		SetIntValue(None, MinTipSC, 1)
		SetIntValue(None, MaxTipSC, 3)
		SetIntValue(None, Payment, 10)
		SetIntValue(None, WhoreBasePayment, 15)
		SetFloatValue(None, WhoreMod, 0.80)
		SetFloatValue(None, DragonbornBonus, 0.05)
		SetFloatValue(None, AnalMod, 0.30)
		SetFloatValue(None, OralMod, 0.15)
		SetFloatValue(None, VaginalMod, 0.60)
	EndIf
EndFunction