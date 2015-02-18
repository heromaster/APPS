;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_SQ01_TIF_DancingDeclined2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
kmyQuest.AddDissatisfiedClient(akSpeaker, 3)

If(Controller.TavernJobStorylineProgress == 0)
	Controller.ExcludeFromSatisfactionStat()
Else
	If(RS.GetRelationshipPoints(akSpeaker) > -150)
		RS.ModRelationshipPoints(akSpeaker, -5)
	EndIf
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Controller_Functions Property Controller Auto
APPS_FW_Relationship Property RS Auto
APPS_SQ01_Functions Property kmyQuest Auto
