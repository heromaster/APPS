Scriptname APPS_ObserveSeat extends ReferenceAlias  
Actor Property PlayerRef Auto
Keyword Property IsTable Auto
Quest Property FFQ001 Auto
ReferenceAlias Property Alias_Dom Auto
APPS_Libs_Functions Property Libs Auto

Event OnSit(ObjectReference akTarget)
	If(FFQ001.GetStage() > 30)
		Return
	EndIf

	If(akTarget == Alias_Dom.GetRef())
		FFQ001.SetStage(40)
	Else
		Libs.AddFreeSeats(Self.GetRef().GetLinkedRef(IsTable), False)
	EndIf
EndEvent

Event OnGetUp(ObjectReference akTarget)
	If(FFQ001.GetStage() >= 50)
		If(akTarget == PlayerRef)
			;make mistress get up
			FFQ001.SetStage(100)
		EndIf
	Else
		Libs.AddFreeSeats(Self.GetRef().GetLinkedRef(IsTable))
	EndIf
EndEvent