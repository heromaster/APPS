;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_SQ01_TIF_FuckForAlmostFree10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Controller As APPS_Controller_Functions).ModFreeFuckMulti(0.1)

If(akSpeaker.IsInFaction(DragonbornIdentifiedFaction))
	RS.ModRelationshipPoints(akSpeaker, 15)
Else
	RS.ModRelationshipPoints(akSpeaker, 10)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_FW_Relationship Property RS Auto

Faction Property DragonbornIdentifiedFaction Auto
Quest Property Controller Auto
