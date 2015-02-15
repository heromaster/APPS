Scriptname APPS_TrespassRoomDH extends ObjectReference  
Cell Property DrunkenHuntsmanBasement Auto
Actor Property PlayerRef Auto
Faction Property RoomFaction Auto
ObjectReference Property RoomBed Auto
ObjectReference Property RoomDoor Auto
Package Property CloseDoorPackage Auto
Actor RoomOwner 

Event OnTriggerEnter(ObjectReference akActivator)
	RoomOwner = StorageUtil.GetFormValue(RoomBed, "APPS.Follower.DrunkenHuntsman.RoomGuest") As Actor

	;If the player enters this room and does not have rented this room
	If(akActivator == PlayerRef && !PlayerRef.IsInFaction(RoomFaction))
		;Check if the room is currently rented by a NPC
		If(StorageUtil.HasFormValue(RoomBed, "APPS.Follower.DrunkenHuntsman.RoomGuest"))
			;Player is not allowed to enter the room if the owner wants privacy or the relationship is not at least friendly
			If(StorageUtil.HasIntValue(Self, "APPS.Follower.DrunkenHuntsman.IsRoomInPrivacyMode") || RoomOwner.GetRelationshipRank(PlayerRef) < 1)
				;Sets the cell to private so the engine will trigger events to notify the player that it is time to leave the room
				DrunkenHuntsmanBasement.SetPublic(False)
			EndIf
		;If the player is not the room owner and no one else rented this room, then also set the cell to private
		Else
			DrunkenHuntsmanBasement.SetPublic(False)
		EndIf
	EndIf
EndEvent

Event OnTriggerLeave(ObjectReference akActivator)
	;If the player leaves the room, set this cell to public again
	If(!(akActivator As Actor).IsInFaction(RoomFaction))
		Utility.Wait(1.5)

		If(RoomDoor.GetOpenState() < 3)
			ActorUtil.AddPackageOverride(RoomOwner, CloseDoorPackage, 100)
			RoomOwner.EvaluatePackage()
			;If(akActivator == PlayerRef)
				DrunkenHuntsmanBasement.SetPublic()
			;EndIf
		EndIf
	EndIf
EndEvent