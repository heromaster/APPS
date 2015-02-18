;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_FollowerQuest_TIF_StartWhipping4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Domina As APPS_Domina_Functions).IsConsensual = True
WhipScene.SendStoryEvent(None, PlayerRef, akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property PlayerRef Auto
Keyword Property WhipScene Auto
Quest Property Domina Auto
