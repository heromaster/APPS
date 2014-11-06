;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname APPS_SQ01_Order_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TavernGuest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TavernGuest Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE APPS_SQ01_Order_Functions
Quest __temp = self as Quest
APPS_SQ01_Order_Functions kmyQuest = __temp as APPS_SQ01_Order_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CheckOrder()
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE APPS_SQ01_Order_Functions
Quest __temp = self as Quest
APPS_SQ01_Order_Functions kmyQuest = __temp as APPS_SQ01_Order_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.DeductWages()
kmyQuest.AddToStatistics(1, False)
kmyQuest.RS.ModRelationshipPoints(Alias_TavernGuest.GetActorRef(), -10)
kmyQuest.RS.ModRelationshipPoints(Alias_Innkeeper.GetActorRef(), -5)
SetObjectiveFailed(20)
Reset()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE APPS_SQ01_Order_Functions
Quest __temp = self as Quest
APPS_SQ01_Order_Functions kmyQuest = __temp as APPS_SQ01_Order_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.RemoveOrderedItems()
kmyQuest.EarnReward(Alias_TavernGuest.GetActorRef(), 1)
kmyQuest.AddSatisfiedClient(1, Alias_TavernGuest.GetActorRef())
SetObjectiveCompleted(20)
Reset()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Alias_TavernGuest.GetActorRef().EvaluatePackage()
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
