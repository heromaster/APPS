;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_FFQ01_TIF_PunishmentFirstTask1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
APPS_FFQ02.Start()
APPS_FFQ02_Funcs.PunishmentLeadIn = 1
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_FFQ02_Functions Property APPS_FFQ02_Funcs Auto
Quest Property APPS_FFQ02  Auto  
