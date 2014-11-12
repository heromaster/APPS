Scriptname APPS_Controller_SharedFunctions Extends Quest Conditional
Import StorageUtil

String _SexAct

Bool Property IsTavernJobOnCD Auto Conditional Hidden
Bool Property IsWhoreJobBeginOnCD Auto Conditional Hidden
Float Property Performance Auto Conditional Hidden
Float Property Satisfaction Auto Conditional Hidden
Int Property SexActToInt Auto Conditional Hidden
Int Property SexSkillDifference Auto Hidden
Int Property DanceOrdersAccepted Auto Conditional Hidden
Int Property DanceOrdersDeclined Auto Conditional Hidden
Int Property DanceOrdersRequested Auto Conditional Hidden
Int Property DaysWorked Auto Conditional Hidden
Int Property FoodOrdersFailed Auto Conditional Hidden
Int Property FoodOrdersRequested Auto Conditional Hidden
Int Property FoodOrdersSucceeded Auto Conditional Hidden
Int Property GuestsHappy Auto Conditional Hidden
Int Property GuestsServed Auto Conditional Hidden
Int Property GuestsUnhappy Auto Conditional Hidden
Int Property SexOrdersAccepted Auto Conditional Hidden
Int Property SexOrdersDeclined Auto Conditional Hidden
Int Property SexOrdersRequested Auto Conditional Hidden
Int Property HoursWorked Auto Conditional Hidden
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

