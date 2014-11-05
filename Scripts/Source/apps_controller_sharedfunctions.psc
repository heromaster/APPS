Scriptname APPS_Controller_SharedFunctions Extends Quest Conditional
Import GlobalVariable
Import StorageUtil

String Property MinTip = "APPS.Settings.MinTip" AutoReadOnly Hidden
String Property MaxTip = "APPS.Settings.MaxTip" AutoReadOnly Hidden
String Property MinTipSC = "APPS.Settings.MinTipSC" AutoReadOnly Hidden
String Property MaxTipSC = "APPS.Settings.MaxTipSC" AutoReadOnly Hidden
String Property InnkeeperShare = "APPS.InnkeeperShare" AutoReadOnly Hidden
Int Property FoodOrdersFailed Auto Conditional Hidden
;------------------------------
Bool Property IsPlayerWhore Auto Hidden
Bool Property IsGivingAllGold Auto Hidden
Bool Property IsWhoreJobBeginOnCD Auto Hidden
Bool Property IsTavernJobOnCD Auto Hidden
Int Property Bill Auto Hidden
Int Property SexActToInt Auto Hidden
Float Property WaitBeforeBeginWhoreJob Auto Hidden
String Property SexAct Auto Hidden
;------------------------------------------------------------------------------
; IMPORTANT: Don't translate any strings in here
;------------------------------------------------------------------------------
Actor Property PlayerRef Auto
Class Property BeggarClass Auto
GlobalVariable Property SpectatorDistance Auto
Keyword Property CumAnal Auto
Keyword Property CumOral Auto
Keyword Property CumVaginal Auto
MagicEffect Property GoldChecker Auto
Message Property CleanUpMsg Auto
MiscObject Property Septims Auto
Quest Property APPS_SQ01 Auto
Spell Property GoldChecking Auto  
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
;	Cooldowns
;------------------------------------------------------------------------------
Float TavernJobCD = 0.0
Float WhoreJobCD = 0.0
Float WhoreJobBeginCD = 0.0
;------------------------------------------------------------------------------
;	Events
;------------------------------------------------------------------------------
Event OnUpdateGameTime()
	Float CurrentTime = Utility.GetCurrentGameTime()
	
	If(TavernJobCD + (GetIntValue(None, "APPS.Settings.HoursToWork") / 24) As Float  <= CurrentTime)
		IsTavernJobOnCD = False
	ElseIf(WhoreJobBeginCD + WaitBeforeBeginWhoreJob <= CurrentTime)
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
	ActorBase NPCClass = akClient.GetActorBase()
	Int i = 0
	Int[] ProLvl = New Int[3]
	Int HighestSexSkill = 0

	If(NPCClass.GetClass() == BeggarClass)
		Return
	EndIf
	
	If(akClient.HasMagicEffect(GoldChecker))
		Return
	Else
		ProLvl[0] = SexLab.GetPlayerStatLevel("Oral") + 1
		ProLvl[1] = SexLab.GetPlayerStatLevel("Vaginal") + 1
		ProLvl[2] = SexLab.GetPlayerStatLevel("Anal") + 1
		
		While(i <= ProLvl.Length - 1)
			If(ProLvl[i] > HighestSexSkill)
				HighestSexSkill = ProLvl[i]
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

		GoldChecking.Cast(akClient)
	EndIf
EndFunction

;Changes the direction of being submissive or dominant
;Hardened cap is -50/50 and hard cap is -150/150
Function ChangeDomSubValue(Int Value)
	AdjustIntValue(None, "APPS.DomSub", Value)
	
	If(GetIntValue(None, "APPS.DomSub") > 150)
		SetIntValue(None, "APPS.DomSub", 150)
	ElseIf(GetIntValue(None, "APPS.DomSub") < -150)
		SetIntValue(None, "APPS.DomSub", -150)
	EndIf
EndFunction

