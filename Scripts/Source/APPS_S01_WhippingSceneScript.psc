;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 34
Scriptname APPS_S01_WhippingSceneScript Extends Scene Hidden

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
Stripped = SexLab.StripActor(Alias_Sub.GetActorRef())
Utility.Wait(1.5)
Debug.SendAnimationEvent(Alias_Sub.GetActorRef(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
If(Alias_Sub.GetActorRef().GetAVPercentage("Health") <= 0.25)
	kmyQuest.IsOutroScene = True

EndIf

Debug.SendAnimationEvent(Alias_Sub.GetActorRef(), "IdleForceDefaultState")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
If(kmyQuest.IsEquipCuffs)
	Alias_Sub.GetActorRef().EquipItem(Cuffs)
ElseIf(kmyQuest.IsEquipGag)
	Alias_Sub.GetActorRef().EquipItem(Cuffs)
	Alias_Sub.GetActorRef().EquipItem(Gag)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Game.SetPlayerAIDriven(False)
Game.EnablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
;Alias_SubSceneMarker.GetRef().MoveTo(Alias_Dom.GetRef(), 75 * Math.Sin(Alias_Dom.GetRef().GetAngleZ()), 75 * Math.Cos(Alias_Dom.GetRef().GetAngleZ()), Alias_Dom.GetRef().GetHeight())
Alias_SubSceneMarker.GetRef().SetAngle(0, 0, Alias_Dom.GetRef().GetAngleZ())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
If(Alias_Sub.GetActorRef() == Alias_PC.GetActorRef())
	kmyQuest.IsPlayerSub = True
Else
	kmyQuest.IsPlayerSub = False
EndIf

Game.DisablePlayerControls()
Game.SetPlayerAIDriven()
kmyQuest.WhippingLoops = Domina.WhippingCounter
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
If(!kmyQuest.IsEquipCuffs)
	SexLab.UnstripActor(Alias_Sub.GetActorRef(), Stripped)
Else
	If(!kmyQuest.IsEquipGag)
		Alias_Sub.GetActorRef().EquipItem(Cuffs)
	Else
		Alias_Sub.GetActorRef().EquipItem(Cuffs)
		Alias_Sub.GetActorRef().EquipItem(Gag)
	EndIf
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Domina_Functions Property Domina Auto
APPS_S01_Functions Property kmyQuest Auto
SexLabFramework Property SexLab Auto
Armor Property Cuffs  Auto  
Armor Property Gag  Auto  
Form[] Property Stripped  Auto
ReferenceAlias Property Alias_Sub  Auto  
ReferenceAlias Property Alias_Dom  Auto  
ReferenceAlias Property Alias_PC  Auto  
ReferenceAlias Property Alias_SubSceneMarker  Auto  
ReferenceAlias Property Alias_DomSceneMarker  Auto  
