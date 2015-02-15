Scriptname APPS_Evaenne_LevelUp_Functions extends Quest Conditional
APPS_Follower_Functions Property FollowerFunctions Auto
Actor Property EvaenneRef Auto
Book Property SpellTomeCloseWounds Auto
Book Property SpellTomeFastHealing Auto
Book Property SpellTomeGrandHealing Auto
Book Property SpellTomeHealingHands Auto
Book Property SpellTomeHealOther Auto
Spell Property CloseWounds Auto
Spell Property FastHealing Auto
Spell Property GrandHealing Auto
Spell Property HealingHands Auto
Spell Property HealOther Auto
Spell Property PerkAbQuickShot Auto
Spell Property PerkMagickaRecovery1 Auto
Spell Property PerkMagickaRecovery2 Auto
Spell Property PerkMuffledMovement Auto
Spell Property PerkPowerShot Auto
Spell Property PerkSilence Auto
Spell Property PerkWindWalkerStamina Auto

Event OnInit()
	If(Game.GetModByName("no-helmet armor perk fix.esp") < 255)
		FollowerFunctions.IsArmorPerkFixInstalled = True
	Else
		FollowerFunctions.IsArmorPerkFixInstalled = False
	EndIf

	Int CurrentLevel = EvaenneRef.GetLevel()

	If(CurrentLevel >= 4)
		If(!EvaenneRef.HasSpell(FastHealing) && EvaenneRef.GetBaseActorValue("Restoration") >= 25 && EvaenneRef.GetItemCount(SpellTomeFastHealing) > 0)
			EvaenneRef.AddSpell(FastHealing)
			EvaenneRef.RemoveItem(SpellTomeFastHealing, 1)
		EndIf

		If(!EvaenneRef.HasSpell(HealingHands) && EvaenneRef.GetBaseActorValue("Restoration") >= 25 && EvaenneRef.GetItemCount(SpellTomeHealingHands) > 0)
			EvaenneRef.AddSpell(HealingHands)
			EvaenneRef.RemoveItem(SpellTomeHealingHands, 1)
		EndIf
	EndIf

	If(CurrentLevel >= 7)
		If(!EvaenneRef.HasSpell(PerkMagickaRecovery1) && EvaenneRef.GetBaseActorValue("Restoration") >= 30)
			PerkMagickaRecovery1.Cast(EvaenneRef)
		EndIf
	EndIf
				
	If(CurrentLevel >= 19)
		If(!EvaenneRef.HasSpell(CloseWounds) && EvaenneRef.GetBaseActorValue("Restoration") >= 50 && EvaenneRef.GetItemCount(SpellTomeCloseWounds) > 0)
			EvaenneRef.AddSpell(CloseWounds)
			EvaenneRef.RemoveItem(SpellTomeCloseWounds, 1)
		EndIf

		If(!EvaenneRef.HasSpell(HealOther) && EvaenneRef.GetBaseActorValue("Restoration") >= 50 && EvaenneRef.GetItemCount(SpellTomeHealOther) > 0)
			EvaenneRef.AddSpell(HealOther)
			EvaenneRef.RemoveItem(SpellTomeHealOther, 1)
		EndIf
	EndIf

	If(CurrentLevel >= 22)
		If(!EvaenneRef.HasSpell(PerkPowerShot) && EvaenneRef.GetBaseActorValue("Marksman") >= 50)
			PerkPowerShot.Cast(EvaenneRef)
		EndIf
	EndIf

	If(CurrentLevel >= 23)
		If(!EvaenneRef.HasSpell(PerkMuffledMovement) && EvaenneRef.GetBaseActorValue("Sneak") >= 30)
			PerkMuffledMovement.Cast(EvaenneRef)
		EndIf
	EndIf

	If(CurrentLevel >= 26)
		If(!EvaenneRef.HasSpell(PerkMagickaRecovery2) && EvaenneRef.GetBaseActorValue("Restoration") >= 60)
			PerkMagickaRecovery2.Cast(EvaenneRef)
		EndIf
	EndIf

	If(CurrentLevel >= 33)
		If(!EvaenneRef.HasSpell(GrandHealing)  && EvaenneRef.GetBaseActorValue("Restoration") >= 75 && EvaenneRef.GetItemCount(SpellTomeGrandHealing) > 0)
			EvaenneRef.AddSpell(GrandHealing)
			EvaenneRef.RemoveItem(SpellTomeGrandHealing, 1)
		EndIf
	EndIf
	
	If(CurrentLevel >= 34)
		If(!EvaenneRef.HasSpell(PerkAbQuickShot) && EvaenneRef.GetBaseActorValue("Marksman") >= 70)
			PerkAbQuickShot.Cast(EvaenneRef)
		EndIf
	EndIf

	If(CurrentLevel >= 36)
		If(!EvaenneRef.HasSpell(PerkWindWalkerStamina) && EvaenneRef.GetBaseActorValue("LightArmor") >= 60)
			PerkWindWalkerStamina.Cast(EvaenneRef)
		EndIf
	EndIf

	If(CurrentLevel >= 68)
		If(!EvaenneRef.HasSpell(PerkSilence) && EvaenneRef.GetBaseActorValue("Sneak") >= 70)
			PerkSilence.Cast(EvaenneRef)
		EndIf
	EndIf

	Stop()
EndEvent