Scriptname APPS_RegisterSeatGroup Extends ReferenceAlias
APPS_Libs_Functions Property Libs Auto

Event OnInit()
	If(GetOwningQuest().IsStopped())
		Return
	EndIf

	StorageUtil.UnsetIntValue(Self.GetRef(), "APPS.Follower.FFQ001.FreeSeats")
	Libs.AddFreeSeats(Self.GetRef(), True, True)
EndEvent