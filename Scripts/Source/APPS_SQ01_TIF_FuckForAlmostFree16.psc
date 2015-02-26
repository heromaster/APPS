;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_SQ01_TIF_FuckForAlmostFree16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If(akSpeaker.IsInFaction(DragonbornIdentifiedFaction))
	RS.ModRelationshipPoints(akSpeaker, 10)
Else
	RS.ModRelationshipPoints(akSpeaker, 5)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_FW_Relationship Property RS Auto

Faction Property DragonbornIdentifiedFaction Auto
