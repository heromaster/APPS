Scriptname APPS_Controller_SharedFunctions Extends Quest
Import GlobalVariable

;------------------------------------------------------------------------------
; IMPORTANT: Don't translate any strings in here
;------------------------------------------------------------------------------
Class Property BeggarClass Auto
GlobalVariable Property SpectatorDistance Auto
Keyword Property CumAnal Auto
Keyword Property CumOral Auto
Keyword Property CumVaginal Auto
MagicEffect Property GoldChecker Auto
Message Property CleanUpMsg Auto
MiscObject Property Septims Auto
Quest Property APPS_SQ01 Auto
Spell Property CleanUpSpell Auto
Spell Property GoldChecking Auto  
APPS_Controller_Variables Property Var Auto
SexLabFramework Property SexLab Auto
;------------------------------------------------------------------------------
; Quest progression Properties to see if the Dragonborn got identified
;------------------------------------------------------------------------------
Faction Property DBIdentifiedFaction Auto
Quest Property DragonRising  Auto 
Quest Property WayOfTheVoice  Auto  
Quest Property TheHorn  Auto  
Quest Property DiplomaticImmunity  Auto  
Quest Property CorneredRat  Auto  
Quest Property AlduinsWall  Auto  
Quest Property ThroathOfTheWorld  Auto  
Quest Property ElderKnowledge  Auto  
Quest Property AlduinsBane  Auto  
Quest Property TheFallen  Auto  
Quest Property BladeInTheDark  Auto
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
	
	If(TavernJobCD + (Var.HoursToWork.GetValueInt() / 24) As Float  <= CurrentTime)
		Var.IsTavernJobOnCD = False
	ElseIf(WhoreJobBeginCD + Var.WaitBeforeBeginWhoreJob <= CurrentTime)
		Var.IsWhoreJobBeginOnCD = False
	EndIf
	
	If(Var.IsTavernJobOnCD || Var.IsWhoreJobBeginOnCD)
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

		GoldChecking.Cast(akClient)

		If(akClient.GetGoldAmount() < 30)
			If(akClient.IsChild())
				akClient.AddItem(Septims, 50)
			Else
				akClient.AddItem(Septims, 300 * HighestSexSkill)
			EndIf
		EndIf
	EndIf
EndFunction

;Changes the direction of being submissive or dominant
;Hardened cap is -50/50 and hard cap is -150/150
Function ChangeDomSubValue(Int Value)
	Var.DomSub.SetValueInt(Var.DomSub.GetValueInt() + Value)
	
	If(Var.DomSub.GetValueInt() > 150)
		Var.DomSub.SetValueInt(150)
	ElseIf(Var.DomSub.GetValueInt() < -150)
		Var.DomSub.SetValueInt(-150)
	EndIf
EndFunction

