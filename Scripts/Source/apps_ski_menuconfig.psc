Scriptname APPS_SKI_MenuConfig Extends SKI_ConfigBase
Import GlobalVariable

APPS_Controller_Variables Property Var Auto
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
		AutoSaveToggle = AddToggleOption("$AUTOSAVE_ON", Var.AutoSave.GetValueInt())
		WorldSettingMenu = AddMenuOption("$WORLD_SETTING", WorldSettingList[iWorldSettingChoice])
	ElseIf(Page == Pages[1])
		SetCursorFillMode(TOP_TO_BOTTOM)
		AddHeaderOption("$TAVERN_JOB", OptionFlag[iDifficultyChoice])
		HoursToWorkSlider = AddSliderOption("$HOURS_TO_WORK", Var.HoursToWork.GetValueInt(), "{0}", OptionFlag[iDifficultyChoice])
		PaymentSlider = AddSliderOption("$PAYMENT_PER_HOUR", Var.Payment.GetValueInt(), "{0} Gold", OptionFlag[iDifficultyChoice])
		AddHeaderOption("$TIP", OptionFlag[iDifficultyChoice])
		MinTipSlider = AddSliderOption("$MIN_TIP", Var.MinTip.GetValueInt() * 5, "{0}%", OptionFlag[iDifficultyChoice])
		MaxTipSlider = AddSliderOption("$MAX_TIP", Var.MaxTip.GetValueInt() * 5, "{0}%", OptionFlag[iDifficultyChoice])
		AddEmptyOption()
		MinTipSCSlider = AddSliderOption("$MIN_TIP_BONUS", Var.MinTipSC.GetValueInt() * 5, "{0}%", OptionFlag[iDifficultyChoice])
		MaxTipSCSlider = AddSliderOption("$MAX_TIP_BONUS", Var.MaxTipSC.GetValueInt() * 5, "{0}%", OptionFlag[iDifficultyChoice])
	ElseIf(Page == Pages[2])
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$WHORE_BASE_PAYMENT", OptionFlag[iDifficultyChoice])
		SetCursorPosition(2)
		WhoreBasePaymentSlider = AddSliderOption("$WHORE_BASE", Var.WhoreBasePayment.GetValueInt(), "{0} Gold", OptionFlag[iDifficultyChoice])
		SetCursorPosition(4)
		AddHeaderOption("$SEX_MOD_SERVICES")
		SetCursorPosition(6)
		WhoreModSlider = AddSliderOption("$WHORE_BASE_MOD", Var.WhoreMod.GetValue() * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(8)
		DragonbornBonusSlider = AddSliderOption("$DRAGONBORN_BONUS", Var.DragonbornBonus.GetValue() * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(1)
		AddHeaderOption("$SEX_MODS", OptionFlag[iDifficultyChoice])
		SetCursorPosition(3)
		AnalModSlider = AddSliderOption("$ANAL_MOD", Var.AnalMod.GetValue() * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(5)
		OralModSlider = AddSliderOption("$ORAL_MOD", Var.OralMod.GetValue() * 100, "{0}%", OptionFlag[iDifficultyChoice])
		SetCursorPosition(7)
		VaginalModSlider = AddSliderOption("$VAGINAL_MOD", Var.VaginalMod.GetValue() * 100, "{0}%", OptionFlag[iDifficultyChoice])
	ElseIf(Page == Pages[3])
		SetCursorFillMode(LEFT_TO_RIGHT)
		AddHeaderOption("$TOTAL")
		SetCursorPosition(2)
		AddTextOption("$DAYS_WORKED", Var.DaysWorked)
		SetCursorPosition(4)
		AddTextOption("$GUESTS_SERVED", Var.TotalGuestsServed)
		SetCursorPosition(6)
		AddTextOption("$GUESTS_HAPPY", Var.TotalGuestsHappy)
		SetCursorPosition(8)
		AddTextOption("$GUESTS_UNHAPPY", Var.TotalGuestsUnhappy)
		SetCursorPosition(10)
		AddHeaderOption("$FOODORDERS")
		SetCursorPosition(12)
		AddTextOption("$REQUESTED", Var.TotalFoodOrdersRequested)
		SetCursorPosition(14)
		AddTextOption("$SUCCEEDED", Var.TotalFoodOrdersSucceeded)
		SetCursorPosition(16)
		AddTextOption("$FAILED", Var.TotalFoodOrdersFailed)
		SetCursorPosition(18)
		AddHeaderOption("$SEXORDERS")
		SetCursorPosition(20)
		AddTextOption("$REQUESTED", Var.TotalSexOrdersRequested)
		SetCursorPosition(22)
		AddTextOption("$ACCEPTED", Var.TotalSexOrdersAccepted)
		SetCursorPosition(24)
		AddTextOption("$DECLINED", Var.TotalSexOrdersDeclined)
		SetCursorPosition(26)
		AddHeaderOption("$DANCEORDERS")
		SetCursorPosition(28)
		AddTextOption("$REQUESTED", Var.TotalDanceOrdersRequested)
		SetCursorPosition(30)
		AddTextOption("$ACCEPTED", Var.TotalDanceOrdersAccepted)
		SetCursorPosition(32)
		AddTextOption("$DECLINED", Var.TotalDanceOrdersDeclined)
		SetCursorPosition(3)
		AddHeaderOption("$THIS_SHIFT")
		SetCursorPosition(5)
		AddTextOption("$GUESTS_SERVED", Var.GuestsServed)
		SetCursorPosition(7)
		AddTextOption("$GUESTS_HAPPY", Var.GuestsHappy)
		SetCursorPosition(9)
		AddTextOption("$GUESTS_UNHAPPY", Var.GuestsUnhappy)
		SetCursorPosition(11)
		AddHeaderOption("$FOODORDERS")
		SetCursorPosition(13)
		AddTextOption("$REQUESTED", Var.TotalFoodOrdersRequested)
		SetCursorPosition(15)
		AddTextOption("$SUCCEEDED", Var.TotalFoodOrdersSucceeded)
		SetCursorPosition(17)
		AddTextOption("$FAILED", Var.TotalFoodOrdersFailed)
		SetCursorPosition(19)
		AddHeaderOption("$SEXORDERS")
		SetCursorPosition(21)
		AddTextOption("$REQUESTED", Var.SexOrdersRequested)
		SetCursorPosition(23)
		AddTextOption("$ACCEPTED", Var.SexOrdersAccepted)
		SetCursorPosition(25)
		AddTextOption("$DECLINED", Var.SexOrdersDeclined)
		SetCursorPosition(27)
		AddHeaderOption("$DANCEORDERS")
		SetCursorPosition(29)
		AddTextOption("$REQUESTED", Var.DanceOrdersRequested)
		SetCursorPosition(31)
		AddTextOption("$ACCEPTED", Var.DanceOrdersAccepted)
		SetCursorPosition(33)
		AddTextOption("$DECLINED", Var.DanceOrdersDeclined)
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
		Var.WorldSetting.SetValue(SelectedOption)
	EndIf
EndEvent

;-------------------------------------------------------
;	SKI toggle control events
;-------------------------------------------------------
Event OnOptionSelect(int SelectedToggle)
	If(SelectedToggle == AutoSaveToggle)
		If(Var.AutoSave.GetValueInt() == 0)
			Var.AutoSave.SetValueInt(1)
			SetToggleOptionValue(AutoSaveToggle, True)
		Else
			Var.AutoSave.SetValueInt(0)
			SetToggleOptionValue(AutoSaveToggle, False)
		EndIf
	EndIf
EndEvent
			
;-------------------------------------------------------
;	SKI slider control events
;-------------------------------------------------------
Event OnOptionSliderOpen(Int SelectedSlider)
	If(SelectedSlider == HoursToWorkSlider)
		SetSliderDialogStartValue(Var.HoursToWork.GetValue())
		SetSliderDialogDefaultValue(Var.HoursToWork.GetValue())
		SetSliderDialogRange(fMinWork, fMaxWork)
		SetSliderDialogInterval(2)
	ElseIf(SelectedSlider == MinTipSlider)
		SetSliderDialogStartValue(Var.MinTip.GetValue() * 5)
		SetSliderDialogDefaultValue(Var.MinTip.GetValue() * 5)
		SetSliderDialogRange(fMinTip * 100, fMaxTip * 100 - 5)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == MaxTipSlider)
		SetSliderDialogStartValue(Var.MaxTip.GetValue() * 5)
		SetSliderDialogDefaultValue(Var.MaxTip.GetValue() * 5)
		SetSliderDialogRange(fMinTip * 100 + 5,fMaxTip * 100)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == MinTipSCSlider)
		SetSliderDialogStartValue(Var.MinTipSC.GetValue() * 5)
		SetSliderDialogDefaultValue(Var.MinTipSC.GetValue() * 5)
		SetSliderDialogRange(fMinTipSC * 100, fMaxTipSC * 100 - 5)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == MaxTipSCSlider)
		SetSliderDialogStartValue(Var.MaxTipSC.GetValue() * 5)
		SetSliderDialogDefaultValue(Var.MaxTipSC.GetValue() * 5)
		SetSliderDialogRange(fMinTipSC * 100 + 5, fMaxTipSC * 100)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == PaymentSlider)
		SetSliderDialogStartValue(Var.Payment.GetValueInt())
		SetSliderDialogDefaultValue(Var.Payment.GetValueInt())
		SetSliderDialogRange(fMinPayment, fMaxPayment)
		SetSliderDialogInterval(1)
	ElseIf(SelectedSlider == WhoreBasePaymentSlider)
		SetSliderDialogStartValue(Var.WhoreBasePayment.GetValueInt())
		SetSliderDialogDefaultValue(Var.WhoreBasePayment.GetValueInt())
		SetSliderDialogRange(fMinWhoreBasePayment, fMaxWhoreBasePayment)
		SetSliderDialogInterval(1)
	ElseIf(SelectedSlider == WhoreModSlider)
		SetSliderDialogStartValue(Var.WhoreMod.GetValue() * 100)
		SetSliderDialogDefaultValue(Var.WhoreMod.GetValue() * 100)
		SetSliderDialogRange(fMinWhoreMod, fMaxWhoreMod)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == DragonbornBonusSlider)
		SetSliderDialogStartValue(Var.DragonbornBonus.GetValue() * 100)
		SetSliderDialogDefaultValue(Var.DragonbornBonus.GetValue() * 100)
		SetSliderDialogRange(fMinDragonbornBonus, fMaxDragonbornBonus)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == AnalModSlider)
		SetSliderDialogStartValue(Var.AnalMod.GetValue() * 100)
		SetSliderDialogDefaultValue(Var.AnalMod.GetValue() * 100)
		SetSliderDialogRange(fMinAnalMod, fMaxAnalMod)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == OralModSlider)
		SetSliderDialogStartValue(Var.OralMod.GetValue() * 100)
		SetSliderDialogDefaultValue(Var.OralMod.GetValue() * 100)
		SetSliderDialogRange(fMinOralMod, fMaxOralMod)
		SetSliderDialogInterval(5)
	ElseIf(SelectedSlider == VaginalModSlider)
		SetSliderDialogStartValue(Var.VaginalMod.GetValue() * 100)
		SetSliderDialogDefaultValue(Var.VaginalMod.GetValue() * 100)
		SetSliderDialogRange(fMinVaginalMod, fMaxVaginalMod)
		SetSliderDialogInterval(5)
	EndIf
