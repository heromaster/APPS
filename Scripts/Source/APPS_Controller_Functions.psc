Scriptname APPS_Controller_Functions Extends Quest Conditional
Import StorageUtil

SexLabFramework Property SexLab Auto

Bool Property IsGivingAllGold Auto Conditional Hidden
Bool Property IsPlayerJobWhore Auto Conditional Hidden
Bool Property IsPlayerTop Auto Conditional Hidden
Float Property DanceRewardMulti Auto Conditional Hidden
Int Property FoodOrdersFailed Auto Conditional Hidden
Int Property Satisfaction Auto Conditional Hidden
Int Property SexActToInt Auto Conditional Hidden
Int Property SexSkillDifference Auto Conditional Hidden
Int Property TavernJobStorylineProgress Auto Conditional Hidden

String Property ANAL_MOD = "APPS.Settings.AnalModifier" AutoReadOnly Hidden
String Property BASE_PAYMENT_WHORE = "APPS.Settings.BasePaymentWhore" AutoReadOnly Hidden
String Property BILL = "APPS.SQ01.Bill" AutoReadOnly Hidden
String Property DANCE_ORDERS_ACCEPTED = "APPS.Stats.DanceOrdersAccepted" AutoReadOnly Hidden
String Property DANCE_ORDERS_ACCEPTED_TOTAL = "APPS.Stats.TotalDanceOrdersAcceptedTotal" AutoReadOnly Hidden
String Property DANCE_ORDERS_DECLINED = "APPS.Stats.DanceOrdersDeclined" AutoReadOnly Hidden
String Property DANCE_ORDERS_DECLINED_TOTAL = "APPS.Stats.TotalDanceOrdersDeclinedTotal" AutoReadOnly Hidden
String Property DANCE_ORDERS_REQUESTED = "APPS.Stats.DanceOrdersRequested" AutoReadOnly Hidden
String Property DANCE_ORDERS_REQUESTED_TOTAL = "APPS.Stats.TotalDanceOrdersRequestedTotal" AutoReadOnly Hidden
String Property DB_BONUS = "APPS.Settings.DragonbornBonus" AutoReadOnly Hidden
String Property EXCLUDED_REQUESTS = "APPS.SQ01.ExcludedRequests" AutoReadOnly Hidden
String Property FOOD_ORDERS_FAILED = "APPS.Stats.FoodOrdersFailed" AutoReadOnly Hidden
String Property FOOD_ORDERS_FAILED_TOTAL = "APPS.Stats.TotalFoodOrdersFailedTotal" AutoReadOnly Hidden
String Property FOOD_ORDERS_REQUESTED = "APPS.Stats.FoodOrdersRequested" AutoReadOnly Hidden
String Property FOOD_ORDERS_REQUESTED_TOTAL = "APPS.Stats.TotalFoodOrdersRequestedTotal" AutoReadOnly Hidden
String Property FOOD_ORDERS_SUCCEEDED = "APPS.Stats.FoodOrdersSucceeded" AutoReadOnly Hidden
String Property FOOD_ORDERS_SUCCEEDED_TOTAL = "APPS.Stats.TotalFoodOrdersSucceededTotal" AutoReadOnly Hidden
String Property GUESTS_HAPPY = "APPS.Stats.GuestsHappy" AutoReadOnly Hidden
String Property GUESTS_HAPPY_TOTAL = "APPS.Stats.TotalCustomerSatisfied" AutoReadOnly Hidden
String Property GUESTS_SERVED = "APPS.Stats.GuestsServed" AutoReadOnly Hidden
String Property GUESTS_SERVED_TOTAL = "APPS.Stats.TotalCustomerServed" AutoReadOnly Hidden
String Property GUESTS_UNHAPPY = "APPS.Stats.GuestsUnhappy" AutoReadOnly Hidden
String Property GUESTS_UNHAPPY_TOTAL = "APPS.Stats.TotalCustomerDissatisfied" AutoReadOnly Hidden
String Property INNKEEPER_SHARE = "APPS.SQ01.InnkeeperShare" AutoReadOnly Hidden
String Property MAX_DANCE_REWARD = "APPS.Settings.MaxDanceReward" AutoReadOnly Hidden
String Property MAX_TIP = "APPS.Settings.MaxTip" AutoReadOnly Hidden
String Property MAX_TIP_SC = "APPS.Settings.MaxTipSC" AutoReadOnly Hidden
String Property MIN_DANCE_REWARD = "APPS.Settings.MinDanceReward" AutoReadOnly Hidden
String Property MIN_TIP = "APPS.Settings.MinTip" AutoReadOnly Hidden
String Property MIN_TIP_SC = "APPS.Settings.MinTipSC" AutoReadOnly Hidden
String Property ORAL_MOD = "APPS.Settings.OralModifier" AutoReadOnly Hidden
String Property SEX_ACT = "APPS.Controller.SexAct" AutoReadOnly Hidden
String Property SEX_ORDERS_ACCEPTED = "APPS.Stats.SexOrdersAccepted" AutoReadOnly Hidden
String Property SEX_ORDERS_ACCEPTED_TOTAL = "APPS.Stats.TotalSexOrdersAcceptedTotal" AutoReadOnly Hidden
String Property SEX_ORDERS_DECLINED = "APPS.Stats.SexOrdersDeclined" AutoReadOnly Hidden
String Property SEX_ORDERS_DECLINED_TOTAL = "APPS.Stats.TotalSexOrdersDeclinedTotal" AutoReadOnly Hidden
String Property SEX_ORDERS_REQUESTED = "APPS.Stats.SexOrdersRequested" AutoReadOnly Hidden
String Property SEX_ORDERS_REQUESTED_TOTAL = "APPS.Stats.TotalSexOrdersRequestedTotal" AutoReadOnly Hidden
String Property VAGINAL_MOD = "APPS.Settings.VaginalModifier" AutoReadOnly Hidden
String Property WHORE_MOD = "APPS.Settings.WhoreModifier" AutoReadOnly Hidden
String Property SexAct Hidden
	Function Set(String Value)
		_SexAct = Value

		If(Value == "Oral")
			SexActToInt = 1
		ElseIf(Value == "Vaginal")
			SexActToInt = 2
		ElseIf(Value == "Anal")
			SexActToInt = 3
		EndIf
	EndFunction

	String Function Get()
		Return _SexAct
	EndFunction