String Property SUKEY_ANAL_MOD = "APPS.Settings.AnalMod" AutoReadOnly Hidden
String Property SUKEY_BILL = "APPS.Bill" AutoReadOnly Hidden
String Property SUKEY_DANCE_ORDERS_ACCEPTED = "APPS.Stats.SexOrdersAccepted" AutoReadOnly Hidden
String Property SUKEY_DANCE_ORDERS_DECLINED = "APPS.Stats.SexOrdersDeclined" AutoReadOnly Hidden
String Property SUKEY_DANCE_ORDERS_REQUESTED ="APPS.Stats.SexOrdersRequested" AutoReadOnly Hidden
String Property SUKEY_DAYS_WORKED = "APPS.Stats.DaysWorked" AutoReadOnly Hidden
String Property SUKEY_DRAGONBORN_BONUS = "APPS.Settings.DragonbornBonus" AutoReadOnly Hidden
String Property SUKEY_FOOD_ORDERS_FAILED = "APPS.Stats.FoodOrdersFailed" AutoReadOnly Hidden
String Property SUKEY_FOOD_ORDERS_REQUESTED = "APPS.Stats.FoodOrdersRequested" AutoReadOnly Hidden
String Property SUKEY_FOOD_ORDERS_SUCCEEDED = "APPS.Stats.FoodOrdersSucceeded" AutoReadOnly Hidden
String Property SUKEY_GUESTS_HAPPY = "APPS.Stats.GuestsHappy" AutoReadOnly Hidden
String Property SUKEY_GUESTS_SERVED = "APPS.Stats.GuestsServed" AutoReadOnly Hidden
String Property SUKEY_GUESTS_UNHAPPY = "APPS.Stats.GuestsUnhappy" AutoReadOnly Hidden
String Property SUKEY_HOURS_TO_WORK = "APPS.Settings.HoursToWork" AutoReadOnly Hidden
String Property SUKEY_INNKEEPER_SHARE = "APPS.InnkeeperShare" AutoReadOnly Hidden
String Property SUKEY_IS_GIVING_ALL_GOLD = "APPS.IsGivingAllGold" AutoReadOnly Hidden
String Property SUKEY_IS_PLAYER_WHORE = "APPS.IsPlayerWhore" AutoReadOnly Hidden
String Property SUKEY_MAX_DANCE_REWARD = "APPS.Settings.MaxDanceReward" AutoReadOnly Hidden
String Property SUKEY_MAX_TIP = "APPS.Settings.MaxTip" AutoReadOnly Hidden
String Property SUKEY_MAX_TIP_SC = "APPS.Settings.MaxTipSC" AutoReadOnly Hidden
String Property SUKEY_MIN_DANCE_REWARD = "APPS.Settings.MinDanceReward" AutoReadOnly Hidden
String Property SUKEY_MIN_TIP = "APPS.Settings.MinTip" AutoReadOnly Hidden
String Property SUKEY_MIN_TIP_SC = "APPS.Settings.MinTipSC" AutoReadOnly Hidden
String Property SUKEY_ORAL_MOD = "APPS.Settings.OralMod" AutoReadOnly Hidden
String Property SUKEY_SEX_ORDERS_ACCEPTED = "APPS.Stats.SexOrdersAccepted" AutoReadOnly Hidden
String Property SUKEY_SEX_ORDERS_DECLINED = "APPS.Stats.SexOrdersDeclined" AutoReadOnly Hidden
String Property SUKEY_SEX_ORDERS_REQUESTED = "APPS.Stats.SexOrdersRequested" AutoReadOnly Hidden
String Property SUKEY_SUB_DOM = "APPS.SubDom" AutoReadOnly Hidden
String Property SUKEY_TOTAL_DANCE_ORDERS_ACCEPTED = "APPS.Stats.TotalDanceOrdersAccepted" AutoReadOnly Hidden
String Property SUKEY_TOTAL_DANCE_ORDERS_DECLINED = "APPS.Stats.TotalDanceOrdersDeclined" AutoReadOnly Hidden
String Property SUKEY_TOTAL_DANCE_ORDERS_REQUESTED = "APPS.Stats.TotalDanceOrdersRequested" AutoReadOnly Hidden
String Property SUKEY_TOTAL_FOOD_ORDERS_FAILED = "APPS.Stats.TotalFoodOrdersFailed" AutoReadOnly Hidden
String Property SUKEY_TOTAL_FOOD_ORDERS_REQUESTED = "APPS.Stats.TotalFoodOrdersRequested" AutoReadOnly Hidden
String Property SUKEY_TOTAL_FOOD_ORDERS_SUCCEEDED = "APPS.Stats.TotalFoodOrdersSucceeded" AutoReadOnly Hidden
String Property SUKEY_TOTAL_GUESTS_HAPPY = "APPS.Stats.TotalGuestsHappy" AutoReadOnly Hidden
String Property SUKEY_TOTAL_GUESTS_SERVED = "APPS.Stats.TotalGuestsServed" AutoReadOnly Hidden
String Property SUKEY_TOTAL_GUESTS_UNHAPPY = "APPS.Stats.TotalGuestsUnhappy" AutoReadOnly Hidden
String Property SUKEY_TOTAL_SEX_ORDERS_ACCEPTED = "APPS.Stats.TotalSexOrdersAccepted" AutoReadOnly Hidden
String Property SUKEY_TOTAL_SEX_ORDERS_DECLINED = "APPS.Stats.TotalSexOrdersDeclined" AutoReadOnly Hidden
String Property SUKEY_TOTAL_SEX_ORDERS_REQUESTED = "APPS.Stats.TotalSexOrdersRequested" AutoReadOnly Hidden
String Property SUKEY_VAGINAL_MOD = "APPS.Settings.VaginalMod" AutoReadOnly Hidden
String Property SUKEY_WAIT_FOR_WHORE_JOB = "APPS.WaitBeforeBeginWhoreJob" AutoReadOnly Hidden
String Property SUKEY_WHORE_BASE_PAYMENT = "APPS.Settings.WhoreBasePayment" AutoReadOnly Hidden

Actor Property PlayerRef Auto
;------------------------------------------------------------------------------
; IMPORTANT: Don't translate any strings in here
;------------------------------------------------------------------------------
Class Property BeggarClass Auto
GlobalVariable Property SpectatorDistance Auto
Keyword Property CumAnal Auto
Keyword Property CumOral Auto
Keyword Property CumVaginal Auto
MagicEffect Property RefreshGoldEffect Auto
Message Property CleanUpMsg Auto
MiscObject Property Septims Auto
Quest Property APPS_SQ01 Auto
Spell Property RefreshGoldSpell Auto  

SexLabFramework Property SexLab Auto
;------------------------------------------------------------------------------
; Quest progression Properties to see if the Dragonborn got identified
;------------------------------------------------------------------------------
Faction Property DBIdentifiedFaction Auto
Quest Property MQ104  Auto 
Quest Property MQ105  Auto  
Quest Property MQ105Ustengrav  Auto  
Quest Property MQ106  Auto
Quest Property MQ201  Auto  
Quest Property MQ202  Auto  
Quest Property MQ203  Auto  
Quest Property MQ204  Auto  
Quest Property MQ205  Auto  
Quest Property MQ206  Auto  
Quest Property MQ301  Auto  

