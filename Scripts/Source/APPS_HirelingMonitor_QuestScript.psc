;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname APPS_HirelingMonitor_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Hireling
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Hireling Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE APPS_HirelingMonitor_Functions
Quest __temp = self as Quest
APPS_HirelingMonitor_Functions kmyQuest = __temp as APPS_HirelingMonitor_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.RegisterForSingleUpdateGameTime(kmyQuest.PaymentInterval)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
