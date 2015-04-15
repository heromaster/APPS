;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_SQ01_BreakTime_SceneScript Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Alias_InnkeeperReplacement.ForceRefTo(Alias_Olfina.GetActorRef())
GetOwningQuest().SetStage(170)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
Alias_InnkeeperReplacement.ForceRefTo(Alias_Ysolda.GetActorRef())
GetOwningQuest().SetStage(170)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Alias_InnkeeperReplacement Auto
ReferenceAlias Property Alias_Olfina Auto
ReferenceAlias Property Alias_Ysolda Auto
