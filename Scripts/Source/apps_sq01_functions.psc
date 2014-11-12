Scriptname APPS_SQ01_Functions Extends Quest  Conditional
Import StorageUtil

Bool IsHadBreak
Bool IsQuestStopping
Int Property CurrentStage Auto Hidden Conditional
Class Property Beggar Auto
Message Property WagesAddedMsg Auto
MiscObject Property Septims Auto
ReferenceAlias Property Alias_TavernGuest Auto
;-------------------------------------------------------
;	Frameworks
;-------------------------------------------------------
APPS_Controller_SharedFunctions Property Controller Auto
SexLabFramework Property SexLab Auto
;-------------------------------------------------------
;	Variables for Dancing task
;-------------------------------------------------------
Bool Property IsHadDancedForBeggar = False Auto Hidden Conditional

;-------------------------------------------------------
;	Variables for Tavernjob task
;-------------------------------------------------------
Bool Property IsCorrectFoodOrder = False Auto Hidden Conditional
Bool Property IsOrderNoted = False Auto Hidden Conditional
Int Property Orders Auto Conditional Hidden
Int Property HoursWorked Auto Hidden
Float Property Satisfaction Auto Hidden
;-------------------------------------------------------
;	Variables for Sexorder task
;-------------------------------------------------------
Bool Property IsInDistance Auto Conditional
Bool Property IsHadSexWithBeggar = False Auto Conditional

;-------------------------------------------------------
;	Variables for different events
;-------------------------------------------------------
Bool Property IsPickPocketFailed Auto Conditional
Bool Property IsHadSexBefore Auto Conditional
Bool Property IsSameCustomer Auto Conditional
Int Property AmountOfSexRounds Auto Conditional

;-------------------------------------------------------
;	Events
;-------------------------------------------------------
Event OnUpdateGameTime()	
	If(CurrentStage == 120)
		Return
	EndIf

	If(HoursWorked >= GetIntValue(None, "APPS.Settings.HoursToWork") && !IsHadBreak)
		;SetStage(xx) ;Hulda invites player to have a break
	EndIf

	HoursWorked += 1
	AdjustIntValue(None, "APPS.Wages", GetIntValue(None, "APPS.Settings.Payment"))
	WagesAddedMsg.Show(GetIntValue(None, "APPS.Settings.Payment"))

	If(HoursWorked >= GetIntValue(None, "APPS.Settings.HoursToWork"))
		If(CurrentStage > 10)
			IsQuestStopping = True
		EndIf

		Return
	EndIf

	RegisterForSingleUpdateGameTime(1)
EndEvent

Function SetupCustomer(Actor akCustomer)
	Controller.CheckGold(akCustomer)
	Alias_TavernGuest.ForceRefTo(akCustomer)
EndFunction
;-------------------------------------------------------
;	Functions for Tavern Job task
;-------------------------------------------------------
Function AddOrderedItems(Actor akPlayer)
	Int i = 0
	
	If(IsOrderNoted)
		While(i < FormListCount(None, "APPS.OrderList"))
			akPlayer.AddItem(FormListGet(None, "APPS.OrderList", i))
			AdjustIntValue(None, "APPS.Wages", FormListGet(None, "APPS.OrderList", i).GetGoldValue())

			i += 1
		EndWhile
	Else
		While(i < FormListCount(None, "APPS.SupposedOrderList"))
			akPlayer.AddItem(FormListGet(None, "APPS.OrderList", i))
			AdjustIntValue(None, "APPS.Wages", FormListGet(None, "APPS.OrderList", i).GetGoldValue())

			i += 1
		EndWhile
	EndIf
EndFunction

Function DismissFollower(Actor akFollower)
	If(akFollower == None)
		Return
	Else
		akFollower.EvaluatePackage()
	EndIf
EndFunction

Function CheckOrder()
	Int i = 0
	
	If(IsOrderNoted)
		IsCorrectFoodOrder = True
		Return
	EndIf
	
	If(GetIntValue(None, "APPS.SupposedOrders") < Orders)
		IsCorrectFoodOrder = False
		Return
	EndIf
	
	While(i < GetIntValue(None, "APPS.SupposedOrders"))
		If(FormListGet(None, "APPS.SupposedOrderList", i) != FormListGet(None, "APPS.OrderList", i))
			IsCorrectFoodOrder = False
			Return
		EndIf

		i += 1
	EndWhile
	
	IsCorrectFoodOrder = True
EndFunction

Function FillOrder(Int auiOrderNumber, Potion akOrderedFood)
	FormListAdd(None, "APPS.OrderList", akOrderedFood)
	Orders += 1
EndFunction

Function FillSupposedOrder(Int auiOrderNumber, Potion akSupposedOrderedFood)
	FormListAdd(None, "APPS.OrderList", akSupposedOrderedFood)
	AdjustIntValue(None, "APPS.SupposedOrders", 1)
EndFunction

Function DeductWages()
	AdjustIntValue(None, "APPS.Wages", -(GetIntValue(None, "APPS.Bill")))
	AdjustIntValue(None, "APPS.InnkeeperShare", GetIntValue(None, "APPS.Bill"))
	UnsetIntValue(None, "APPS.Bill")
EndFunction

Function CutWages()
	SetIntValue(None, "APPS.Wages", Math.Floor(GetIntValue(None, "APPS.Wages") * 2 / 3))
EndFunction

Function RemoveOrderItems(Actor akPlayer)
	Int i = 0
	
	If(IsOrderNoted)
		While(i < Orders)
			akPlayer.RemoveItem(FormListGet(None, "APPS.OrderList", i))
			
			i += 1
		EndWhile
	Else
		While(i < GetIntValue(None, "APPS.SupposedOrders"))
			akPlayer.RemoveItem(FormListGet(None, "APPS.SupposedOrderList", i))
		
			i += 1
		EndWhile
	EndIf
EndFunction

Function PayOrReceiveGold(Actor akSpeaker, Actor akPlayer)
	Int ToPay = GetIntValue(None, "APPS.Wages") - GetIntValue(None, "APPS.InnkeeperShare")

	If(ToPay > 0)
		akPlayer.AddItem(Septims, ToPay)
		akSpeaker.RemoveItem(Septims, ToPay)
	Else
		ToPay = -ToPay
		akPlayer.RemoveItem(Septims, ToPay)
		akSpeaker.AddItem(Septims, ToPay)
	EndIf
EndFunction

Function CreateSummary()
		Satisfaction = (GetIntValue(None, "APPS.Stats.GuestsHappy") As Float) / (GetIntValue(None, "APPS.Stats.GuestsServed") As Float) * 100
EndFunction