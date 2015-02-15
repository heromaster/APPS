Scriptname APPS_Follower_Functions extends Quest  Conditional
APPS_FollowerMonitor_Functions Property FollowerMonitor Auto
APPS_Hireling_Functions Property Hireling Auto
APPS_Domina_Functions Property Domina Auto
SexLabFramework Property SexLab Auto
Bool[] Property StripSlots  Auto
Bool Property IsArmorPerkFixInstalled Auto Conditional Hidden
Bool Property IsFollowerAbandoned Auto Conditional Hidden
Bool Property IsFollowing Auto Conditional Hidden
Bool Property IsWaiting Auto Conditional Hidden
Bool Property IsWillingToWait Auto Conditional Hidden
Bool Property IsPlayerIdles Auto Conditional Hidden
Bool Property IsCanFollow Auto Conditional Hidden
Bool Property IsDismissed Auto Conditional Hidden
Bool Property IsCanBeDismissed Auto Conditional Hidden
Bool Property IsPlayerTurned = False Auto Conditional Hidden
Int Property FollowerDistance = 2 Auto Conditional Hidden
Int Property FollowerWaitCounter Auto Conditional Hidden
Faction Property CurrentHirelingFaction Auto
Faction Property DismissedFollowerFaction Auto
Faction Property SubDomFaction Auto
Faction Property SubDomRankFaction Auto
GlobalVariable Property PlayerFollowerCount Auto
Message Property  FollowerDismissMessage Auto
Message Property  FollowerDismissMessageWait Auto
Quest Property pDialogueFollower  Auto
ReferenceAlias Property Alias_PC Auto
ReferenceAlias Property Alias_Follower Auto

Event OnRelationshipEnded(String asName, String asString, Float afNonConsEnd, Form akSender)
	Actor Dom = Alias_Follower.GetActorRef()

;	Comments are for the final framework.

;	Dom.RemoveFromFaction(SubDomFaction)
;	Dom.RemoveFromFaction(SubDomRankFaction)
;	StorageUtil.SetIntValue(Dom, "APPS.Follower.HasEndedNonCons", 1)

;	This code is test mod only.
	Dom.SetFactionRank(SubDomRankFaction, 0)
	Dom.SetFactionRank(SubDomFaction, 0)

	If(afNonConsEnd == 0)
;		Dom.RemoveFromFaction(PotentialFollowerFaction)
;		Dom.RemoveFromFaction(PotentialHirelingFaction)
	EndIf
EndEvent

Event OnStageChange(String asName, String asString, Float afNum, Form akSender)
	sslThreadController tc = SexLab.GetActorController(Alias_PC.GetActorRef())
	tc.EndAnimation()
	SendModEvent("APPS_SceneEnd")
	UnregisterForModEvent("StageEnd")
EndEvent

Function SetFollower(Actor akFollower)
	Actor Player = Alias_PC.GetActorRef()

	If(akFollower.IsInFaction(SubDomRankFaction))
		Domina.SwitchCurrentDomina(akFollower)
	EndIf

	Alias_Follower.ForceRefTo(akFollower)
	akFollower.RemoveFromFaction(DismissedFollowerFaction)

	If(akFollower.GetRelationshipRank(Player) < 3 && akFollower.GetRelationshipRank(Player) >= 0)
		akFollower.SetRelationshipRank(Player, 3)
	EndIf

	akFollower.SetPlayerTeammate()
	PlayerFollowerCount.SetValue(1)
	akFollower.EvaluatePackage()
	IsFollowing = True
	IsWaiting = False
	IsCanFollow = True
	IsDismissed = False
	
	If(akFollower.GetFactionRank(SubDomRankFaction) == 3)
		IsCanBeDismissed = False
	Else
		IsCanBeDismissed = True
	EndIf

	FollowerMonitor.Start()
EndFunction

Function SetFollowerDistance(Int aiDistance)
	FollowerDistance = aiDistance
	Alias_Follower.GetActorRef().EvaluatePackage()
EndFunction

Function FollowerWait()
	Actor Follower = Alias_Follower.GetActorRef()
	Follower.SetAV("WaitingForPlayer", 1)
	Alias_Follower.RegisterForUpdateGameTime(72)
EndFunction

Function DismissFollower(Int aiMessage = 0)
	Debug.Notification("Try to dismiss follower")
	Actor Follower = Alias_Follower.GetActorRef()

	If(!Follower.IsDead())
		If(aiMessage == 0)
			FollowerDismissMessage.Show()
		ElseIf(aiMessage == 1)
			IsFollowerAbandoned = True
			FollowerDismissMessageWait.Show()
		EndIf

		Follower.StopCombatAlarm()
		Follower.AddToFaction(DismissedFollowerFaction)
		Follower.SetPlayerTeammate(False)

		If(Follower.IsInFaction(CurrentHirelingFaction))
			Hireling.DismissHireling(Follower)
		EndIf

		Follower.SetAV("WaitingForPlayer", 0)	
		Alias_Follower.Clear()
		IsDismissed = False
		IsFollowing = False
		PlayerFollowerCount.SetValue(0)
	EndIf

	FollowerMonitor.Stop()
