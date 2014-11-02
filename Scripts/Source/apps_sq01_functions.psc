Scriptname APPS_SQ01_Functions Extends Quest Conditional
Import StorageUtil

Int Property FoodOrdersFailed Auto Conditional Hidden
Float Property Satisfaction Auto Conditional Hidden

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

Function CutWages()
	SetIntValue(None, "APPS.SQ01.Wages", Math.Floor(GetIntValue(None, "APPS.SQ01.Wages") * 2 / 3))
EndFunction

Function PayOrReceiveGold(Actor akSpeaker, Actor akPlayer)
	Int ToPay = GetIntValue(None, "APPS.SQ01.Wages") - GetIntValue(None, "APPS.SQ01.InnkeeperShare")

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