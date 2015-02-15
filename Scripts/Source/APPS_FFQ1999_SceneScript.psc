;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_FFQ1999_SceneScript Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Game.EnablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.DisablePlayerControls()
Alias_PC.GetActorRef().EquipItem(PlayerCuffs, True)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Alias_PC  Auto  

ReferenceAlias Property Alias_Dom  Auto  

Topic Property LikeItTopic  Auto  

Armor Property PlayerCuffs  Auto  