EndEvent

Event OnOptionSliderAccept(Int SelectedSlider, Float Value)
		If(SelectedSlider == HoursToWorkSlider)
			Var.HoursToWork.SetValue(Value)
			Var.HoursToWorkExpected.SetValue(Value / 2)
			SetSliderOptionValue(HoursToWorkSlider, Value)
		ElseIf(SelectedSlider == PaymentSlider)
			Var.Payment.SetValue(Value)
			SetSliderOptionValue(PaymentSlider, Value, "{0} Gold")
		ElseIf(SelectedSlider == MinTipSlider)
			Var.MinTip.SetValue(Value / 5)
			SetSliderOptionValue(MinTipSlider, Value, "{0}%")
			
			If(Value >= Var.MaxTip.GetValue() * 5)
				Var.MaxTip.SetValue(Value / 5 + 5)
				SetSliderOptionValue(MaxTipSlider, Value + 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == MaxTipSlider)
			Var.MaxTip.SetValue(Value / 5)
			SetSliderOptionValue(MaxTipSlider, Value, "{0}%")

			If(Value <= Var.MinTip.GetValue() * 5)
				Var.MinTip.SetValue(Value / 5 - 5)
				SetSliderOptionValue(MinTipSlider, Value - 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == MinTipSCSlider)
			Var.MinTipSC.SetValue(Value / 5)
			SetSliderOptionValue(MinTipSCSlider, Value, "{0}%")
			
			If(Value >= Var.MaxTipSC.GetValue() * 5)
				Var.MaxTipSC.SetValue(Value / 5 + 5)
				SetSliderOptionValue(MaxTipSCSlider, Value + 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == MaxTipSCSlider)
			Var.MaxTipSC.SetValue(Value / 5)
			SetSliderOptionValue(MaxTipSCSlider, Value + 5, "{0}%")
			
			If(Value <= Var.MinTipSC.GetValue() * 5)
				Var.MinTipSC.SetValue(Value / 5 - 5)
				SetSliderOptionValue(MinTipSCSlider, Value - 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == WhoreBasePaymentSlider)
			Var.WhoreBasePayment.SetValue(Value)
			SetSliderOptionValue(WhoreBasePaymentSlider, Value, "{0} Gold")
		ElseIf(SelectedSlider == WhoreModSlider)
			Var.WhoreMod.SetValue(Value / 100)
			SetSliderOptionValue(WhoreModSlider, Value, "{0}%")
		ElseIf(SelectedSlider == DragonbornBonusSlider)
			Var.DragonbornBonus.SetValue(Value / 100)
			SetSliderOptionValue(DragonbornBonusSlider, Value, "{0}%")
		ElseIf(SelectedSlider == AnalModSlider)
			Var.AnalMod.SetValue(Value / 100)
			SetSliderOptionValue(AnalModSlider, Value, "{0}%")
			
			If(Value <= Var.VaginalMod.GetValue() * 100)
				Var.VaginalMod.SetValue((Value - 5 ) / 100)
				SetSliderOptionValue(VaginalModSlider, Value - 5, "{0}%")
			EndIf
			
			If(Value <= Var.OralMod.GetValue() * 100)
				Var.OralMod.SetValue((Value - 10) / 100)
				SetSliderOptionValue(OralModSlider, Value - 5, "{0}%")
			EndIf
		ElseIf(SelectedSlider == OralModSlider)
			Var.OralMod.SetValue(Value / 100)
			SetSliderOptionValue(OralModSlider, Value, "{0}%")
			
			If(Value >= Var.VaginalMod.GetValue() * 100)
				Var.VaginalMod.SetValue((Value + 5) / 100)
				SetSliderOptionValue(VaginalModSlider, Value + 5, "{0}%")
			EndIf

			If(Value >= Var.AnalMod.GetValue() * 100)
				Var.AnalMod.SetValue((Value + 5) / 100)
				SetSliderOptionValue(AnalModSlider, Value + 10, "{0}%")
			EndIf
		ElseIf(SelectedSlider == VaginalModSlider)
			Var.VaginalMod.SetValue(Value / 100)
			SetSliderOptionValue(VaginalModSlider, Value, "{0}%")
			
			If(Value >= Var.AnalMod.GetValue() * 100)
				Var.AnalMod.SetValue((Value + 5) / 100)
				SetSliderOptionValue(AnalModSlider, Value + 5, "{0}%")
			ElseIf(Value <= Var.OralMod.GetValue() / 100)
				Var.OralMod.SetValue((Value - 5) / 100)
				SetSliderOptionValue(OralModSlider, Value - 5, "{0}%")
			EndIf
		EndIf