EndProperty

Actor Property PlayerRef Auto
Faction Property DBIdentifiedFaction Auto
MiscObject Property Septims Auto

Float FreeFuckMulti
String _SexAct

Function AddToStats(Int auiStat, Bool abSuccess = True, Bool abSameGuest = False)
	If(auiStat == 1)
		AdjustIntValue(None, FOOD_ORDERS_REQUESTED, 1)
		AdjustIntValue(None, FOOD_ORDERS_REQUESTED_TOTAL, 1)

		If(abSuccess)
			AdjustIntValue(None, FOOD_ORDERS_SUCCEEDED, 1)
			AdjustIntValue(None, FOOD_ORDERS_SUCCEEDED_TOTAL, 1)
		Else
			AdjustIntValue(None, FOOD_ORDERS_FAILED, 1)
			AdjustIntValue(None, FOOD_ORDERS_FAILED_TOTAL, 1)
			FoodOrdersFailed += 1
		EndIf
	ElseIf(auiStat == 2)
		AdjustIntValue(None, SEX_ORDERS_REQUESTED, 1)
		AdjustIntValue(None, SEX_ORDERS_REQUESTED_TOTAL, 1)

		If(abSuccess)
			AdjustIntValue(None, SEX_ORDERS_ACCEPTED, 1)
			AdjustIntValue(None, SEX_ORDERS_ACCEPTED_TOTAL, 1)
		Else
			AdjustIntValue(None, SEX_ORDERS_DECLINED, 1)
			AdjustIntValue(None, SEX_ORDERS_DECLINED_TOTAL, 1)
		EndIf
	ElseIf(auiStat == 3)
		AdjustIntValue(None, DANCE_ORDERS_REQUESTED, 1)
		AdjustIntValue(None, DANCE_ORDERS_REQUESTED_TOTAL, 1)

		If(abSuccess)
			AdjustIntValue(None, DANCE_ORDERS_ACCEPTED, 1)
			AdjustIntValue(None, DANCE_ORDERS_ACCEPTED_TOTAL, 1)
		Else
			AdjustIntValue(None, DANCE_ORDERS_DECLINED, 1)
			AdjustIntValue(None, DANCE_ORDERS_DECLINED_TOTAL, 1)
		EndIf
	EndIf

	If(!abSameGuest)
		AdjustIntValue(None, GUESTS_SERVED, 1)
		AdjustIntValue(None, GUESTS_SERVED_TOTAL, 1)

		If(abSuccess)
			AdjustIntValue(None, GUESTS_HAPPY, 1)
			AdjustIntValue(None, GUESTS_HAPPY_TOTAL, 1)
		Else
			AdjustIntValue(None, GUESTS_UNHAPPY, 1)
			AdjustIntValue(None, GUESTS_UNHAPPY_TOTAL, 1)
		EndIf
	EndIf

	Satisfaction = (GetIntValue(None, GUESTS_UNHAPPY) - GetIntValue(None, EXCLUDED_REQUESTS)) / GetIntValue(None, GUESTS_HAPPY) * 100
