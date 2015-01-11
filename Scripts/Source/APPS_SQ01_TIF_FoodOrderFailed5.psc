;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_SQ01_TIF_FoodOrderFailed5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If(RS.GetRelationshipPoints(akSpeaker) > -150)
	RS.ModRelationshipPoints(akSpeaker, -5)
EndIf

If(RS.GetRelationshipPoints(Alias_Patron.GetActorRef()) > -150)
	RS.ModRelationshipPoints(Alias_Patron.GetActorRef(), -10)
EndIf

GetOwningQuest().SetStage(40)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_FW_Relationship Property RS Auto

ReferenceAlias Property Alias_Patron Auto