Int Function EarnReward(Actor akClient, Int auiJob)
	Float GoldAmount
	Float SpeechCraftModifier = PlayerRef.GetAV("Speechcraft") / 100 * Utility.RandomInt(GetIntValue(None, MinTipSC), GetIntValue(None, MaxTipSC)) * 0.05
	Float TipPercentage = Utility.RandomInt(GetIntValue(None, MinTip), GetIntValue(None, MaxTip)) * 0.05
	Int ClientGoldLeft = akClient.GetItemCount(Septims)
	Int ReturnValue = 1
	Int i = 0

	If(auiJob == 1)
		GoldAmount = Math.Ceiling(GetIntValue(None, Bill) * TipPercentage)
		GoldAmount += Math.Ceiling(GetIntValue(None, Bill) * SpeechCraftModifier)
		AdjustIntValue(None, InnkeeperShare, GetIntValue(None, Bill))
		GoldAmount += GetIntValue(None, Bill)
	ElseIf(auiJob == 2)
		Float[] ProLvl = New Float[4]
		ProLvl[0] = 0
		ProLvl[1] = SexLab.GetPlayerStatLevel("Oral") + 1
		ProLvl[2] = SexLab.GetPlayerStatLevel("Vaginal") + 1
		ProLvl[3] = SexLab.GetPlayerStatLevel("Anal") + 1 
		Int Sexperience

		If(SexActToInt == 1 && ProLvl[1] < 7)
			Sexperience = Math.Ceiling(0.7 *ProLvl[1] + 0.15 * ProLvl[2] + 0.15 * ProLvl[3]) 
		ElseIf(SexActToInt == 2 && ProLvl[2] < 6)
			Sexperience = Math.Ceiling(0.7 * ProLvl[2] + 0.15 * ProLvl[1] + 0.15 * ProLvl[3])
		ElseIf(SexActToInt == 3 && ProLvl[3] < 6)
			Sexperience = Math.Ceiling(0.7 * ProLvl[3] + 0.15 * ProLvl[1] + 0.15 * ProLvl[2])
		EndIf

		If(Sexperience > 7)
			Sexperience = 7
		ElseIf(Sexperience < 1)
			Sexperience = 1
		EndIf
	
		GoldAmount = Sexperience * GetIntValue(None, "APPS.Settings.WhoreBasePayment")

		If(SexActToInt == 1)
			GoldAmount *= GetFloatValue(None, "APPS.Settings.OralMod")
		ElseIf(SexActToInt == 2)
			GoldAmount *= GetFloatValue(None, "APPS.Settings.VaginalMod")
		ElseIf(SexActToInt == 3)
			GoldAmount *= GetFloatValue(None, "APPS.Settings.AnalMod")
		EndIf
		
		If(akClient.GetFactionRank(DBIdentifiedFaction) == 1)
			GoldAmount += GoldAmount * GetFloatValue(None, "APPS.Settings.DragonbornBonus")
		EndIf

		;If(APPS_SQ01.IsStageDone(40))
		;	GoldAmount += GoldAmount * Var.WhoreBonus.GetValue()
		;EndIf

		If(IsPlayerWhore)
			AdjustIntValue(None, "APPS.InnkeeperShare.", Math.Floor(GoldAmount / 2))
		EndIf
	ElseIf(auiJob == 3)
		GoldAmount = Utility.RandomInt(GetIntValue(None, "APPS.Settings.MinDanceReward"), GetIntValue(None, "APPS.Settings.MaxDanceReward"))
		
		If(IsPlayerWhore)
			AdjustIntValue(None, InnkeeperShare, Math.Floor(GoldAmount / 2))
		EndIf
	EndIf

	If(GoldAmount > ClientGoldLeft)
		GoldAmount = ClientGoldLeft
		ReturnValue = 1
	ElseIf(IsGivingAllGold && GoldAmount > ClientGoldLeft)
		GoldAmount = ClientGoldLeft
		ReturnValue = 2
	ElseIf(IsGivingAllGold && GoldAmount <= ClientGoldLeft)
		GoldAmount = ClientGoldLeft
		ReturnValue = 3
	EndIf
	
	PlayerRef.AddItem(Septims, Math.Ceiling(GoldAmount))
	akClient.RemoveItem(Septims, Math.Ceiling(GoldAmount))
	IsGivingAllGold = False
	UnsetIntValue(None, Bill)
	Return ReturnValue
EndFunction
;Rewarding the player for a successful completed task
;Return value 0: Player received expected sum
;ReturnValue 1: Player received only what client had left
;ReturnValue 2: Player received all gold from client, still was less than expected
;ReturnValue 3: Player received all gold from client, much more than expected
;TODO: CONSIDER THE RETURNVALUE


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

Function IsSpectatorNearPC(Actor akPlayer, Actor akClient)

EndFunction

Function SetSexRequest(String SexType)
	SexAct = SexType
EndFunction

