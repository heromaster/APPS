Scriptname APPS_TortureRoomExitDoorScript extends ObjectReference  
ObjectReference Property PlayerRef Auto
ObjectReference Property XMarkerMainRoom  Auto  

Event OnActivate(ObjectReference akActionRef)
	If(akActionRef == PlayerRef)
		Utility.Wait(1)
		XMarkerMainRoom.Disable()
	EndIf
EndEvent
