Scriptname APPS_Controller_Variables Extends Quest Conditional
Import GlobalVariable

;-------------------------------------------------------
;	Private variables
;-------------------------------------------------------
string _SexAct = "None"

;-------------------------------------------------------
;	MCM Config variables
;-------------------------------------------------------
GlobalVariable Property AnalMod Auto
GlobalVariable Property AutoSave Auto
GlobalVariable Property DragonbornBonus Auto
GlobalVariable Property HoursToWork Auto
GlobalVariable Property HoursToWorkExpected Auto
GlobalVariable Property InnkeeperShare  Auto
GlobalVariable Property MaxDanceReward Auto
GlobalVariable Property MaxTip Auto
GlobalVariable Property MaxTipSC Auto
GlobalVariable Property MinDanceReward Auto
GlobalVariable Property MinTip Auto
GlobalVariable Property MinTipSC Auto
GlobalVariable Property OralMod Auto
GlobalVariable Property Payment Auto
GlobalVariable Property VaginalMod Auto
GlobalVariable Property WhoreBasePayment Auto
GlobalVariable Property WhoreMod Auto
GlobalVariable Property WorldSetting Auto

;-------------------------------------------------------
;	General variables used everywhere
;-------------------------------------------------------
Bool Property IsNPCFollowing = False Auto Conditional Hidden
Bool Property IsInDistance = True Auto Conditional Hidden
Bool Property IsPlayerWhore = False Auto Hidden
Int Property WhoreJobState = 0 Auto Conditional Hidden
Int Property HoursWorked = 0 Auto Conditional Hidden
Int Property SexActToInt Auto Conditional Hidden
Int Property SexSkillDifference Auto Conditional Hidden
Bool Property IsTavernJobOnCD = False Auto Conditional Hidden
Bool Property IsWhoreJobBeginOnCD = False Auto Conditional Hidden
Bool Property IsGivingAllGold = False Auto Hidden
Bool Property StraponOriginalValue Auto Hidden

String Property SexAct Hidden
	Function Set(String Value)
		If(Value == "None")
			_SexAct = Value
			SexActToInt = 0
		ElseIf(Value == "Oral")
			_SexAct = Value
			SexActToInt = 1
		ElseIf(Value == "Vaginal")
			_SexAct = Value
			SexActToInt = 2
		ElseIf(Value == "Anal")
			_SexAct = Value
			SexActToInt = 3
		EndIf
	EndFunction

	String Function Get()
		Return _SexAct
	EndFunction
EndProperty

GlobalVariable Property DomSub Auto
GlobalVariable Property Wages Auto
GlobalVariable Property DeductedWages Auto

;-------------------------------------------------------
;	Statistics variables
;-------------------------------------------------------
Float Property Performance = 0.00 Auto Conditional Hidden
Float Property Satisfaction = 0.00 Auto Conditional Hidden
Int Property DanceOrdersAccepted = 0 Auto Conditional Hidden
Int Property DanceOrdersDeclined = 0 Auto Conditional Hidden
Int Property DanceOrdersRequested = 0 Auto Conditional Hidden
Int Property DaysWorked = 0 Auto Conditional Hidden
Int Property FoodOrdersFailed = 0 Auto Conditional Hidden
Int Property FoodOrdersRequested = 0 Auto Conditional Hidden
Int Property FoodOrdersSucceeded = 0 Auto Conditional Hidden
Int Property GuestsHappy = 0 Auto Conditional Hidden
Int Property GuestsServed = 0  Auto Conditional Hidden
Int Property GuestsUnhappy = 0  Auto Conditional Hidden
Int Property SexOrdersAccepted = 0  Auto Conditional Hidden
Int Property SexOrdersDeclined = 0  Auto Conditional Hidden
Int Property SexOrdersRequested = 0  Auto Conditional Hidden
Int Property TotalGuestsServed = 0  Auto Hidden
Int Property TotalGuestsHappy = 0  Auto Hidden
Int Property TotalGuestsUnhappy = 0  Auto Hidden
Int Property TotalFoodOrdersRequested = 0  Auto Hidden
Int property TotalFoodOrdersSucceeded = 0  Auto Hidden
Int Property TotalFoodOrdersFailed = 0  Auto Hidden
Int Property TotalSexOrdersRequested = 0  Auto Hidden
Int Property TotalSexOrdersAccepted = 0  Auto Hidden
Int Property TotalSexOrdersDeclined = 0  Auto Hidden
Int Property TotalDanceOrdersRequested = 0  Auto Hidden
Int Property TotalDanceOrdersAccepted = 0  Auto Hidden
Int Property TotalDanceOrdersDeclined = 0  Auto Hidden

;-------------------------------------------------------
;	Variables for Tavern Job task
;-------------------------------------------------------
Float Property WaitBeforeBeginWhoreJob = 2.0 Auto Hidden
Int Property Bill = 0  Auto  Hidden 