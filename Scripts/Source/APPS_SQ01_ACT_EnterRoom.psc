Scriptname APPS_SQ01_ACT_EnterRoom extends ObjectReference  

Actor Property PlayerRef Auto
Quest Property SQ01 Auto

Event OnTriggerEnter(ObjectReference akActivator)
	If(akActivator == PlayerRef && SQ01.GetStage() == 50)
		SQ01.SetStage(60)
	EndIf
EndEvent