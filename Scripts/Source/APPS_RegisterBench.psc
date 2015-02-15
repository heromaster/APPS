Scriptname APPS_RegisterBench Extends ReferenceAlias
Quest Property FFQ001 Auto
ReferenceAlias Property Alias_Dom Auto
APPS_Libs_Functions Property Libs Auto

Event OnInit()
	If(GetOwningQuest().IsStopped())
		Return
	EndIf

	StorageUtil.UnsetIntValue(Self.GetRef(), "APPS.Follower.FFQ001.FreeSeats")
	Libs.AddFreeSeats(Self.GetRef(), True, True)
EndEvent

Event OnSit(ObjectReference akTarget)
	If(FFQ001.GetStage() > 30)
		Return
	EndIf

	If(akTarget == Alias_Dom.GetRef())
		FFQ001.SetStage(40)
	Else
		Libs.AddFreeSeats(Self.GetRef(), False)
	EndIf
EndEvent

Event OnGetUp(ObjectReference akTarget)
	Libs.AddFreeSeats(Self.GetRef())
EndEvent