;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_Controller_TIF_StartTavernJob2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
PlayerRef.AddItem(Alias_TavernJobOutfit.GetRef())
PlayerRef.AddItem(Alias_TavernJobBoots.GetRef())
PlayerRef.AddItem(Alias_TavernJobBroom.GetRef())
SQ01.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property PlayerRef Auto
Quest Property SQ01 Auto
ReferenceAlias Property Alias_TavernJobBoots Auto
ReferenceAlias Property Alias_TavernJobBroom Auto
ReferenceAlias Property Alias_TavernJobOutfit Auto