;On a successful request this function casts a spell to atop the same client asking a new request
;Also casts a stackable detrimental spell to the player to simulate a refractory period
Function AddSatisfiedClient(Int auiTask, Actor akClient, Actor akPlayer = None)
	If(auiTask == 1)
		PleasedByFoodSpell.Cast(akClient)
	ElseIf(auiTask == 2)
		PleasedBySexSpell.Cast(akClient)
		RefractorySpell.Cast(akClient)
		RefractorySpell.Cast(akPlayer)
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
		AdjustIntValue(None, "APPS.Stats.FoodOrdersRequested", 1)
		AdjustIntValue(None, "APPS.TotalFoodOrdersRequested", 1)

		If(abSuccess)
			AdjustIntValue(None, "APPS.Stats.FoodOrdersSucceeded", 1)
			AdjustIntValue(None, "APPS.Stats.TotalFoodOrdersSucceeded", 1)
		Else
			AdjustIntValue(None, "APPS.Stats.FoodOrdersFailed", 1)
			FoodOrdersFailed = GetIntValue(None, "APPS.Stats.FoodOrdersFailed")
			AdjustIntValue(None, "APPS.Stats.TotalFoodOrdersFailed", 1)
		EndIf
	ElseIf(auiStat == 2)
		AdjustIntValue(None, "APPS.Stats.SexOrdersRequested", 1)
		AdjustIntValue(None, "APPS.Stats.TotalSexOrdersRequested", 1)

		If(abSuccess)
			AdjustIntValue(None, "APPS.Stats.SexOrdersAccepted", 1)
			AdjustIntValue(None, "APPS.Stats.TotalSexOrdersAccepted", 1)
		Else
			AdjustIntValue(None, "APPS.Stats.SexOrdersDeclined", 1)
			AdjustIntValue(None, "APPS.Stats.TotalSexOrdersDeclined", 1)
		EndIf
	ElseIf(auiStat == 3)
		AdjustIntValue(None, "APPS.Stats.DanceOrdersRequested", 1)
		AdjustIntValue(None, "APPS.Stats.TotalDanceOrdersRequested", 1)

		If(abSuccess)
			AdjustIntValue(None, "APPS.Stats.DanceOrdersAccepted", 1)
			AdjustIntValue(None, "APPS.Stats.TotalDanceOrdersAccepted", 1)
		Else
			AdjustIntValue(None, "APPS.Stats.DanceOrdersDeclined", 1)
			AdjustIntValue(None, "APPS.Stats.TotalDanceOrdersDeclined", 1)
		EndIf
	EndIf

	If(!abSameGuest)
		AdjustIntValue(None, "APPS.Stats.GuestsServed", 1)
		AdjustIntValue(None, "APPS.Stats.TotalGuestsServed", 1)

		If(abSuccess)
			AdjustIntValue(None, "APPS.Stats.GuestsHappy", 1)
			AdjustIntValue(None, "APPS.Stats.TotalGuestsHappy", 1)
		Else
			AdjustIntValue(None, "APPS.Stats.GuestsUnhappy", 1)
			AdjustIntValue(None, "APPS.Stats.TotalGuestsUnhappy", 1)
		EndIf
	EndIf
EndFunction

;/
Function SkillLevelDifference(Actor akPlayer, Actor akClient, String akSexAct)
	Var.SexSkillDifference = SexLab.Stats.GetSkillLevel(akPlayer, akSexAct) - SexLab.Stats.GetSkillLevel(akClient, akSexAct)
EndFunction
/;

;On stopping the quest, this call will reset all necessary variables so this quest can be started fresh
Function ResetClients()
	UnsetIntValue(None, "APPS.Stats.HoursWorked")
	UnsetIntValue(None, "APPS.Stats.DanceOrdersDeclined")
	UnsetIntValue(None, "APPS.Stats.DanceOrdersRequested")
	UnsetIntValue(None, "APPS.Stats.DanceOrdersAccepted")
	UnsetIntValue(None, "APPS.Stats.FoodOrdersFailed")
	FoodOrdersFailed = 0
	UnsetIntValue(None, "APPS.Stats.FoodOrdersRequested")
	UnsetIntValue(None, "APPS.Stats.FoodOrdersSucceeded")
	UnsetIntValue(None, "APPS.Stats.SexOrdersDeclined")
	UnsetIntValue(None, "APPS.Stats.SexOrdersRequested")
	UnsetIntValue(None, "APPS.Stats.SexOrdersAccepted")
	UnsetIntValue(None, "APPS.Stats.GuestsServed")
	UnsetIntValue(None, "APPS.Stats.GuestsHappy")
	UnsetIntValue(None, "APPS.Stats.GuestsUnhappy")
	UnsetIntValue(None, "APPS.InnkeeperShare")
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
	IsGivingAllGold = True
EndFunction
APPS_FW_Relationship Property RS  Auto  
