;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_Hireling_TIF_HireHireling Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
kmyQuest.PayHireling(akSpeaker, HirelingGoldGV.Value As Int)
FFQ001.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Hireling_Functions Property kmyQuest Auto
GlobalVariable Property HirelingGoldGV Auto

Quest Property FFQ001  Auto  
