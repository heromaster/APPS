;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_HirelingMonitor_TIF_PayHireling Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
HirelingFunctions.PayHireling(akSpeaker, HirelingGoldGV.Value As Int)
kmyQuest.RegisterForSingleUpdateGameTime(kmyQuest.PaymentInterval)
kmyQuest.IsPaymentTime = False
kmyQuest.RememberedForPayment = 0
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Hireling_Functions Property HirelingFunctions Auto
APPS_HirelingMonitor_Functions Property kmyQuest Auto
GlobalVariable Property HirelingGoldGV  Auto  
