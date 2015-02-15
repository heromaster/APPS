;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname APPS_S02_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Dom
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Dom Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Sub
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Sub Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE APPS_S02_Functions
Quest __temp = self as Quest
APPS_S02_Functions kmyQuest = __temp as APPS_S02_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.StartOral(Alias_Sub.GetActorRef(), Alias_Dom.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
RegisterForModEvent("APPS_SceneEnd", "OnSceneEnd")
Follower_Functions.Kiss(Alias_Sub.GetActorRef(), Alias_Dom.GetActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
ActorUtil.AddPackageOverride(Alias_Dom.GetActorRef(), AfterKissPackage)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Follower_Functions Property Follower_Functions Auto
Package Property AfterKissPackage  Auto  

Event OnSceneEnd(String asName, String asString, Float afNum, Form akSender)
	UnregisterForModEvent("APPS_SceneEnd")
	SetStage(10)
EndEvent
