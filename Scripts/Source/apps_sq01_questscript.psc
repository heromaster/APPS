;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname APPS_SQ01_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Tavern
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Tavern Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Patron
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Patron Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bed
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bed Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 30
kmyQuest.CheckOrder()
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
Alias_Patron.GetActorRef().EvaluatePackage()
SetObjectiveDisplayed(20, False)
SetObjectiveDisplayed(30, False)
SetObjectiveDisplayed(35, False)
SetObjectiveCompleted(10, False)
SetObjectiveCompleted(20, False)
SetObjectiveFailed(30, False)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 35
kmyQuest.RemoveOrderedItems()
kmyQuest.AddDissatisfiedClient(Alias_Patron.GetActorRef(), 1)
SetObjectiveFailed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.RemoveOrderedItems()
kmyQuest.AddSatisfiedClient(Alias_Patron.GetActorRef(), 1)
Controller.EarnReward(Alias_Patron.GetActorRef(), 1)
SetObjectiveCompleted(30)
Alias_Patron.GetActorRef().EvaluatePackage()
SetObjectiveDisplayed(20, False)
SetObjectiveDisplayed(30, False)
SetObjectiveCompleted(10, False)
SetObjectiveCompleted(20, False)
SetObjectiveCompleted(30, False)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
SetObjectiveFailed(20)

If(RS.GetRelationshipPoints(Alias_Patron.GetActorRef()) > -150)
	RS.ModRelationshipPoints(Alias_Patron.GetActorRef(), -10)
EndIf

kmyQuest.AddDissatisfiedClient(Alias_Patron.GetActorRef(), 1)

SetObjectiveDisplayed(10, False)
SetObjectiveDisplayed(20, False)
SetObjectiveCompleted(10, False)
SetObjectiveFailed(20, False)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 70
Controller.PerformSexAct()
;Controller.SkillLevelDifference(Alias_PC.GetActorRef(), Alias_TavernGuest.GetActorRef(), Var.SexAct)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 50
RoomTrigger.Enable()
Alias_Patron.GetActorRef().EvaluatePackage()
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
PlayerRef.AddToFaction(ServicesWhiterunBanneredMare)
RegisterForSingleUpdateGameTime(1)

;/ temporarily disabled until full support of known Follower Frameworks
SQ01_DismissFollower.Start()
/;

SetObjectiveDisplayed(0)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 20
Alias_Patron.GetActorRef().EvaluatePackage()
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 10
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 60
SetObjectiveCompleted(50)
SetObjectiveDisplayed(60)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Controller_Functions Property Controller Auto
APPS_FW_Relationship Property RS Auto
Actor Property PlayerRef Auto
Faction Property ServicesWhiterunBanneredMare Auto
GlobalVariable Property PlayerFollowerCount Auto
ObjectReference Property RoomTrigger Auto
