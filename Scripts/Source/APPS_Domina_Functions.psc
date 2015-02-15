Scriptname APPS_Domina_Functions extends Quest Conditional
Bool Property HasAskedForDiner = False Auto Conditional Hidden
Bool Property HasSaidOwnerOnce = False Auto Conditional Hidden
Bool Property HasBrokenRulesOnce = False Auto Conditional Hidden
Bool Property IsConsensual = True Auto Conditional Hidden
Bool Property IsReceivedDancingWarning = False Auto Conditional Hidden
Bool Property IsPlayerDanced = False Auto Conditional Hidden
Bool Property IsPunishmentDelayed = False Auto Conditional Hidden
Int Property WhippingCounter = 1 Auto Conditional Hidden
ReferenceAlias Property CurrentDomina Auto

Function SwitchCurrentDomina(Actor akDomina)
	If(akDomina)
		If(CurrentDomina)
			Actor CurrentDom = CurrentDomina.GetActorRef()
			StorageUtil.SetIntValue(CurrentDom, "APPS.Follower.HasAskedForDiner", HasAskedForDiner As Int)
			StorageUtil.SetIntValue(CurrentDom, "APPS.Follower.HasSaidOwnerOnce", HasSaidOwnerOnce As Int)
			StorageUtil.SetIntValue(CurrentDom, "APPS.Follower.HasBrokenRulesOnce", HasBrokenRulesOnce As Int)
			StorageUtil.SetIntValue(CurrentDom, "APPS.Follower.IsConsensual", IsConsensual As Int)
			StorageUtil.SetIntValue(CurrentDom, "APPS.Follower.IsPlayerDanced ", IsPlayerDanced As Int)
			StorageUtil.SetIntValue(CurrentDom, "APPS.Follower.IsPunishmentDelayed ", IsPunishmentDelayed As Int)
			StorageUtil.SetIntValue(CurrentDom, "APPS.Follower.IsReceivedDancingWarning ", IsReceivedDancingWarning As Int)
			StorageUtil.SetIntValue(CurrentDom, "APPS.Follower.WhippingCounter ", WhippingCounter)
		EndIf

		CurrentDomina.ForceRefTo(akDomina)

		HasAskedForDiner = StorageUtil.GetIntValue(akDomina, "APPS.Follower.HasAskedForDiner")
		HasSaidOwnerOnce = StorageUtil.GetIntValue(akDomina, "APPS.Follower.HasSaidOwnerOnce")
		HasBrokenRulesOnce = StorageUtil.GetIntValue(akDomina, "APPS.Follower.HasBrokenRulesOnce")
		IsConsensual = StorageUtil.GetIntValue(akDomina, "APPS.Follower.IsConsensual")
		IsPlayerDanced = StorageUtil.GetIntValue(akDomina, "APPS.Follower.IsPlayerDanced")
		IsPunishmentDelayed = StorageUtil.GetIntValue(akDomina, "APPS.Follower.IsPunishmentDelayed")
		IsReceivedDancingWarning = StorageUtil.GetIntValue(akDomina, "APPS.Follower.IsReceivedDancingWarning")
		WhippingCounter = StorageUtil.GetIntValue(akDomina, "APPS.Follower.WhippingCounter", 1)
	EndIf
EndFunction