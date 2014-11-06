Scriptname APPS_SQ01_Functions Extends APPS_Controller_SharedFunctions Conditional
Import StorageUtil

String Property Wages = "APPS.SQ01.Wages" AutoReadOnly Hidden
String Property Payment = "APPS.Settings.Payment" AutoReadOnly Hidden
String Property HoursToWork = "APPS.SQ01.Settings.HoursToWork" AutoReadOnly Hidden
Float Property Satisfaction Auto Conditional Hidden
Bool IsQuestStopping = False
Int Property CurrentStage Auto Hidden Conditional
Message Property WagesAddedMsg Auto
ReferenceAlias Property Alias_TavernGuest Auto
;-------------------------------------------------------
;	Variables for Dancing task
;-------------------------------------------------------
Bool Property IsHadDancedForBeggar = False Auto Hidden Conditional
;-------------------------------------------------------
;	Variables for Tavernjob task
;-------------------------------------------------------
Int Property DeductedWages = 0 Auto Hidden
Int Property HoursWorked Auto Conditional Hidden
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
Bool Property IsPickPocketFailed = False Auto Conditional Hidden
Bool Property IsHadSexBefore = False Auto Conditional Hidden
Bool Property IsSameCustomer = False Auto Conditional Hidden
Int Property AmountOfSexRounds = 0 Auto Conditional Hidden
;-------------------------------------------------------
;	Events
;-------------------------------------------------------
Event OnUpdateGameTime()
	If(GetStage() == 120)
		Return
	EndIf

	HoursWorked += 1
	AdjustIntValue(None, Wages, GetIntValue(None, Payment))

	WagesAddedMsg.Show(GetIntValue(None, Payment))

	If(HoursWorked >= GetIntValue(None, HoursToWork))
		IsQuestStopping = True
		Return
	EndIf

	RegisterForSingleUpdateGameTime(1)
EndEvent

Function SetupCustomer(Actor akCustomer)
	CheckGold(akCustomer)

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

Function CutWages()
	SetIntValue(None, Wages, Math.Floor(GetIntValue(None, Wages) * 2 / 3))
EndFunction

Function PayOrReceiveGold(Actor akSpeaker, Actor akPlayer)
	Int ToPay = GetIntValue(None, Wages) - GetIntValue(None, InnkeeperShare)

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