EndFunction

Function ExcludeFromSatisfactionStat()
	AdjustIntValue(None, EXCLUDED_REQUESTS, 1)
EndFunction

Function ClearSexAct()
	FormListClear(None, SEX_ACT)
	FreeFuckMulti = 0.0
EndFunction

Function AddToSexAct(Actor[] akParticipants, Int auiSexAct)
	Int i

	While(i < akParticipants.Length)
		FormListAdd(None, SEX_ACT, akParticipants[i])
		Debug.Trace("Loop:" + (i + 1))
		i += 1
	EndWhile

	If(auiSexAct == 1)
		If(akParticipants[1] == PlayerRef)
			IsPlayerTop = False
		Else
			IsPlayerTop = True
		EndIf
	Else
		If(akParticipants[0] == PlayerRef)
			IsPlayerTop = False
		Else
			IsPlayerTop = True
		EndIf
	EndIf

	If(auiSexAct == 1)
		SexAct = "Oral"
	ElseIf(auiSexAct == 2)
		SexAct = "Vaginal"
	ElseIf(auiSexAct == 3)
		SexAct = "Anal"
	EndIf
EndFunction

Function PerformSexAct()
	sslBaseAnimation[] SexAnimationList
	Actor[] SexActorList = New Actor[2]

	SexActorList[0] = FormListGet(None, SEX_ACT, 0) As Actor
	SexActorList[1] = FormListGet(None, SEX_ACT, 1) As Actor
	SexActorList = SexLab.SortActors(SexActorList)

	If(SexActToInt == 1 && ((FormListGet(None, SEX_ACT, 0) As Actor).GetActorBase().GetSex() == 1 && (FormListGet(None, SEX_ACT, 1) As Actor).GetActorBase().GetSex() == 1))
		SexAnimationList = SexLab.GetAnimationsByTag(2, "Cunnilingus", requireAll = False)
	Else
		SexAnimationList = SexLab.GetAnimationsByTag(2, SexAct)
	EndIf

	sslThreadModel th = SexLab.NewThread()
	th.AddActor(SexActorList[0])
	th.AddActor(SexActorList[1])
	th.SetAnimations(SexAnimationList)
	th.DisableLeadIn(true)
	th.SetBedding(0)
	th.StartThread()
EndFunction

Function ModFreeFuckMulti(Float afModifier)
	FreeFuckMulti += afModifier
EndFunction

