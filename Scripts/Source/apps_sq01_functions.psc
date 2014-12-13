Scriptname APPS_SQ01_Functions Extends Quest  Conditional
Import StorageUtil

SexLabFramework Property SexLab Auto

Actor Property PlayerRef Auto
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

String Property BILL = "APPS.SQ01.Bill" AutoReadOnly Hidden
String Property HOURS_TO_WORK = "APPS.Settings.HoursToWork" AutoReadOnly Hidden
String Property HOURS_TO_WORK_EXPECTED = "APPS.Settings.HoursToWorkExpected" AutoReadOnly Hidden
String Property ORDER_LIST = "APPS.SQ01.OrderList" AutoReadOnly Hidden
String Property PAYMENT = "APPS.Settings.Payment" AutoReadOnly Hidden
String Property SUPPOSED_ORDER_LIST = "APPS.SQ01.SupposedOrderList" AutoReadOnly Hidden
String Property SUPPOSED_ORDERS = "APPS.SQ01.SupposedOrders" AutoReadOnly Hidden
String Property WAGES = "APPS.SQ01.Wages" AutoReadOnly Hidden

Event OnUpdateGameTime()
	HoursWorked += 1
	AdjustIntValue(None, WAGES, GetIntValue(None,  PAYMENT))

	WagesAddedMessage.Show(GetIntValue(None, PAYMENT))

	If(HoursWorked >= GetIntValue(None, HOURS_TO_WORK_EXPECTED) && !IsHadBreak)
		IsQuestStopping = True
		IsHadBreak = True
	ElseIf(HoursWorked >= GetIntValue(None, HOURS_TO_WORK))
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

Function FillOrder(Potion akOrderedFood)
	FormListAdd(None, ORDER_LIST, akOrderedFood)
	Orders += 1
EndFunction

Function FillSupposedOrder(Potion akSupposedOrderedFood)
	FormListAdd(None, SUPPOSED_ORDER_LIST, akSupposedOrderedFood)
	AdjustIntValue(None, SUPPOSED_ORDERS, 1)
EndFunction

Function CheckOrder()
	Int i = 0
	
	If(IsOrderNoted)
		IsCorrectFoodOrder = True
		Return
	EndIf
	
	If(FormListCount(None, SUPPOSED_ORDER_LIST) < Orders)
		IsCorrectFoodOrder = False
		Return
	EndIf
	
	While(i < FormListCount(None, SUPPOSED_ORDER_LIST))
		If(FormListGet(None, SUPPOSED_ORDER_LIST, i) != FormListGet(None, ORDER_LIST, i))
			IsCorrectFoodOrder = False
			Return
		EndIf

		i += 1
	EndWhile
	
	IsCorrectFoodOrder = True
EndFunction

Function AddOrderedItems()
	Int i = 0
	
	If(IsOrderNoted)
		While(i < Orders)
			PlayerRef.AddItem(FormListGet(None, ORDER_LIST, i))
			AdjustIntValue(None, BILL, (FormListGet(None, ORDER_LIST, i)).GetGoldValue())

			i += 1
		EndWhile
	Else
		While(i < FormListCount(None, SUPPOSED_ORDER_LIST))
			PlayerRef.AddItem(FormListGet(None, SUPPOSED_ORDER_LIST, i))
			AdjustIntValue(None, BILL, (FormListGet(None, SUPPOSED_ORDER_LIST, i)).GetGoldValue())

			i += 1
		EndWhile
	EndIf
EndFunction