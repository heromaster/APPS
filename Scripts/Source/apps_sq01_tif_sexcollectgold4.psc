;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_SQ01_TIF_SexCollectGold4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
FavorJobsBeggarsAbility.Cast(Alias_PC.GetActorRef(), Alias_PC.GetActorRef())
FavorJobsBeggarsMessage.Show()
Controller.MakeFriends(akSpeaker, Alias_PC.GetActorRef())
GetOwningQuest().SetStage(80)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Controller_SharedFunctions Property Controller Auto
SPELL Property FavorJobsBeggarsAbility  Auto  
Message Property FavorJobsBeggarsMessage  Auto  
ReferenceAlias Property Alias_PC  Auto  
