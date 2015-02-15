;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 33
Scriptname APPS_FFQ001_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Dom
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Dom Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Habitation
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Habitation Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PointedChair
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PointedChair Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY InnMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_InnMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PC
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PC Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Inn
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Inn Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FavoriteChair
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FavoriteChair Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
FollowerMonitor.Stop()
SetObjectiveCompleted(5)
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
FollowerFunctions.IsFollowing = False
Alias_Dom.GetActorRef().EvaluatePackage()
;Utility.Wait(10)
;Alias_Dom.GetActorRef().PlayIdle(StopDrinking)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
FollowerFunctions.IsFollowing = True
FollowerMonitor.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE APPS_FFQ001_Functions
Quest __temp = self as Quest
APPS_FFQ001_Functions kmyQuest = __temp as APPS_FFQ001_Functions
;END AUTOCAST
;BEGIN CODE
SetObjectiveDisplayed(20)
kmyQuest.BeginSelectChairEvents()
;InTheInnScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
FollowerMonitor.Stop()
SetObjectiveCompleted(5)
SetObjectiveDisplayed(15)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN CODE
Alias_Dom.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
Game.FastTravel(WhiterunCarriageMarker)
Alias_Dom.GetRef().MoveTo(Alias_PC.GetRef(), 60)
Alias_Dom.GetActorRef().EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
Utility.Wait(10)
Alias_Dom.GetActorRef().PlayIdle(StopDrinking)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
;Stage will be called when the player has delayed the task

RegisterForSingleUpdateGameTime(Libs.RandomGameTime(20, 24))

SetObjectiveDisplayed(5)
SetObjectiveDisplayed(6)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
;FollowerFunctions.IsFollowing = False
SetObjectiveCompleted(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
;Initialization stage
SetActive()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
setObjectiveCompleted(25)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Follower_Functions Property FollowerFunctions Auto
APPS_Libs_Functions Property Libs Auto
GlobalVariable Property GameHour  Auto  
Idle Property StopDrinking  Auto  
ObjectReference Property WhiterunCarriageMarker  Auto  
Package Property LookForSeatsPackage  Auto  
Quest Property FollowerMonitor  Auto  
Scene Property InTheInnScene  Auto  

Event OnUpdateGameTime()
	SetStage(5)
EndEvent
