;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_FFQ001_BM_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Chair02
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair02 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair04
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair04 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Dom
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Dom Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair08
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair08 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TableGroup3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TableGroup3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bench1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bench1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair03
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair03 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TableGroup1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TableGroup1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TableGroup2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TableGroup2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair09
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair09 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair12
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair12 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TableGroup5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TableGroup5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair11
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair11 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair01
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair01 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY BarGroup1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_BarGroup1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TableGroup4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TableGroup4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bench2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bench2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair13
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair13 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair05
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair05 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair07
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair07 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair10
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair10 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Chair06
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chair06 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
If(StorageUtil.HasFormValue(Alias_Dom.GetActorRef(), "APPS.Follower.FavoritInn"))
	Alias_FavoriteChair.ForceRefTo(StorageUtil.GetFormValue(Alias_Dom.GetActorRef(), "APPS.Follower.FavoriteChair") As ObjectReference)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Location Property BanneredMare  Auto  
ReferenceAlias Property Alias_FavoriteChair  Auto  

