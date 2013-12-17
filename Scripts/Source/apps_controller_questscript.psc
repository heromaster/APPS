;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 14
Scriptname APPS_Controller_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY ProstituteF1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ProstituteF1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ProstituteF2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ProstituteF2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PC
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PC Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Tavern
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Tavern Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SaadiaNPC
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SaadiaNPC Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TavernRulesBook
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TavernRulesBook Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ProstituteSpawnSpot
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ProstituteSpawnSpot Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TavernJobBroom
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TavernJobBroom Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TavernJobOutfit
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TavernJobOutfit Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TavernJobBoots
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TavernJobBoots Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ChestIdleMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ChestIdleMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
Alias_ProstituteSpawnSpot.GetRef().SetPosition(-127, -1107, 68)
Alias_ProstituteSpawnSpot.GetRef().SetAngle(0, 0, 0)
Alias_ProstituteF1.GetActorRef().Enable()
Alias_ProstituteF1.GetActorRef().MoveTo(Alias_ProstituteSpawnSpot.GetRef())
Alias_ProstituteF2.GetActorRef().Enable()
Alias_ProstituteF2.GetActorRef().MoveTo(Alias_ProstituteSpawnSpot.GetRef())
ProstitutesIntroScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
If(ProstitutesIntroScene.IsPlaying())
	ProstitutesIntroScene.Stop()
EndIf

WhoreJob_TestScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
ThisTest.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Alias_PC.GetRef().AddItem(Alias_TavernJobOutfit.GetRef())
Alias_PC.GetRef().AddItem(Alias_TavernJobBoots.GetRef())
Alias_PC.GetRef().AddItem(Alias_TavernJobBroom.GetRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
TavernJobScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
WhoreJob_ApplicationScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
APPS_SQ01.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
Alias_PC.GetRef().AddItem(Alias_TavernRulesBook.GetRef())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property APPS_SQ01  Auto  
Quest Property APPS_SQ02  Auto  
Scene Property TavernJobScene  Auto  
Scene Property WhoreJob_ApplicationScene  Auto  
Scene Property WhoreJob_TestScene  Auto  
Scene Property ProstitutesIntroScene  Auto  
Quest Property ThisTest  Auto  
