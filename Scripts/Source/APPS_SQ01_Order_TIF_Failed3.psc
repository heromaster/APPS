;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_SQ01_Order_TIF_Failed3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().Reset()
GetOwningQuest().Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
kmyQuest.DeductWages()
kmyQuest.AddToStatistics(1, False)
RS.ModRelationshipPoints(Alias_TavernGuest.GetActorRef(), -10)
RS.ModRelationshipPoints(akSpeaker, -5)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Alias_TavernGuest Auto
APPS_SQ01_Order_Functions Property kmyQuest Auto
APPS_FW_Relationship Property RS Auto