EndFunction

Function FactionProgress(Int aiPointsRank0 = 0, Int aiPointsRank1 = 0, Int aiPointsRank2 = 0, Int aiPointsRank3 = 0, Int aiPointsRank4 = 0, Bool abIsInheritFirstValue = False)
	Actor Dom = Alias_Follower.GetActorRef()
	Int Rank = Dom.GetFactionRank(SubDomRankFaction)

	If(abIsInheritFirstValue)
		If(aiPointsRank0 != 0)
			aiPointsRank1 = aiPointsRank0
			aiPointsRank2 = aiPointsRank0
			aiPointsRank3 = aiPointsRank0
			aiPointsRank4 = aiPointsRank0
		Else
			Return
		EndIf
	EndIf

	If(aiPointsRank0 != 0 && Rank == 0)
		Dom.ModFactionRank(SubDomFaction, aiPointsRank0)
	EndIf

	If(aiPointsRank1 != 0 && Rank == 1)
		Dom.ModFactionRank(SubDomFaction, aiPointsRank1)
	EndIf

	If(aiPointsRank2 != 0 && Rank == 2)
		Dom.ModFactionRank(SubDomFaction, aiPointsRank2)
	EndIf

	If(aiPointsRank3 != 0 && Rank == 3)
		Dom.ModFactionRank(SubDomFaction, aiPointsRank3)
	EndIf

	If(aiPointsRank4 != 0 && Rank == 4)
		Dom.ModFactionRank(SubDomFaction, aiPointsRank4)
	EndIf

	If(Dom.GetFactionRank(SubDomFaction) >= 100)
		If(Rank < 4 && StorageUtil.HasIntValue(None, "APPS.Follower.IsTransitionS" + Rank + "Completed"))
			Dom.SetFactionRank(SubDomRankFaction, Rank + 1)
			Dom.SetFactionRank(SubDomFaction, Dom.GetFactionRank(SubDomFaction) - 100)
		ElseIf(Rank < 4)
			StorageUtil.SetIntValue(None, "APPS.Follower.NextTask", (Rank + 1) * 1000 + 999)
		EndIf
	ElseIf(Dom.GetFactionRank(SubDomFaction) < 0)
		If(Rank > 0)
			Dom.SetFactionRank(SubDomRankFaction, Rank - 1)
			Dom.SetFactionRank(SubDomFaction, 25)
		EndIf
	EndIf

	If(Rank == 4 && Dom.GetFactionRank(SubDomFaction) > 100)
		Dom.SetFactionRank(SubDomFaction, 100)
	ElseIf(Rank == 0 && Dom.GetFactionRank(SubDomFaction) < 0)
		EndRelationship()
	EndIf
EndFunction

Function EndRelationship(Bool abIsConsensualEnd = False)
	If(!abIsConsensualEnd)
;		ActorUtil.AddOverridePackage(Dom, NonConsEndPackage)
	Else
;		ActorUtil.AddOverridePackage(Dom, ConsEndPackage)
	EndIf
EndFunction

Function LockOrUnlockTasks(Quest akQuest, Bool abIsUnlocking = True)
	If(abIsUnlocking)
		If(!akQuest.IsCompleted())
			Return
		EndIf

		Int i = 0

		While(i < StorageUtil.IntListCount(akQuest, "APPS.Follower.UnlockTasks"))
			Int UnlockTask = StorageUtil.IntListGet(akQuest, "APPS.Follower.UnlockTasks", i)

			If(StorageUtil.IntListFind(None, "APPS.Follower.ExcludedTasks", UnlockTask) > -1)
				StorageUtil.IntListRemoveAt(None, "APPS.Follower.ExcludedTasks", UnlockTask)
			EndIf

			i += 1
		EndWhile
	Else
;		If(abIsCompleted)
;			Return
;		EndIf
	EndIf
EndFunction

Function InsertIntoLockTaskList(Quest akQuest, Int aiTaskID)
	If(StorageUtil.IntListFind(akQuest, "APPS.Follower.UnlockTasks", aiTaskID) == -1)
		StorageUtil.IntListAdd(akQuest, "APPS.Follower.UnlockTasks", aiTaskID)
	EndIf
EndFunction

Function Kiss(Actor akKissPartner1, Actor akKissPartner2)
	sslBaseAnimation[] AnimationList
	Actor[] ActorList = New Actor[2]
	ActorList[0] = akKissPartner1
	ActorList[1] = akKissPartner2
	AnimationList = SexLab.GetAnimationsByTags(2, "Loving,Kissing,Standing", requireAll = True)
	StripSlots[0] = True

	RegisterForModEvent("StageEnd", "OnStageChange")
	sslThreadModel th = SexLab.NewThread()
	th.AddActor(ActorList[0])
	th.AddActor(ActorList[1])
	th.SetAnimations(AnimationList)
	th.DisableLeadIn(True)
	th.DisableBedUse()
	th.SetStrip(ActorList[0], StripSlots)
	th.SetStrip(ActorList[1], StripSlots)
	th.StartThread()
EndFunction