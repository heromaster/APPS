;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname APPS_SQ01_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Tavern
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Tavern Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Patron
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Patron Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

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

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property PlayerRef Auto
Faction Property ServicesWhiterunBanneredMare Auto
GlobalVariable Property PlayerFollowerCount Auto
