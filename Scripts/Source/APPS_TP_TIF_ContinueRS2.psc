;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_TP_TIF_ContinueRS2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor Dom = Alias_Dom.GetActorRef()
Int NewRank = Dom.GetFactionRank(SubDomFaction) - 1

If(NewRank > 0)
	NewRank -= NewRank
	FollowerFunctions.FactionProgress(R1Pts = NewRank, abIsInheritFirstValue = True)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Follower_Functions Property FollowerFunctions Auto
ReferenceAlias Property Alias_Dom  Auto  

Faction Property SubDomFaction  Auto  
