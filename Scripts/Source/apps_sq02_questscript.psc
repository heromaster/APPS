;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_SQ02_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY ProstituteF2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ProstituteF2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PC
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PC Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ViewSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ViewSpot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ProstituteF1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ProstituteF1 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE APPS_SQ02_Functions
Quest __temp = self as Quest
APPS_SQ02_Functions kmyQuest = __temp as APPS_SQ02_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.SetViewSpot(Alias_ViewSpot.GetRef())
kmyQuest.PerformSex(Alias_ProstituteF2.GetActorRef(), Alias_PC.GetActorRef(), 1)
Alias_ProstituteF1.GetActorRef().PathToReference(Alias_ViewSpot.GetRef(), 0.3)
CompleteQuest()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
