Scriptname APPS_LockDoor extends ObjectReference  

Event OnClose(ObjectReference akActivator)
	If(akActivator.GetItemCount(Self.GetKey()) > 0)
		Self.Lock()
	EndIf
EndEvent