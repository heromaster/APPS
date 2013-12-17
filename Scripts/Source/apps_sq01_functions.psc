Scriptname APPS_SQ01_Functions Extends Quest  Conditional

Bool IsQuestStopping = False
Int Property CurrentStage Auto Conditional
GlobalVariable Property SpectatorDistance Auto
Message Property WagesAddedMsg Auto
MiscObject Property Septims Auto
;-------------------------------------------------------
;	Frameworks
;-------------------------------------------------------
APPS_Controller_Variables Property Var Auto

;-------------------------------------------------------
;	Variables for Dancing task
;-------------------------------------------------------
Bool Property IsHadDancedForBeggar = False Auto Conditional

;-------------------------------------------------------
;	Variables for Tavernjob task
;-------------------------------------------------------
Bool Property IsCorrectFoodOrder = False Auto Conditional
Bool Property IsOrderWrittenDown = False Auto Conditional
Int Property DeductedWages = 0 Auto
Int Property Orders = 0 Auto Conditional
Int Property SupposedOrders = 0 Auto
Potion[] Property FoodList Auto
Potion[] Property SupposedFoodList Auto

;-------------------------------------------------------
;	Variables for Sexorder task
;-------------------------------------------------------
Bool Property IsInDistance Auto Conditional
Bool Property IsHadSexWithBeggar = False Auto Conditional

;-------------------------------------------------------
;	Events
;-------------------------------------------------------
Event OnInit()
	FoodList = New Potion[3]
	SupposedFoodList = New Potion[3]
EndEvent

Event OnUpdateGameTime()	
	If(CurrentStage == 120)
		Return
	EndIf

	Var.HoursWorked += 1
	Var.Wages.SetValueInt(Var.Wages.GetValueInt() + Var.Payment.GetValueInt())
	WagesAddedMsg.Show(Var.Payment.GetValueInt())

	If(Var.HoursWorked >= Var.HoursToWork.GetValueInt())
		If(CurrentStage > 10)
			IsQuestStopping = True
		EndIf

		Return
	EndIf

	RegisterForSingleUpdateGameTime(1)
EndEvent
;-------------------------------------------------------
;	Functions for Tavern Job task
;-------------------------------------------------------
Function AddOrderedItems(Actor akPlayer)
	Int i = 0
	
	If(IsOrderWrittenDown)
		While(i < Orders)
			akPlayer.AddItem(FoodList[i])
			Var.Bill += FoodList[i].GetGoldValue()

			i += 1
		EndWhile
	Else
		While(i < SupposedOrders)
			akPlayer.AddItem(SupposedFoodList[i])
			Var.Bill += SupposedFoodList[i].GetGoldValue()

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
	
	If(IsOrderWrittenDown)
		IsCorrectFoodOrder = True
		Return
	EndIf
	
	If(SupposedOrders < Orders)
		IsCorrectFoodOrder = False
		Return
	EndIf
	
	While(i < SupposedOrders)
		If(SupposedFoodList[i] != FoodList[i])
			IsCorrectFoodOrder = False
			Return
		EndIf

		i += 1
	EndWhile
	
	IsCorrectFoodOrder = True
EndFunction

Function FillOrder(Int auiOrderNumber, Potion akOrderedFood)
	FoodList[auiOrderNumber - 1] = akOrderedFood
	Orders += 1
EndFunction

Function FillSupposedOrder(Int auiOrderNumber, Potion akSupposedOrderedFood)
	SupposedFoodList[auiOrderNumber - 1] = akSupposedOrderedFood
	SupposedOrders += 1
EndFunction

Function WagesDeduction()
	Var.DeductedWages.SetValueInt(Var.DeductedWages.GetValueInt() + Var.Bill)
	Var.InnkeeperShare.SetValueInt(Var.InnkeeperShare.GetValueInt() + Var.Bill)
	Var.Bill = 0
EndFunction

Function CutWages()
	Var.Wages.SetValueInt(Math.Floor(Var.Wages.GetValueInt() * 2 / 3) As Int)
EndFunction

Function RemoveOrderItems(Actor akPlayer)
	Int i = 0
	
	If(IsOrderWrittenDown)
		While(i < Orders)
			akPlayer.RemoveItem(FoodList[i])
			
			i += 1
		EndWhile
	Else
		While(i < SupposedOrders)
			akPlayer.RemoveItem(SupposedFoodList[i])
		
			i += 1
		EndWhile
	EndIf
EndFunction

Function PayOrReceiveGold(Actor akSpeaker, Actor akPlayer)
	Int ToPay = Var.Wages.GetValueInt() - Var.InnkeeperShare.GetValueInt()

	If(ToPay > 0)
		akPlayer.AddItem(Septims, ToPay)
		akSpeaker.RemoveItem(Septims, ToPay)
	Else
		ToPay = ToPay * -2
		akPlayer.RemoveItem(Septims, ToPay)
		akSpeaker.AddItem(Septims, ToPay)
	EndIf
EndFunction

Function CreateSummary()
		Var.Satisfaction = (Var.GuestsHappy As Float) / (Var.GuestsServed As Float) * 100
EndFunction

ObjectReference Function FindSweepSpot(Actor akPlayer)
	Cell PCLocation = akPlayer.GetParentCell()
	ObjectReference SweepSpot = None
	Int Index = PCLocation.GetNumRefs(47)
	String IdleMarkerName

	While(1 == 1)
		SweepSpot = PCLocation.GetNthRef(Utility.RandomInt(1, Index), 47) As ObjectReference

		If(SweepSpot.GetFormID() == 0x00064106)
			Return SweepSpot
		EndIf
	EndWhile
EndFunction