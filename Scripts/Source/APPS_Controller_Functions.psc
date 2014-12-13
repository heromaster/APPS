Scriptname APPS_Controller_Functions Extends Quest Conditional
Import StorageUtil

Int Property FoodOrdersFailed Auto Conditional Hidden
Int Property Satisfaction Auto Conditional Hidden
Int Property TavernJobStorylineProgress Auto Conditional Hidden

String Property EXCLUDED_REQUESTS = "APPS.SQ01.ExcludedRequests" AutoReadOnly Hidden
String Property FOOD_ORDERS_REQUESTED = "APPS.Stats.FoodOrdersRequested" AutoReadOnly Hidden
String Property FOOD_ORDERS_SUCCEEDED = "APPS.Stats.FoodOrdersSucceeded" AutoReadOnly Hidden
String Property FOOD_ORDERS_FAILED = "APPS.Stats.FoodOrdersFailed" AutoReadOnly Hidden
String Property SEX_ACT = "APPS.SexAct" AutoReadOnly Hidden
String Property SEX_ORDERS_REQUESTED = "APPS.Stats.SexOrdersRequested" AutoReadOnly Hidden
String Property SEX_ORDERS_ACCEPTED = "APPS.Stats.SexOrdersAccepted" AutoReadOnly Hidden
String Property SEX_ORDERS_DECLINED = "APPS.Stats.SexOrdersDeclined" AutoReadOnly Hidden
String Property DANCE_ORDERS_REQUESTED = "APPS.Stats.DanceOrdersRequested" AutoReadOnly Hidden
String Property DANCE_ORDERS_ACCEPTED = "APPS.Stats.DanceOrdersAccepted" AutoReadOnly Hidden
String Property DANCE_ORDERS_DECLINED = "APPS.Stats.DanceOrdersDeclined" AutoReadOnly Hidden
String Property CUSTOMER_SERVED = "APPS.Stats.CustomerServed" AutoReadOnly Hidden
String Property CUSTOMER_SATISFIED = "APPS.Stats.CustomerSatisfied" AutoReadOnly Hidden
String Property CUSTOMER_DISSATISFIED = "APPS.Stats.CustomerDissatisfied" AutoReadOnly Hidden
String Property TOTAL_FOOD_ORDERS_REQUESTED = "APPS.Stats.TotalFoodOrdersRequested" AutoReadOnly Hidden
String Property TOTAL_FOOD_ORDERS_SUCCEEDED = "APPS.Stats.TotalFoodOrdersSucceeded" AutoReadOnly Hidden
String Property TOTAL_FOOD_ORDERS_FAILED = "APPS.Stats.TotalFoodOrdersFailed" AutoReadOnly Hidden
String Property TOTAL_SEX_ORDERS_REQUESTED = "APPS.Stats.TotalSexOrdersRequested" AutoReadOnly Hidden
String Property TOTAL_SEX_ORDERS_ACCEPTED = "APPS.Stats.TotalSexOrdersAccepted" AutoReadOnly Hidden
String Property TOTAL_SEX_ORDERS_DECLINED = "APPS.Stats.TotalSexOrdersDeclined" AutoReadOnly Hidden
String Property TOTAL_DANCE_ORDERS_REQUESTED = "APPS.Stats.TotalDanceOrdersRequested" AutoReadOnly Hidden
String Property TOTAL_DANCE_ORDERS_ACCEPTED = "APPS.Stats.TotalDanceOrdersAccepted" AutoReadOnly Hidden
String Property TOTAL_DANCE_ORDERS_DECLINED = "APPS.Stats.TotalDanceOrdersDeclined" AutoReadOnly Hidden
String Property TOTAL_CUSTOMER_SERVED = "APPS.Stats.TotalCustomerServed" AutoReadOnly Hidden
String Property TOTAL_CUSTOMER_SATISFIED = "APPS.Stats.TotalCustomerSatisfied" AutoReadOnly Hidden
String Property TOTAL_CUSTOMER_DISSATISFIED = "APPS.Stats.TotalCustomerDissatisfied" AutoReadOnly Hidden

