;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_FFQ002_TIF_EndRelationship Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor Dom = Alias_Dom.GetActorRef()
FollowerFunctions.FactionProgress(-Dom.GetFactionRank(SubDomFaction))
GetOwningQuest().SetStage(100)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Follower_Functions Property FollowerFunctions Auto
Faction Property SubDomFaction  Auto  

ReferenceAlias Property Alias_Dom  Auto  
