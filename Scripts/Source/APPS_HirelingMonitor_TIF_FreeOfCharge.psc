;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_HirelingMonitor_TIF_FreeOfCharge Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
kmyQuest.RegisterForSingleUpdateGameTime(kmyQuest.PaymentInterval)
kmyQuest.IsPaymentTime = False
kmyQuest.RememberedForPayment = 0
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_HirelingMonitor_Functions Property kmyQuest Auto
