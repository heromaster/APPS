Scriptname APPS_MGE_CustomerReadyAgain extends activemagiceffect  
Message Property CustomerIsReadyAgainMessage Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
			CustomerIsReadyAgainMessage.Show()
EndEvent