;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_SQ01_TIF_SexOrderDeclined16 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Controller As APPS_Controller_Functions).AddToStats(2, False)
(Controller As APPS_Controller_Functions).ExcludeFromSatisfactionStat()
SatisfiedByPoliteDeclineSpell.Cast(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property Controller Auto
Spell Property SatisfiedByPoliteDeclineSpell Auto