;------------------------------------------------------------------------------
; Tasks
;------------------------------------------------------------------------------
Spell Property DispleasedByNoFoodSpell Auto
Spell Property DispleasedByNotDancingSpell Auto
Spell Property DispleasedByNoSexSpell Auto
Spell Property PleasedByFoodSpell Auto
Spell Property PleasedByDancingSpell Auto
Spell Property PleasedBySexSpell Auto
Spell Property RefractorySpell Auto
;------------------------------------------------------------------------------
; Cooldowns
;------------------------------------------------------------------------------
Float TavernJobCD = 0.0
Float WhoreJobCD = 0.0
Float WhoreJobBeginCD = 0.0

;------------------------------------------------------------------------------
;	Events
;------------------------------------------------------------------------------
Event OnUpdateGameTime()
	Float CurrentTime = Utility.GetCurrentGameTime()

	If(TavernJobCD + (GetIntValue(None, SUKEY_HOURS_TO_WORK) / 24) As Float  <= CurrentTime)
		IsTavernJobOnCD = False
	ElseIf(WhoreJobBeginCD + GetFloatValue(None, SUKEY_WAIT_FOR_WHORE_JOB) <= CurrentTime)
		IsWhoreJobBeginOnCD = False
	EndIf

	If(IsTavernJobOnCD || IsWhoreJobBeginOnCD)
		RegisterForSingleUpdateGameTime(0.5)
	EndIf
EndEvent

;------------------------------------------------------------------------------
;	Functions
;------------------------------------------------------------------------------
;Checks if the NPC has enough gold. Spell will be recast every 24h ingame
Function CheckGold(Actor akClient)
	Class NPCClass = akClient.GetActorBase().GetClass()
	Int i = 0
	Int[] ProfessionLevel = New Int[3]
	Int HighestSexSkill = 0

	If(NPCClass == BeggarClass)
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
				akClient.AddItem(Septims, 50)
			Else
				akClient.AddItem(Septims, 300 * HighestSexSkill)
			EndIf
		EndIf

		RefreshGoldSpell.Cast(akClient)
	EndIf
EndFunction

;Changes the direction of being submissive or dominant
;Hardened cap is -50/50 and hard cap is -150/150
Function ChangeDomSubValue(Int Value)
	AdjustIntValue(None, SUKEY_SUB_DOM, Value)

	If(GetIntValue(None, SUKEY_SUB_DOM) > 150)
		SetIntValue(None, SUKEY_SUB_DOM, 150)
	ElseIf(GetIntValue(None, SUKEY_SUB_DOM) < -150)
		SetIntValue(None, SUKEY_SUB_DOM, -150)
	EndIf
EndFunction

