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
Bool Property IsNPCFollowing = False Auto Conditional
Bool Property IsInDistance = True Auto Conditional
Bool Property IsPlayerWhore = False Auto
Int Property WhoreJobState = 0 Auto Conditional
Int Property HoursWorked = 0 Auto Conditional
Int Property SexActToInt Auto Conditional
Bool Property IsTavernJobOnCD = False Auto Conditional
Bool Property IsWhoreJobBeginOnCD = False Auto Conditional
Bool Property IsGivingAllGold = False Auto
Bool Property StraponOriginalValue Auto

String Property SexAct
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
Float Property Performance = 0.00 Auto Conditional
Float Property Satisfaction = 0.00 Auto Conditional
Int Property DanceOrdersAccepted = 0 Auto Conditional
Int Property DanceOrdersDeclined = 0 Auto Conditional
Int Property DanceOrdersRequested = 0 Auto Conditional
Int Property DaysWorked = 0 Auto Conditional
Int Property FoodOrdersFailed = 0 Auto Conditional
Int Property FoodOrdersRequested = 0 Auto Conditional
Int Property FoodOrdersSucceeded = 0 Auto Conditional
Int Property GuestsHappy = 0 Auto Conditional
Int Property GuestsServed = 0  Auto Conditional
Int Property GuestsUnhappy = 0  Auto Conditional
Int Property SexOrdersAccepted = 0  Auto Conditional
Int Property SexOrdersDeclined = 0  Auto Conditional
Int Property SexOrdersRequested = 0  Auto Conditional
Int Property TotalGuestsServed = 0  Auto
Int Property TotalGuestsHappy = 0  Auto
Int Property TotalGuestsUnhappy = 0  Auto
Int Property TotalFoodOrdersRequested = 0  Auto
Int property TotalFoodOrdersSucceeded = 0  Auto
Int Property TotalFoodOrdersFailed = 0  Auto
Int Property TotalSexOrdersRequested = 0  Auto
Int Property TotalSexOrdersAccepted = 0  Auto
Int Property TotalSexOrdersDeclined = 0  Auto
Int Property TotalDanceOrdersRequested = 0  Auto
Int Property TotalDanceOrdersAccepted = 0  Auto
Int Property TotalDanceOrdersDeclined = 0  Auto

;-------------------------------------------------------
;	Variables for Tavern Job task
;-------------------------------------------------------
Float Property WaitBeforeBeginWhoreJob = 2.0 Auto
Int Property Bill = 0  Auto 