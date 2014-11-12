;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname APPS_Controller_SS_TavernJob Extends Scene Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
Game.SetInChargen(False, False, False)
Game.EnablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
game.disablePlayerControls()
Game.SetInChargen(False, True, False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Alias_ChestIdleMarker.GetRef().SetPosition(596,-513,67)
Alias_ChestIdleMarker.GetRef().SetAngle(0,0,180)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Controller_SharedFunctions Property Controller Auto
ReferenceAlias Property Alias_ChestIdleMarker Auto