;Rewarding the player for a successful completed task
;Return value 0: Player received expected sum
;ReturnValue 1: Player received only what client had left
;ReturnValue 2: Player received all gold from client, still was less than expected
;ReturnValue 3: Player received all gold from client, much more than expected
;TODO: CONSIDER THE RETURNVALUE
Int Function EarnReward(Actor akPlayer, Actor akClient, Int auiTask)
	Float GoldAmount = 0
	Float SpeechCraftModifier = akPlayer.GetAV("Speechcraft") / 100 * Utility.RandomInt(Var.MinTipSC.GetValueInt(), Var.MaxTipSC.GetValueInt()) * 0.05
	Float TipPercentage = Utility.RandomInt(Var.MinTip.GetValueInt(), Var.MaxTip.GetValueInt()) * 0.05
	Int ClientGoldLeft = akClient.GetItemCount(Septims)
	Int ReturnValue = 1
	Int i = 0

	If(auiTask == 1)		
		GoldAmount = Math.Ceiling(Var.Bill * TipPercentage)
		GoldAmount += Math.Ceiling(Var.Bill * SpeechCraftModifier)
		Var.InnkeeperShare.SetValueInt(Var.InnkeeperShare.GetValueInt() + Var.Bill)
		GoldAmount += Var.Bill
	ElseIf(auiTask == 2)
		Float[] ProLvl = New Float[4]
		ProLvl[0] = 0
		ProLvl[1] = SexLab.GetPlayerStatLevel("Oral") + 1
		ProLvl[2] = SexLab.GetPlayerStatLevel("Vaginal") + 1
		ProLvl[3] = SexLab.GetPlayerStatLevel("Anal") + 1 
		Int Sexperience

		If(Var.SexActToInt == 1 && ProLvl[1] < 7)
			Sexperience = Math.Ceiling(0.7 *ProLvl[1] + 0.15 * ProLvl[2] + 0.15 * ProLvl[3]) 
		ElseIf(Var.SexActToInt == 2 && ProLvl[2] < 6)
			Sexperience = Math.Ceiling(0.7 * ProLvl[2] + 0.15 * ProLvl[1] + 0.15 * ProLvl[3])
		ElseIf(Var.SexActToInt == 3 && ProLvl[3] < 6)
			Sexperience = Math.Ceiling(0.7 * ProLvl[3] + 0.15 * ProLvl[1] + 0.15 * ProLvl[2])
		EndIf

		If(Sexperience > 7)
			Sexperience = 7
		ElseIf(Sexperience < 1)
			Sexperience = 1
		EndIf
	
		GoldAmount = Sexperience * Var.WhoreBasePayment.GetValueInt()

		If(Var.SexActToInt == 1)
			GoldAmount *= Var.OralMod.GetValue()
		ElseIf(Var.SexActToInt == 2)
			GoldAmount *= Var.VaginalMod.GetValue()
		ElseIf(Var.SexActToInt == 3)
			GoldAmount *= Var.AnalMod.GetValue()
		EndIf
		
		If(akClient.GetFactionRank(DBIdentifiedFaction) == 1)
			GoldAmount += GoldAmount * Var.DragonbornBonus.GetValue()
		EndIf

		;If(APPS_SQ01.IsStageDone(40))
		;	GoldAmount += GoldAmount * Var.WhoreBonus.GetValue()
		;EndIf

		If(Var.IsPlayerWhore)
			Var.InnkeeperShare.SetValueInt(Var.InnkeeperShare.GetValueInt() + Math.Floor(GoldAmount / 2) As Int)
		EndIf
	ElseIf(auiTask == 3)
		GoldAmount = Utility.RandomInt(Var.MinDanceReward.GetValueInt(), Var.MaxDanceReward.GetValueInt())
		
		If(Var.IsPlayerWhore)
			Var.InnkeeperShare.SetValueInt(Var.InnkeeperShare.GetValueInt() + Math.Floor(GoldAmount / 2) As Int)
		EndIf
	EndIf

	If(GoldAmount > ClientGoldLeft)
		GoldAmount = ClientGoldLeft
		ReturnValue = 1
	ElseIf(Var.IsGivingAllGold && GoldAmount > ClientGoldLeft)
		GoldAmount = ClientGoldLeft
		ReturnValue = 2
	ElseIf(Var.IsGivingAllGold && GoldAmount <= ClientGoldLeft)
		GoldAmount = ClientGoldLeft
		ReturnValue = 3
	EndIf
	
	akPlayer.AddItem(Septims, Math.Ceiling(GoldAmount))
	akClient.RemoveItem(Septims, Math.Ceiling(GoldAmount))
	Var.IsGivingAllGold = False

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

	If(Var.SexActToInt == 1 && (akClient.GetBaseObject() As ActorBase).GetSex() == 1 && (akPlayer.GetBaseObject() As ActorBase).GetSex() == 1)
		SexAnimationList = SexLab.GetAnimationsByTag(2, "Cunnilingus", "Tribadism", tagSuppress = "Zaz", requireAll = False)
	Else
		SexAnimationList = SexLab.GetAnimationsByTag(2, Var.SexAct, tagSuppress = "Zaz")
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
			CleanUpSpell.Cast(akPlayer)
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

	If(!DragonRising.IsCompleted())
		Return
	EndIf

	If(TheFallen.IsCompleted())
		akSpeaker.SetFactionRank(DBIdentifiedFaction, 0)
		Return
	EndIf

	If(WayOfTheVoice.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(TheHorn.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(BladeInTheDark.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(DiplomaticImmunity.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(CorneredRat.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(AlduinsWall.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(ThroathOfTheWorld.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(ElderKnowledge.IsCompleted())
		Chance += ChanceMult
	EndIf
	
	If(AlduinsBane.IsCompleted())
		Chance += ChanceMult
	EndIf

	If(Chance > Utility.RandomInt(0, 100))
		akSpeaker.SetFactionRank(DBIdentifiedFaction, 1)
	EndIf
EndFunction

Function IsSpectatorNearPC(Actor akPlayer, Actor akClient)

EndFunction

Function SetSexRequest(String SexType)
	Var.SexAct = SexType
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
		Var.FoodOrdersRequested += 1
		Var.TotalFoodOrdersRequested += 1

		If(abSuccess)
			Var.FoodOrdersSucceeded += 1
			Var.TotalFoodOrdersSucceeded += 1
		Else
			Var.FoodOrdersFailed += 1
			Var.TotalFoodOrdersFailed += 1
		EndIf
	ElseIf(auiStat == 2)
		Var.SexOrdersRequested += 1
		Var.TotalSexOrdersRequested += 1

		If(abSuccess)
			Var.SexOrdersAccepted += 1
			Var.TotalSexOrdersAccepted += 1
		Else
			Var.SexOrdersDeclined += 1
			Var.TotalSexOrdersDeclined += 1
		EndIf
	ElseIf(auiStat == 3)
		Var.DanceOrdersRequested += 1
		Var.TotalDanceOrdersRequested += 1

		If(abSuccess)
			Var.DanceOrdersAccepted += 1
			Var.TotalDanceOrdersAccepted += 1
		Else
			Var.DanceOrdersDeclined += 1
			Var.TotalDanceOrdersDeclined += 1
		EndIf
	EndIf

	If(!abSameGuest)
		Var.GuestsServed += 1
		Var.TotalGuestsServed += 1

		If(abSuccess)
			Var.GuestsHappy += 1
			Var.TotalGuestsHappy += 1
		Else
			Var.GuestsUnhappy += 1
			Var.TotalGuestsUnhappy += 1
		EndIf
	EndIf
EndFunction

;On stopping the quest, this call will reset all necessary variables so this quest can be started fresh
Function ResetClients()
	Var.HoursWorked = 0
	Var.DanceOrdersDeclined = 0
	Var.DanceOrdersRequested = 0
	Var.DanceOrdersAccepted = 0
	Var.FoodOrdersFailed = 0
	Var.FoodOrdersRequested = 0
	Var.FoodOrdersSucceeded = 0
	Var.SexOrdersDeclined = 0
	Var.SexOrdersRequested = 0
	Var.SexOrdersAccepted = 0
	Var.GuestsServed = 0
	Var.GuestsHappy = 0
	Var.GuestsUnhappy = 0
	Var.InnkeeperShare.SetValueInt(0)
EndFunction

;Cooldowns necessary to progress the storyline and to simulate restings
Function SetCooldowns(Int auiCDTask)	
	If(auiCDTask == 1)
		Var.IsTavernJobOnCD = True
		TavernJobCD = Utility.GetCurrentGameTime()
	ElseIf(auiCDTask == 2)
		Var.IsWhoreJobBeginOnCD = True
		WhoreJobBeginCD = Utility.GetCurrentGameTime()
	EndIf
	
	RegisterForSingleUpdateGameTime(0.5)
EndFunction

;If player could agree with client to give all his gold on a successful task
Function SetIsGivingAllGold()
	Var.IsGivingAllGold = True
EndFunction