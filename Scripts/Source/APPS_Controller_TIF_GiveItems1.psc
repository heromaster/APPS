;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_Controller_TIF_GiveItems1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Alias_TavernJobOutfit.GetRef().SetPosition(Alias_CorrectBarCounter.GetRef().GetPositionX(), Alias_CorrectBarCounter.GetRef().GetPositionY(), Alias_CorrectBarCounter.GetRef().GetPositionZ() + Alias_CorrectBarCounter.GetRef().GetHeight() + 10)
Utility.Wait(0.25)
Alias_TavernJobBoots.GetRef().SetPosition(Alias_TavernJobOutfit.GetRef().GetPositionX(), Alias_TavernJobOutfit.GetRef().GetPositionY(), Alias_TavernJobOutfit.GetRef().GetPositionZ() + 10)
Alias_TavernJobOutfit.GetRef().SetActorOwner(PlayerRef.GetActorBase())
Alias_TavernJobBoots.GetRef().SetActorOwner(PlayerRef.GetActorBase())

;PlayerRef.AddItem(Alias_TavernJobOutfit.GetRef())
;PlayerRef.AddItem(Alias_TavernJobBoots.GetRef())
;PlayerRef.AddItem(Alias_TavernJobBroom.GetRef())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property PlayerRef Auto
ReferenceAlias Property Alias_Innkeeper Auto
ReferenceAlias Property Alias_CorrectBarCounter Auto
ReferenceAlias Property Alias_CorrectLeaningMarker Auto
ReferenceAlias Property Alias_TavernJobBoots Auto
ReferenceAlias Property Alias_TavernJobBroom Auto
ReferenceAlias Property Alias_TavernJobOutfit Auto


