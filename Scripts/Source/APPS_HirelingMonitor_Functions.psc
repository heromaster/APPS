Scriptname APPS_HirelingMonitor_Functions Extends Quest  Conditional
Bool Property IsPaymentTime Auto Conditional Hidden
Int Property RememberedForPayment Auto Conditional Hidden
Int Property PaymentInterval Auto Hidden
Faction Property CurrentHireling Auto
Package Property GetPaymentPackage Auto
ReferenceAlias Property Alias_Hireling Auto

Event OnUpdateGameTime()
	Actor Hireling = Alias_Hireling.GetActorRef()

	If(Hireling.IsInFaction(CurrentHireling))
		IsPaymentTime = True
	Else
		Stop()
	EndIf
EndEvent

Function SetPaymentInterval(Int aiInterval = 7)
	If(aiInterval > 0)
		PaymentInterval = aiInterval * 24
	EndIf
EndFunction