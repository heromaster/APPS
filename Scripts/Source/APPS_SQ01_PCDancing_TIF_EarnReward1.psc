;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_SQ01_PCDancing_TIF_EarnReward1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Controller.EarnReward(akSpeaker, 3)
(SQ01 As APPS_SQ01_Functions).AddSatisfiedClient(akSpeaker, 3)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property SQ01 Auto

APPS_Controller_Functions Property Controller Auto