;Rewarding the player for a successful completed task
;Return value 0: Player received expected sum
;ReturnValue 1: Player received only what client had left
;ReturnValue 2: Player received all gold from client, still was less than expected
;ReturnValue 3: Player received all gold from client, much more than expected
;TODO: CONSIDER THE RETURNVALUE
Int Function EarnReward(Actor akClient, Int auiJob)
	Float GoldAmount
	Float SpeechCraftModifier = PlayerRef.GetAV("Speechcraft") / 100 * Utility.RandomInt(GetIntValue(None,SUKEY_MIN_TIP_SC), GetIntValue(None, SUKEY_MAX_TIP_SC)) * 0.05
	Float TipPercentage = Utility.RandomInt(GetIntValue(None, SUKEY_MIN_TIP), GetIntValue(None, SUKEY_MAX_TIP)) * 0.05
	Int ClientGoldLeft = akClient.GetItemCount(Septims)
	Int ReturnValue = 1
	Int i = 0

	If(auiJob == 1)
		GoldAmount = Math.Ceiling(GetIntValue(None, SUKEY_BILL) * TipPercentage)
		GoldAmount += Math.Ceiling(GetIntValue(None, SUKEY_BILL) * SpeechCraftModifier)
		AdjustIntValue(None, SUKEY_INNKEEPER_SHARE, GetIntValue(None, SUKEY_BILL))
		GoldAmount += GetIntValue(None, SUKEY_BILL)
	ElseIf(auiJob == 2)
		Float[] ProfessionLevel = New Float[4]
		ProfessionLevel[0] = 0
		ProfessionLevel[1] = SexLab.GetPlayerStatLevel("Oral") + 1
		ProfessionLevel[2] = SexLab.GetPlayerStatLevel("Vaginal") + 1
		ProfessionLevel[3] = SexLab.GetPlayerStatLevel("Anal") + 1 
		Int Sexperience

		If(SexActToInt == 1 && ProfessionLevel[1] < 7)
			Sexperience = Math.Ceiling(0.7 * ProfessionLevel[1] + 0.15 * ProfessionLevel[2] + 0.15 * ProfessionLevel[3]) 
		ElseIf(SexActToInt == 2 && ProfessionLevel[2] < 6)
			Sexperience = Math.Ceiling(0.7 * ProfessionLevel[2] + 0.15 * ProfessionLevel[1] + 0.15 * ProfessionLevel[3])
		ElseIf(SexActToInt == 3 && ProfessionLevel[3] < 6)
			Sexperience = Math.Ceiling(0.7 * ProfessionLevel[3] + 0.15 * ProfessionLevel[1] + 0.15 * ProfessionLevel[2])
		EndIf

		If(Sexperience > 7)
			Sexperience = 7
		ElseIf(Sexperience < 1)
			Sexperience = 1
		EndIf

		GoldAmount = Sexperience * GetIntValue(None, SUKEY_WHORE_BASE_PAYMENT)

		If(SexActToInt == 1)
			GoldAmount *= GetIntValue(None, SUKEY_ORAL_MOD)
		ElseIf(SexActToInt == 2)
			GoldAmount *= GetIntValue(None, SUKEY_VAGINAL_MOD)
		ElseIf(SexActToInt == 3)
			GoldAmount *= GetIntValue(None, SUKEY_ANAL_MOD)
		EndIf

		If(akClient.GetFactionRank(DBIdentifiedFaction) == 1)
			GoldAmount += GoldAmount * GetIntValue(None, SUKEY_DRAGONBORN_BONUS)
		EndIf

		;If(APPS_SQ01.IsStageDone(40))
		;	GoldAmount += GoldAmount * Var.WhoreBonus.GetValue()
		;EndIf

		If(GetIntValue(None, SUKEY_IS_PLAYER_WHORE))
			AdjustIntValue(None, SUKEY_INNKEEPER_SHARE, Math.Floor(GoldAmount / 2))
		EndIf
	ElseIf(auiJob == 3)
		GoldAmount = Utility.RandomInt(GetIntValue(None, SUKEY_MIN_DANCE_REWARD), GetIntValue(None, SUKEY_MAX_DANCE_REWARD))

		If(GetIntValue(None, SUKEY_IS_PLAYER_WHORE))
			AdjustIntValue(None, SUKEY_INNKEEPER_SHARE, Math.Floor(GoldAmount / 2))
		EndIf
	EndIf

	If(GoldAmount > ClientGoldLeft)
		GoldAmount = ClientGoldLeft
		ReturnValue = 1
	ElseIf(HasIntValue(None, SUKEY_IS_GIVING_ALL_GOLD) && GoldAmount > ClientGoldLeft)
		GoldAmount = ClientGoldLeft
		ReturnValue = 2
	ElseIf(HasIntValue(None, SUKEY_IS_GIVING_ALL_GOLD) && GoldAmount <= ClientGoldLeft)
		GoldAmount = ClientGoldLeft
		ReturnValue = 3
	EndIf

	PlayerRef.AddItem(Septims, Math.Ceiling(GoldAmount))
	akClient.RemoveItem(Septims, Math.Ceiling(GoldAmount))
	UnsetIntValue(None, SUKEY_IS_GIVING_ALL_GOLD)

	Return ReturnValue
EndFunction

;Prepares and calls SexLab Sex scenes
;TODO: Currently only 2 sexpartners, increase to at least 5
Function PerformSexAct(Actor akPlayer, Actor akClient)
	sslBaseAnimation[] SexAnimationList
	Actor[] SexActorList = New Actor[2]
	SexActorList[0] = akClient
	SexActorList[1] = akPlayer
	SexActorList = SexLab.SortActors(SexActorList)

	If(SexActToInt == 1 && (akClient.GetBaseObject() As ActorBase).GetSex() == 1 && (akPlayer.GetBaseObject() As ActorBase).GetSex() == 1)
		SexAnimationList = SexLab.GetAnimationsByTag(2, "Cunnilingus,Tribadism", tagSuppress = "Zaz,Aggressive", requireAll = False)
	Else
		SexAnimationList = SexLab.GetAnimationsByTag(2, SexAct, tagSuppress = "Zaz,Aggressive")
	EndIf

	sslThreadModel th = SexLab.NewThread()
	th.AddActor(SexActorList[0])
	th.AddActor(SexActorList[1])
	th.SetAnimations(SexAnimationList)
	th.DisableLeadIn(true)
	th.StartThread()
