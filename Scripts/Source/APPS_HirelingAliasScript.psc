Scriptname APPS_HirelingAliasScript extends ReferenceAlias  
APPS_Follower_Functions Property FollowerFunctions Auto
Actor Property PlayerRef Auto
Quest Property APPS_FFQ04 Auto
Faction Property CurrentHirelingFaction Auto
Faction Property SubDomRankFaction Auto
GlobalVariable Property PlayerFollowerCount Auto
Keyword Property LocationDungeon Auto

Event OnUpdateGameTime()
	If Self.GetActorRef().GetAV("WaitingforPlayer") == 0
		UnRegisterForUpdateGameTime()
	Else
		FollowerFunctions.IsFollowerAbandoned = True
		FollowerFunctions.DismissFollower(1)
		UnRegisterForUpdateGameTime()
	EndIf	
EndEvent

Event OnUnload()
	If Self.GetActorRef().GetAV("WaitingforPlayer") == 1
		FollowerFunctions.FollowerWait()
	EndIf
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	If(FollowerFunctions.FollowerWaitCounter == 8 && akOldLoc.HasKeyword(LocationDungeon) && !akNewLoc.HasKeyword(LocationDungeon))
		APPS_FFQ04.Start()
	ElseIf(!akOldLoc.HasKeyword(LocationDungeon) && akNewLoc.HasKeyword(LocationDungeon))
		FollowerFunctions.FollowerWaitCounter = 0
	EndIf
EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	If (akTarget == PlayerRef)
		FollowerFunctions.DismissFollower(0)
	EndIf
EndEvent

Event OnDeath(Actor akKiller)
	PlayerFollowerCount.SetValue(0)
	Self.GetActorRef().RemoveFromFaction(CurrentHirelingFaction)
	Self.Clear()
EndEvent

Function ChangeOutfit(Bool abIsSwitchToArmor = True)
	Actor Follower = GetActorRef()

	If(abIsSwitchToArmor)
		Int i = StorageUtil.IntListCount(Follower, "APPS.Follower.Armors") - 1

		While(i >= 0)
			If(Follower.GetLevel() >= StorageUtil.IntListGet(Follower, "APPS.Follower.Armors", i))
				Follower.SetOutfit(StorageUtil.FormListGet(Follower, "APPS.Follower.Armors", i) As Outfit)
				Return
			EndIf

			i -= 1
		EndWhile
	Else
		If(Follower.IsInFaction(SubDomRankFaction))
			If(Follower.GetFactionRank(SubDomRankFaction) == 0)

			ElseIf(Follower.GetFactionRank(SubDomRankFaction) == 1)

			ElseIf(Follower.GetFactionRank(SubDomRankFaction) == 2)

			ElseIf(Follower.GetFactionRank(SubDomRankFaction) == 3)

			EndIf
		EndIf
	EndIf
EndFunction