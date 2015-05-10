;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname APPS_SQ01_SS_PlayerDancing Extends Scene Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
If(!(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).HasPlayerStoppedDancing)
	Controller.DanceRewardMulti = 1.0
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
If(!(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).HasPlayerStoppedDancing)
	Controller.DanceRewardMulti = 1.30
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
If(!(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).HasPlayerStoppedDancing)
	Controller.DanceRewardMulti = 1.10
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
Game.SetPlayerAIDriven(False)
Game.EnablePlayerControls()
SQ01.SetStage(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).StopMyself()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
If(!(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).HasPlayerStoppedDancing)
	Controller.DanceRewardMulti = 0.75
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
If(!(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).HasPlayerStoppedDancing)
	Controller.DanceRewardMulti = 1.20
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
If(!(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).HasPlayerStoppedDancing)
	Controller.DanceRewardMulti = 1.50
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SQ01 Auto

APPS_Controller_Functions Property Controller Auto