EndEvent

;-------------------------------------------------------
;	Custom events
;-------------------------------------------------------
Function LoadPreset(Int Difficulty)
	If(Difficulty == 0)
		Var.AutoSave.SetValue(1)
		SetToggleOptionValue(AutoSaveToggle, True)
		Var.HoursToWork.SetValue(6)
		Var.HoursToWorkExpected.SetValue(3)
		Var.MinTip.SetValue(2)
		Var.MaxTip.SetValue(3)
		Var.MinTipSC.SetValue(3)
		Var.MaxTipSC.SetValue(5)
		Var.Payment.SetValue(20)
		Var.WhoreBasePayment.SetValue(45)
		Var.WhoreMod.SetValue(1.25)
		Var.DragonbornBonus.SetValue(0.25)
		Var.AnalMod.SetValue(1.10)
		Var.OralMod.SetValue(0.35)
		Var.VaginalMod.SetValue(0.5)
	ElseIf(Difficulty == 1)
		Var.AutoSave.SetValue(1)
		SetToggleOptionValue(AutoSaveToggle, True)
		Var.HoursToWork.SetValue(8)
		Var.HoursToWorkExpected.SetValue(4)
		Var.MinTip.SetValue(1)
		Var.MaxTip.SetValue(2)
		Var.MinTipSC.SetValue(2)
		Var.MaxTipSC.SetValue(4)
		Var.Payment.SetValue(15)
		Var.WhoreBasePayment.SetValue(30)
		Var.WhoreMod.SetValue(1.00)
		Var.DragonbornBonus.SetValue(0.15)
		Var.AnalMod.SetValue(1.00)
		Var.OralMod.SetValue(0.25)
		Var.VaginalMod.SetValue(0.4)
	ElseIf(Difficulty == 2)
		Var.AutoSave.SetValue(0)
		SetToggleOptionValue(AutoSaveToggle, True)
		Var.HoursToWork.SetValue(10)
		Var.HoursToWorkExpected.SetValue(5)
		Var.MinTip.SetValue(0)
		Var.MaxTip.SetValue(1)
		Var.MinTipSC.SetValue(1)
		Var.MaxTipSC.SetValue(3)
		Var.Payment.SetValue(10)
		Var.WhoreBasePayment.SetValue(15)
		Var.WhoreMod.SetValue(0.75)
		Var.DragonbornBonus.SetValue(0.05)
		Var.AnalMod.SetValue(0.90)
		Var.OralMod.SetValue(0.15)
		Var.VaginalMod.SetValue(0.3)
	EndIf
EndFunction