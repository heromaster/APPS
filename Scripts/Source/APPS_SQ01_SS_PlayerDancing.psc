;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname APPS_SQ01_SS_PlayerDancing Extends Scene Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).DanceRewardMulti = 1.50
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).DanceRewardMulti = 0.75
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).DanceRewardMulti = 1.30
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).DanceRewardMulti = 1.10
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).DanceRewardMulti = 1.20
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Game.DisablePlayerControls()
Game.SetPlayerAIDriven()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
(GetOwningQuest() As APPS_SQ01_PlayerDancing_Functions).DanceRewardMulti = 1.0
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Float DanceRewardMulti
