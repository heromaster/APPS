;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname APPS_Init Extends APPS_ModRegFW_Functions Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
	RegisterMod()
	RegisterInitQuest(Self, 10)
	RegisterForExceptionModule("APPS")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
	If(!SexLab.Stats.HadSex(Brenuin))
		Int Anal = Utility.RandomInt(20, 45)
		Int Oral = Utility.RandomInt(60, 100)
		SexLab.Stats.SetInt(Brenuin, "Anal", Anal)
		SexLab.Stats.SetInt(Brenuin, "Vaginal", 0)
		SexLab.Stats.SetInt(Brenuin, "Oral", Oral)
		SexLab.Stats.SetInt(Brenuin, "Males", Anal + Oral)
	EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property Brenuin Auto
SexLabFramework Property SexLab Auto