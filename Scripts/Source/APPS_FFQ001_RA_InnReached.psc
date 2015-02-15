Scriptname APPS_FFQ001_RA_InnReached extends ReferenceAlias  
LocationAlias Property Alias_Inn  Auto

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	If(akNewLoc == Alias_Inn.GetLocation() && GetOwningQuest().GetStage() >= 10 && GetOwningQuest().GetStage() <= 15)
		(StorageUtil.GetFormValue(Alias_Inn.GetLocation(), "APPS.Follower.FFQ001Helper") As Quest).Start()
		GetOwningQuest().SetStage(GetOwningQuest().GetStage() + 10)
	EndIf
EndEvent 
