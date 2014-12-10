;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_SQ01_LeftInn_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Tavern
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Tavern Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
LeftInnMessage.Show()
RegisterForSingleUpdate(3)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Import StorageUtil

Actor Property PlayerRef Auto
Message Property LeftInnMessage Auto
Quest Property SQ01 Auto

Event OnUpdate()
	Int Bounty = (GetIntValue(None, "APPS.SQ01.InnkeeperShare") + GetIntValue(None, "APPS.SQ01.Bill")) * 2

	If(PlayerRef.GetCurrentLocation() != Alias_Tavern.GetLocation())
		If(Bounty > 0)
			Alias_Innkeeper.GetActorRef().GetCrimeFaction().ModCrimeGold(Bounty)
		EndIf

		SQ01.SetStage(250)
	EndIf
	
	Stop()
EndEvent
