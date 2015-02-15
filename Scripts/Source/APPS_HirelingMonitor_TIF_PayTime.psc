;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_HirelingMonitor_TIF_PayTime Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
HirelingMonitor.RememberedForPayment += 1

If(HirelingMonitor.RememberedForPayment >= 3)
	ActorUtil.AddPackageOverride(Alias_Hireling.GetActorRef(), PaymentTimePackage)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_HirelingMonitor_Functions Property HirelingMonitor Auto
Package Property PaymentTimePackage Auto
ReferenceAlias Property Alias_Hireling Auto

