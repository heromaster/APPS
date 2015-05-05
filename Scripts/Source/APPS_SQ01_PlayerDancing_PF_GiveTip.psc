;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_SQ01_PlayerDancing_PF_GiveTip Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
Float GoldAmount = Utility.RandomInt(StorageUtil.GetIntValue(None, "APPS.Settings.MinDanceReward"), StorageUtil.GetIntValue(None, "APPS.Settings.MaxDanceReward")) * Controller.DanceRewardMulti * 0.75

HuldaRef.AddItem(Septims, Math.Ceiling(GoldAmount))
akActor.RemoveItem(Septims, Math.Ceiling(GoldAmount))
StorageUtil.AdjustIntValue(None, "APPS.SQ01.CollectedTips", Math.Ceiling(GoldAmount))

If(akActor.HasMagicEffect(DissatisfiedEffect))
	akActor.DispelSpell(DissatisfiedByDanceOrderSpell)
	akActor.DispelSpell(DissatisfiedByFoodOrderSpell)
	akActor.DispelSpell(DissatisfiedBySexOderSpeller)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property HuldaRef Auto
MagicEffect Property DissatisfiedEffect Auto
MiscObject Property Septims Auto
Spell Property DissatisfiedByDanceOrderSpell Auto
Spell Property DissatisfiedByFoodOrderSpell Auto
Spell Property DissatisfiedBySexOderSpeller Auto
APPS_Controller_Functions Property Controller Auto