Function EarnReward(Actor akClient, Int auiTask)
	Float[] ProLvl = New Float[4]
	Float GoldAmount = 0
	Float SpeechCraftModifier = PlayerRef.GetAV("Speechcraft") * Utility.RandomInt((GetFloatValue(None, MIN_TIP_SC) * 100) As Int, (GetFloatValue(None, MAX_TIP_SC) * 100) As Int) / 100
	Float TipPercentage = Utility.RandomFloat(GetFloatValue(None, MIN_TIP), GetFloatValue(None, MAX_TIP))
	Int[] Sexperience = New Int[4]
	Int ClientGoldLeft = akClient.GetItemCount(Septims)
	Int i

	If(auiTask == 1)
		GoldAmount = Math.Ceiling(GetIntValue(None, BILL) * TipPercentage)
		GoldAmount += Math.Ceiling(GetIntValue(None, BILL) * SpeechCraftModifier)
		AdjustIntValue(None, INNKEEPER_SHARE, GetIntValue(None, BILL))
		GoldAmount += GetIntValue(None, BILL)
	ElseIf(auiTask == 2)
		If(IsPlayerJobWhore)
			ProLvl[0] = 0
			ProLvl[1] = SexLab.GetPlayerStatLevel("Oral") + 1
			ProLvl[2] = SexLab.GetPlayerStatLevel("Vaginal") + 1
			ProLvl[3] = SexLab.GetPlayerStatLevel("Anal") + 1 
			Sexperience[0] = 1
			Sexperience[1] = Math.Ceiling(0.7 * ProLvl[1] + 0.15 * ProLvl[2] + 0.15 * ProLvl[3])
			Sexperience[2] = Math.Ceiling(0.7 * ProLvl[2] + 0.15 * ProLvl[1] + 0.15 * ProLvl[3])
			Sexperience[3] = Math.Ceiling(0.7 * ProLvl[3] + 0.15 * ProLvl[1] + 0.15 * ProLvl[2])

			While( i < Sexperience.Length)
				If(Sexperience[i] > 7)
					Sexperience[i] = 7
				ElseIf(Sexperience[i] < 1)
					Sexperience[i] = 1
				EndIf

				i += 1
			EndWhile

			GoldAmount = GetIntValue(None, BASE_PAYMENT_WHORE) * Sexperience[SexActToInt]
			GoldAmount += GoldAmount * GetFloatValue(None, WHORE_MOD)
		Else
			GoldAmount = GetIntValue(None, BASE_PAYMENT_WHORE)
		EndIf

		If(SexActToInt == 1)
			GoldAmount *= GetFloatValue(None, ORAL_MOD)
		ElseIf(SexActToInt == 2)
			GoldAmount *= GetFloatValue(None, VAGINAL_MOD)
		ElseIf(SexActToInt == 3)
			GoldAmount *= GetFloatValue(None, ANAL_MOD)
		EndIf

		If(akClient.GetFactionRank(DBIdentifiedFaction) == 1)
			GoldAmount += GoldAmount * GetFloatValue(None, DB_BONUS)
		EndIf

		If(IsPlayerJobWhore)
			AdjustIntValue(None, INNKEEPER_SHARE, Math.Floor(GoldAmount / 2))
		Else
			GoldAmount += GetIntValue(None, BASE_PAYMENT_WHORE) * FreeFuckMulti
		EndIf
	ElseIf(auiTask == 3)
		GoldAmount = Utility.RandomInt(GetIntValue(None, MIN_DANCE_REWARD), GetIntValue(None, MAX_DANCE_REWARD)) * DanceRewardMulti

		If(IsPlayerJobWhore)
			AdjustIntValue(None, INNKEEPER_SHARE, Math.Floor(GoldAmount / 2))
		EndIf
	EndIf

	PlayerRef.AddItem(Septims, Math.Ceiling(GoldAmount))
	akClient.RemoveItem(Septims, Math.Ceiling(GoldAmount))
	IsGivingAllGold = False

	UnsetIntValue(None, BILL)
EndFunction

Function SkillLevelDifference(Actor akPlayer, Actor akClient, String akSexAct)
	Int Diff = SexLab.Stats.GetSkillLevel(akPlayer, akSexAct) - SexLab.Stats.GetSkillLevel(akClient, akSexAct)

	If(Diff < 0)
		SexSkillDifference = -1
	ElseIf(Diff == 0)
		SexSkillDifference = 0
	Else
		SexSkillDifference = 1
	EndIf
EndFunction
