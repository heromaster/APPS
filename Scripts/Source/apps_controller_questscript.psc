;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_Controller_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Saadia
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Saadia Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Tavern
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Tavern Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BarLeaningMarker2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BarLeaningMarker2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CorrectBarCounter
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CorrectBarCounter Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TavernJobBroom
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TavernJobBroom Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ChestIdleMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ChestIdleMarker Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BarLeaningMarker1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BarLeaningMarker1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY chest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_chest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TavernJobBoots
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TavernJobBoots Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TavernJobOutfit
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TavernJobOutfit Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY InnLawsBook
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_InnLawsBook Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CorrectLeaningMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CorrectLeaningMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
TavernJobScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property TavernJobScene Auto