EndFunction

;Dispels the cum effect
;TODO: Don't show if the player has not an useable item to clean herself
;TODO: Remove an useable item from player's inventory
Function CleanUp(Actor akPlayer)
	If(akPlayer.HasMagicEffectWithKeyword(CumAnal) || akPlayer.HasMagicEffectWithKeyword(CumOral) || akPlayer.HasMagicEffectWithKeyword(CumVaginal))
		If(CleanUpMsg.Show() == 0)
			SexLab.ClearCum(akPlayer)
		Else
			ChangeDomSubValue(-5)
		EndIf
	EndIf
EndFunction

;Call to increase relationship between player and NPC
;Currently only used for an alternative for beggars
Function MakeFriends(Actor akNPC, Actor akPlayer)
	Int RelationShip = akNPC.GetRelationshipRank(akPlayer)

	If(RelationShip <= 0)
		akNPC.SetRelationshipRank(akPlayer, RelationShip + 1)
	EndIf
EndFunction

;Checks the players progression in the game and rolls a dice to determinate if he is identified as DB
Function IsDragonbornIdentified(Actor akSpeaker)
	Float ChanceMult = 1 / 11
	Float Chance = ChanceMult

	If(akSpeaker.IsInFaction(DBIdentifiedFaction))
		Return
	EndIf

	If(!MQ104.IsCompleted())
		Return
	EndIf

	If(MQ301.IsCompleted())
		akSpeaker.SetFactionRank(DBIdentifiedFaction, 0)
		Return
	EndIf

	If(MQ105.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(MQ105Ustengrav.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(MQ106.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(MQ201.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(MQ202.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(MQ203.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(MQ204.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(MQ205.IsCompleted())
		Chance += ChanceMult
	EndIf
	
	If(MQ206.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(Chance > Utility.RandomInt(0, 100))
		akSpeaker.SetFactionRank(DBIdentifiedFaction, 1)
	EndIf
EndFunction

Function SetSexRequest(String SexType)
	SexAct = SexType
EndFunction

;On a successful request this function casts a spell to atop the same client asking a new request
;Also casts a stackable detrimental spell to the player to simulate a refractory period
Function AddSatisfiedClient(Int auiTask, Actor akClient)
	If(auiTask == 1)
		PleasedByFoodSpell.Cast(akClient)
	ElseIf(auiTask == 2)
		PleasedBySexSpell.Cast(akClient)
		RefractorySpell.Cast(akClient)
		RefractorySpell.Cast(PlayerRef)
	ElseIf(auiTask == 3)
		PleasedByDancingSpell.Cast(akClient)
	EndIf

	AddToStatistics(auiTask)
EndFunction

;On a failed request this function casts a spell to stop the same client asking a new request
Function AddDissatisfiedClient(Int auiTask, Actor akClient)
	If(auiTask == 1)
		DispleasedByNoFoodSpell.Cast(akClient)
	ElseIf(auiTask == 2)
		DispleasedByNoSexSpell.Cast(akClient)
	ElseIf(auiTask == 3)
		DispleasedByNotDancingSpell.Cast(akClient)
	EndIf

	AddToStatistics(auiTask, False)
EndFunction

;If player successfully declined a request w/o making the client unhappy
;Mainly for statistic reasons
Function AddRequestDeclined(Int auiTask, Bool abChangedRequest = False)
		AddToStatistics(auiTask, False, True)
EndFunction

;Stores requests and their result, can be seen under APPS --> Statistics
Function AddToStatistics(Int auiStat, Bool abSuccess = True, Bool abSameGuest = False)
	If(auiStat == 1)
		AdjustIntValue(None, SUKEY_FOOD_ORDERS_REQUESTED, 1)
		AdjustIntValue(None, SUKEY_TOTAL_FOOD_ORDERS_REQUESTED, 1)

		If(abSuccess)
			AdjustIntValue(None, SUKEY_FOOD_ORDERS_SUCCEEDED, 1)
			AdjustIntValue(None, SUKEY_TOTAL_FOOD_ORDERS_SUCCEEDED, 1)
		Else
			AdjustIntValue(None, SUKEY_FOOD_ORDERS_FAILED, 1)
			AdjustIntValue(None, SUKEY_TOTAL_FOOD_ORDERS_FAILED, 1)
		EndIf
	ElseIf(auiStat == 2)
		AdjustIntValue(None, SUKEY_SEX_ORDERS_REQUESTED, 1)
		AdjustIntValue(None, SUKEY_TOTAL_SEX_ORDERS_REQUESTED, 1)

		If(abSuccess)
			AdjustIntValue(None, SUKEY_SEX_ORDERS_ACCEPTED, 1)
			AdjustIntValue(None, SUKEY_TOTAL_SEX_ORDERS_ACCEPTED, 1)
		Else
			AdjustIntValue(None, SUKEY_SEX_ORDERS_DECLINED, 1)
			AdjustIntValue(None, SUKEY_TOTAL_SEX_ORDERS_DECLINED, 1)
		EndIf
	ElseIf(auiStat == 3)
		AdjustIntValue(None, SUKEY_DANCE_ORDERS_REQUESTED, 1)
		AdjustIntValue(None, SUKEY_TOTAL_DANCE_ORDERS_REQUESTED, 1)

		If(abSuccess)
			AdjustIntValue(None, SUKEY_DANCE_ORDERS_ACCEPTED, 1)
			AdjustIntValue(None, SUKEY_TOTAL_DANCE_ORDERS_ACCEPTED, 1)
		Else
			AdjustIntValue(None, SUKEY_DANCE_ORDERS_DECLINED, 1)
			AdjustIntValue(None, SUKEY_TOTAL_DANCE_ORDERS_DECLINED, 1)
		EndIf
	EndIf

	If(!abSameGuest)
		AdjustIntValue(None, SUKEY_GUESTS_SERVED, 1)
		AdjustIntValue(None, SUKEY_TOTAL_GUESTS_SERVED, 1)

		If(abSuccess)
			AdjustIntValue(None, SUKEY_GUESTS_HAPPY, 1)
			AdjustIntValue(None, SUKEY_TOTAL_GUESTS_HAPPY, 1)
		Else
			AdjustIntValue(None, SUKEY_GUESTS_UNHAPPY, 1)
			AdjustIntValue(None, SUKEY_TOTAL_GUESTS_UNHAPPY, 1)
		EndIf
	EndIf
EndFunction

Function SkillLevelDifference(Actor akClient, String akSexAct)
	SexSkillDifference = SexLab.Stats.GetSkillLevel(PlayerRef, akSexAct) - SexLab.Stats.GetSkillLevel(akClient, akSexAct)
EndFunction

;On stopping the quest, this call will reset all necessary variables so this quest can be started fresh
Function ResetClients()
	UnsetIntValue(None, SUKEY_DANCE_ORDERS_DECLINED)
	UnsetIntValue(None, SUKEY_DANCE_ORDERS_ACCEPTED)
	UnsetIntValue(None, SUKEY_DANCE_ORDERS_REQUESTED)
	UnsetIntValue(None, SUKEY_FOOD_ORDERS_REQUESTED)
	UnsetIntValue(None, SUKEY_FOOD_ORDERS_SUCCEEDED)
	UnsetIntValue(None, SUKEY_FOOD_ORDERS_FAILED)
	UnsetIntValue(None, SUKEY_SEX_ORDERS_REQUESTED)
	UnsetIntValue(None, SUKEY_SEX_ORDERS_DECLINED)
	UnsetIntValue(None, SUKEY_SEX_ORDERS_ACCEPTED)
	UnsetIntValue(None, SUKEY_GUESTS_SERVED)
	UnsetIntValue(None, SUKEY_GUESTS_HAPPY)
	UnsetIntValue(None, SUKEY_GUESTS_UNHAPPY)
	UnsetIntValue(None, SUKEY_INNKEEPER_SHARE)
EndFunction

;Cooldowns necessary to progress the storyline and to simulate restings
Function SetCooldowns(Int auiCDTask)
	If(auiCDTask == 1)
		IsTavernJobOnCD = True
		TavernJobCD = Utility.GetCurrentGameTime()
	ElseIf(auiCDTask == 2)
		IsWhoreJobBeginOnCD = True
		WhoreJobBeginCD = Utility.GetCurrentGameTime()
	EndIf

	RegisterForSingleUpdateGameTime(0.5)
EndFunction

;If player could agree with client to give all his gold on a successful task
Function SetIsGivingAllGold()
	SetIntValue(None, SUKEY_IS_GIVING_ALL_GOLD, 1)
EndFunction