Function AddToStats(Int auiStat, Bool abSuccess = True, Bool abSameGuest = False)
	If(auiStat == 1)
		AdjustIntValue(None, FOOD_ORDERS_REQUESTED, 1)
		AdjustIntValue(None, TOTAL_FOOD_ORDERS_REQUESTED, 1)

		If(abSuccess)
			AdjustIntValue(None, FOOD_ORDERS_SUCCEEDED, 1)
			AdjustIntValue(None, TOTAL_FOOD_ORDERS_SUCCEEDED, 1)
		Else
			AdjustIntValue(None, FOOD_ORDERS_FAILED, 1)
			AdjustIntValue(None, TOTAL_FOOD_ORDERS_FAILED, 1)
			FoodOrdersFailed += 1
		EndIf
	ElseIf(auiStat == 2)
		AdjustIntValue(None, SEX_ORDERS_REQUESTED, 1)
		AdjustIntValue(None, TOTAL_SEX_ORDERS_REQUESTED, 1)

		If(abSuccess)
			AdjustIntValue(None, SEX_ORDERS_ACCEPTED, 1)
			AdjustIntValue(None, TOTAL_SEX_ORDERS_ACCEPTED, 1)
		Else
			AdjustIntValue(None, SEX_ORDERS_DECLINED, 1)
			AdjustIntValue(None, TOTAL_SEX_ORDERS_DECLINED, 1)
		EndIf
	ElseIf(auiStat == 3)
		AdjustIntValue(None, DANCE_ORDERS_REQUESTED, 1)
		AdjustIntValue(None, TOTAL_DANCE_ORDERS_REQUESTED, 1)

		If(abSuccess)
			AdjustIntValue(None, DANCE_ORDERS_ACCEPTED, 1)
			AdjustIntValue(None, TOTAL_DANCE_ORDERS_ACCEPTED, 1)
		Else
			AdjustIntValue(None, DANCE_ORDERS_DECLINED, 1)
			AdjustIntValue(None, TOTAL_DANCE_ORDERS_DECLINED, 1)
		EndIf
	EndIf

	If(!abSameGuest)
		AdjustIntValue(None, CUSTOMER_SERVED, 1)
		AdjustIntValue(None, TOTAL_CUSTOMER_SERVED, 1)

		If(abSuccess)
			AdjustIntValue(None, CUSTOMER_SATISFIED, 1)
			AdjustIntValue(None, CUSTOMER_SATISFIED, 1)
		Else
			AdjustIntValue(None, CUSTOMER_DISSATISFIED, 1)
			AdjustIntValue(None, TOTAL_CUSTOMER_DISSATISFIED, 1)
		EndIf
	EndIf

	Satisfaction = (GetIntValue(None, CUSTOMER_DISSATISFIED) - GetIntValue(None, EXCLUDED_REQUESTS)) / GetIntValue(None, CUSTOMER_SATISFIED) * 100
EndFunction

Function ExcludeFromSatisfactionStat()
	AdjustIntValue(None, EXCLUDED_REQUESTS, 1)
EndFunction

Function ClearSexAct(Actor akClient)
	FormListClear(akClient, SEX_ACT)
	StringListClear(akClient, SEX_ACT)
	IntListClear(akClient, SEX_ACT)
EndFunction

Function AddToSexAct(Actor akInitiator, Actor[] akParticipants, Int auiSexAct)
	Int i

	While(i < akParticipants.Length)
		FormListAdd(akInitiator, SEX_ACT, akParticipants[i])

		i += 1
	EndWhile

	If(auiSexAct == 1)
		StringListAdd(akInitiator, SEX_ACT, "Oral")
	ElseIf(auiSexAct == 2)
		StringListAdd(akInitiator, SEX_ACT, "Vaginal")
	ElseIf(auiSexAct == 3)
		StringListAdd(akInitiator, SEX_ACT, "Anal")
	EndIf

	IntListAdd(akInitiator, SEX_ACT, auiSexAct)
EndFunction