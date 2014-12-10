;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname APPS_Controller_SS_TavernJob Extends Scene Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
Game.SetInChargen(False, False, False)
Game.EnablePlayerControls()
Alias_ChestIdleMarker.GetRef().Disable()
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

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
game.disablePlayerControls()
Game.SetInChargen(False, True, False)

If(PlayerRef.GetDistance(Alias_BarLeaningMarker1.GetRef()) < PlayerRef.GetDistance(Alias_BarLeaningMarker1.GetRef()))
	Alias_CorrectLeaningMarker.ForceRefTo(Alias_BarLeaningMarker1.GetRef())
Else
	Alias_CorrectLeaningMarker.ForceRefTo(Alias_BarLeaningMarker2.GetRef())
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property PlayerRef Auto
ReferenceAlias Property Alias_BarLeaningMarker1 Auto
ReferenceAlias Property Alias_BarLeaningMarker2 Auto
ReferenceAlias Property Alias_ChestIdleMarker Auto
ReferenceAlias Property Alias_CorrectLeaningMarker Auto
