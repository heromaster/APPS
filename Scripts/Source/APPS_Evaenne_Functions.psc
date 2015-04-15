Scriptname APPS_Evaenne_Functions extends Quest  Conditional
Import StorageUtil
Bool Property CanDualCasting Auto Conditional Hidden
Bool Property HasBeenHired Auto Conditional Hidden
Float Property DaysPassedSinceLastContract Auto Conditional Hidden
String Property LAST_STORED_OUTFIT = "APPS.NPC.LastStoredOutfit" AutoReadOnly Hidden

Actor Property EvaenneRef Auto
Function ChooseBestOutfit()
	Int Level = EvaenneRef.GetLevel()

	If(Level < 6)
		FormListSlice(EvaenneRef, OUTFIT_LVL_01, ArmorList)
	ElseIf(Level < 12)
		FormListSlice(EvaenneRef, OUTFIT_LVL_06, ArmorList)
	ElseIf(Level < 19)
		FormListSlice(EvaenneRef, OUTFIT_LVL_12, ArmorList)
	ElseIf(Level < 27)
		FormListSlice(EvaenneRef, OUTFIT_LVL_19, ArmorList)
	ElseIf(Level < 36)
		FormListSlice(EvaenneRef, OUTFIT_LVL_27, ArmorList)
	ElseIf(Level < 46)
		FormListSlice(EvaenneRef, OUTFIT_LVL_36, ArmorList)
	Else
		FormListSlice(EvaenneRef, OUTFIT_LVL_46, ArmorList)
	EndIf

	If(FormListCount(EvaenneRef, "APPS.NPC.LastStoredOutfit") == 0)
		If(Level < 3)
			EvaenneRef.AddItem(IronArrow, 100)
		ElseIf(Level < 6)
			EvaenneRef.EquipItem(EvaenneBowLvl01)
			EvaenneRef.AddItem(SteelArrow, 100)
		ElseIf(Level < 12)
			If(IsWAFInstalled)
				EvaenneRef.EquipItem(EvaenneBowLvl06_WAF)
			Else
				EvaenneRef.EquipItem(EvaenneBowLvl06)
			EndIf

			EvaenneRef.AddItem(OrcishArrow, 100)
		ElseIf(Level < 19)
			If(IsWAFInstalled)
				EvaenneRef.EquipItem(EvaenneBowLvl12_WAF)
			Else
				EvaenneRef.EquipItem(EvaenneBowLvl12)
			EndIf

			EvaenneRef.AddItem(DwarvenArrow, 100)
		ElseIf(Level < 27)
			If(IsWAFInstalled)
				EvaenneRef.EquipItem(EvaenneBowLvl19_WAF)
			Else
				EvaenneRef.EquipItem(EvaenneBowLvl19)
			EndIf

			EvaenneRef.AddItem(ElvenArrow, 100)
		ElseIf(Level < 36)
			If(IsWAFInstalled)
				EvaenneRef.EquipItem(EvaenneBowLvl27_WAF)
			Else
				EvaenneRef.EquipItem(EvaenneBowLvl27)
			EndIf

			EvaenneRef.AddItem(GlassArrow, 100)
		ElseIf(Level < 46)
			EvaenneRef.EquipItem(EvaenneBowLvl36)
			EvaenneRef.AddItem(EbonyArrow, 100)
		Else
			If(IsWAFInstalled)
				EvaenneRef.EquipItem(EvaenneBowLvl46_WAF)
			Else
				EvaenneRef.EquipItem(EvaenneBowLvl46)
			EndIf

			EvaenneRef.AddItem(DaedricArrow, 100)
		EndIf
		
Function EquipOutfit(Int auiLevel)
	