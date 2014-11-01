Scriptname APPS_SQ01_Functions Extends Quest Conditional

Bool IsQuestStopping = False
Int Property CurrentStage Auto Hidden Conditional
GlobalVariable Property SpectatorDistance Auto
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
Bool Property IsOrderWrittenDown = False Auto Hidden Conditional
Int Property DeductedWages = 0 Auto Hidden
Bool Property HoursWorked Auto Conditional Hidden
Potion[] Property FoodList Auto Hidden
Potion[] Property SupposedFoodList Auto Hidden
;-------------------------------------------------------
;	Variables for Sexorder task
;-------------------------------------------------------
Bool Property IsInDistance Auto Conditional
Bool Property IsHadSexWithBeggar = False Auto Conditional
;-------------------------------------------------------
;	Variables for different events
;-------------------------------------------------------
Bool Property IsPickPocketFailed = False Auto Conditional
Bool Property IsHadSexBefore = False Auto Conditional
Bool Property IsSameCustomer = False Auto Conditional
Int Property AmountOfSexRounds = 0 Auto Conditional
;-------------------------------------------------------
;	Events
;-------------------------------------------------------
Event OnUpdateGameTime()	
	If(GetStage() == 120)
		Return
	EndIf

	HoursWorked += 1
	AdjustIntValue(None, "APPS.SQ01.Wages", GetIntValue(None, "APPS.Settings.Payment"))

	WagesAddedMsg.Show(GetIntValue(None, "APPS.Settings.Payment"))

	If(HoursWorked >= GetIntValue(None, "APPS.SQ01.Settings.HoursToWork"))
		IsQuestStopping = True
		Return
	EndIf

	RegisterForSingleUpdateGameTime(1)
EndEvent

Function SetupCustomer(Actor akCustomer)
	Debug.Notification(akCustomer.GetName())
	Orders = 0
	SupposedOrders = 0
	Controller.CheckGold(akCustomer)

	Alias_TavernGuest.ForceRefTo(akCustomer)
EndFunction
;-------------------------------------------------------
;	Functions for Tavern Job task
;-------------------------------------------------------
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