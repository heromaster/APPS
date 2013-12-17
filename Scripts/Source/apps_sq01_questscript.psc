;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 86
Scriptname APPS_SQ01_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Tavern
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Tavern Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PC
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PC Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TavernGuest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TavernGuest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ProstituteSpawnSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ProstituteSpawnSpot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SweepSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SweepSpot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Dancespot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Dancespot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Follower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Follower Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bard
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bard Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_76
Function Fragment_76()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 70
Controller.ChangeDomSubValue(-2)
Controller.PerformSexAct(Alias_PC.GetActorRef(), Alias_TavernGuest.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
Controller.AddSatisfiedClient(2, Alias_TavernGuest.GetActorRef(), Alias_PC.GetActorRef())
Controller.EarnReward(Alias_PC.GetActorRef(), Alias_TavernGuest.GetActorRef(), 2)
Controller.CleanUp(Alias_PC.GetActorRef())
Var.IsNPCFollowing = False
Alias_TavernGuest.GetActorRef().EvaluatePackage()
SetObjectiveCompleted(10, False)
SetObjectiveCompleted(50)
SetObjectiveDisplayed(50, False)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_84
Function Fragment_84()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_67
Function Fragment_67()
;BEGIN CODE
Game.EnablePlayerControls()
Controller.ResetClients()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_64
Function Fragment_64()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
Alias_SweepSpot.ForceRefTo(kmyQuest.FindSweepSpot(Alias_PC.GetActorRef()))
SweepTavernScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
game.disablePlayerControls()
Game.SetPlayerAiDriven(True)
SetObjectiveCompleted(10)
SetObjectiveDisplayed(60)
DanceScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 20
Alias_TavernGuest.GetActorRef().EvaluatePackage()
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_44
Function Fragment_44()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 60
Var.IsNPCFollowing = True
Controller.ChangeDomSubValue(-1)
Alias_TavernGuest.GetActorRef().EvaluatePackage()
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_62
Function Fragment_62()
;BEGIN CODE
Game.EnablePlayerControls(True, True, True, True, False, True, True, True, 0)
Game.SetPlayerAiDriven(False)
Controller.AddSatisfiedClient(3, Alias_TavernGuest.GetActorRef())
Controller.EarnReward(Alias_PC.GetActorRef(), Alias_TavernGuest.GetActorRef(), 3)
Var.IsGivingAllGold = False
SetObjectiveCompleted(10, False)
SetObjectiveCompleted(60)
SetObjectiveDisplayed(60, False)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 30
kmyQuest.CheckOrder()
Game.DisablePlayerControls(False, False, False, False, True, True, False, False, 0)
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_52
Function Fragment_52()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 40
kmyQuest.RemoveOrderItems(Alias_PC.GetActorRef())
Controller.AddDissatisfiedClient(1, Alias_TavernGuest.GetActorRef())
Game.EnablePlayerControls(True, True, True, True, False, True, True, True, 0)
Alias_TavernGuest.GetActorRef().EvaluatePackage()
SetObjectiveFailed(30)
SetObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_80
Function Fragment_80()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_75
Function Fragment_75()
;BEGIN CODE
Var.IsGivingAllGold = True
Game.DisablePlayerControls()
Game.SetPlayerAiDriven(True)
SetObjectiveCompleted(10)
SetObjectiveDisplayed(60)
DanceScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_59
Function Fragment_59()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.WagesDeduction()
Var.Bill = 0
SetObjectiveCompleted(40)
SetObjectiveCompleted(10, False)
SetObjectiveDisplayed(20, False)
SetObjectiveDisplayed(30, False)
SetObjectiveDisplayed(40, False)
SetObjectiveFailed(30, False)
SetObjectiveCompleted(40, False)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_69
Function Fragment_69()
;BEGIN CODE
Controller.SetCooldowns(1)
Var.DaysWorked += 1
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_74
Function Fragment_74()
;BEGIN CODE
APPS_Controller.SetStage(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_65
Function Fragment_65()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 120
Alias_Innkeeper.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
Game.DisablePlayerControls(False, False, abSneaking = True, abMenu = False, abActivate = False)
kmyQuest.RegisterForSingleUpdateGameTime(1)
kmyQuest.DismissFollower(Alias_Follower.GetActorRef())
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 10
SetObjectiveDisplayed(0)
SetObjectiveDisplayed(10)
RegisterForSingleUpdate(0.5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_70
Function Fragment_70()
;BEGIN CODE
Controller.SetCooldowns(1)
Controller.SetCooldowns(2)
Var.DaysWorked += 1
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_61
Function Fragment_61()
;BEGIN CODE
Var.IsGivingAllGold = True
Game.DisablePlayerControls()
Game.SetPlayerAiDriven(True)
SetObjectiveCompleted(10)
SetObjectiveDisplayed(60)
DanceScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_46
Function Fragment_46()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.RemoveOrderItems(Alias_PC.GetActorRef())
Controller.EarnReward(Alias_PC.GetActorRef(), Alias_TavernGuest.GetActorRef(), 1)
Controller.AddSatisfiedClient(1, Alias_TavernGuest.GetActorRef())
Game.EnablePlayerControls(True, True, True, True, False, True, True, True, 0)
Var.Bill = 0
Alias_TavernGuest.GetActorRef().EvaluatePackage()
SetObjectiveCompleted(30)
SetObjectiveDisplayed(20, False)
SetObjectiveDisplayed(30, False)
SetObjectiveCompleted(10, False)
SetObjectiveCompleted(20, False)
SetObjectiveCompleted(30, False)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_78
Function Fragment_78()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_43
Function Fragment_43()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 70
Controller.ChangeDomSubValue(-1)
Controller.PerformSexAct(Alias_PC.GetActorRef(), Alias_TavernGuest.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_82
Function Fragment_82()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_81
Function Fragment_81()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_79
Function Fragment_79()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_85
Function Fragment_85()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_83
Function Fragment_83()
;BEGIN CODE
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Controller_SharedFunctions Property Controller  Auto  
APPS_Controller_Variables Property Var Auto 
Faction Property InnBMFaction Auto
MagicEffect Property DissatisfiedEffect Auto
MagicEffect Property SatisfiedEffect Auto
Scene Property DanceScene  Auto      
Scene Property SweepTavernScene  Auto  
Quest Property APPS_Controller  Auto 

Event OnUpdate()
	Actor RandomNPC = None
	Cell PCLocation = Alias_PC.GetActorRef().GetParentCell()
	Int Index = PCLocation.GetNumRefs(43)
	
	While(Index > 0)
		Index -= 1
		RandomNPC = PCLocation.GetNthRef(Index, 43) As Actor

		If(!RandomNPC.HasMagicEffect(DissatisfiedEffect)  && !RandomNPC.HasMagicEffect(SatisfiedEffect))
			Return
		EndIf
	EndWhile
	
	SetStage(110)
EndEvent 

Quest Property IntroduceProstitutes  Auto  
