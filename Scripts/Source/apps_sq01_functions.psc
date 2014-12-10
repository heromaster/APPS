Scriptname APPS_SQ01_Functions Extends Quest  Conditional
Import StorageUtil

SexLabFramework Property SexLab Auto

Class Property Beggar Auto
MagicEffect Property RefreshGoldEffect Auto
Message Property WagesAddedMessage Auto
MiscObject Property Septims Auto
ReferenceAlias Property Alias_Patron Auto
Spell Property RefreshGoldSpell Auto

Bool Property IsCorrectFoodOrder Auto Conditional Hidden
Bool Property IsHadBreak Auto Conditional Hidden
Bool Property IsOrderNoted Auto Conditional Hidden
Bool Property IsQuestStopping Auto Conditional Hidden
Int Property CurrentStage Auto Conditional Hidden
Int Property HoursWorked Auto Conditional Hidden
Int Property Orders Auto Conditional Hidden
String Property SUKEY_WAGES = "APPS.SQ01.Wages" AutoReadOnly Hidden
String Property SUKEY_PAYMENT = "APPS.Settings.Payment" AutoReadOnly Hidden
String Property SUKEY_HOURS_TO_WORK = "APPS.Settings.HoursToWork" AutoReadOnly Hidden
String Property SUKEY_HOURS_TO_WORK_EXPECTED = "APPS.Settings.HoursToWorkExpected" AutoReadOnly Hidden
String Property SUKEY_ORDER_LIST = "APPS.SQ01.OrderList" AutoReadOnly Hidden
String Property SUKEY_SUPPOSED_ORDER_LIST = "APPS.SQ01.SupposedOrderList" AutoReadOnly Hidden

Event OnUpdateGameTime()
	HoursWorked += 1
	AdjustIntValue(None, SUKEY_WAGES, GetIntValue(None,  SUKEY_PAYMENT))

	WagesAddedMessage.Show(GetIntValue(None, SUKEY_PAYMENT))

	If(HoursWorked >= GetIntValue(None, SUKEY_HOURS_TO_WORK_EXPECTED) && !IsHadBreak)
		IsQuestStopping = True
		IsHadBreak = True
	ElseIf(HoursWorked >= GetIntValue(None, SUKEY_HOURS_TO_WORK))
		IsQuestStopping = True
		Return
	EndIf

	RegisterForSingleUpdateGameTime(1)
EndEvent

Function SetupCustomer(Actor akCustomer)
	RefreshGold(akCustomer)

	Alias_Patron.ForceRefTo(akCustomer)

EndFunction

Function RefreshGold(Actor akClient)
	Int i = 0
	Int[] ProfessionLevel = New Int[3]
	Int HighestSexSkill = 0

	If(akClient.GetActorBase().GetClass() == Beggar)
		Return
	EndIf
	
	If(akClient.HasMagicEffect(RefreshGoldEffect))
		Return
	Else
		ProfessionLevel[0] = SexLab.GetPlayerStatLevel("Oral") + 1
		ProfessionLevel[1] = SexLab.GetPlayerStatLevel("Vaginal") + 1
		ProfessionLevel[2] = SexLab.GetPlayerStatLevel("Anal") + 1
		
		While(i <= ProfessionLevel.Length - 1)
			If(ProfessionLevel[i] > HighestSexSkill)
				HighestSexSkill = ProfessionLevel[i]
			EndIf
			
			i += 1
		EndWhile

		If(akClient.GetGoldAmount() < 30)
			If(akClient.IsChild())
				akClient.AddItem(Septims, 25)
			Else
				akClient.AddItem(Septims, 85 * HighestSexSkill)
			EndIf
		EndIf

		RefreshGoldSpell.Cast(akClient)
	EndIf
EndFunction

Function FillOrder(Potion akOrderedFood, Int auiOrderNumber)
	FormListAdd(None, "APPS.SQ01.Order", akOrderedFood)
	Orders += 1
EndFunction

Function CheckOrder()
	Int i = 0
	
	If(IsOrderNoted)
		IsCorrectFoodOrder = True
		Return
	EndIf
	
	If(FormListCount(None, SUKEY_SUPPOSED_ORDER_LIST) < FormListCount(None, SUKEY_ORDER_LIST))
		IsCorrectFoodOrder = False
		Return
	EndIf
	
	While(i < FormListCount(None, SUKEY_SUPPOSED_ORDER_LIST))
		If(FormListGet(None, SUKEY_SUPPOSED_ORDER_LIST, i) != FormListGet(None, SUKEY_ORDER_LIST, i))
			IsCorrectFoodOrder = False
			Return
		EndIf

		i += 1
	EndWhile
	
	IsCorrectFoodOrder = True
EndFunction