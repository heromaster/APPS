Scriptname APPS_MGE_CustomerReadyAgain Extends ActiveMagicEffect
Message Property CustomerIsReadyAgainMessage Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
			CustomerIsReadyAgainMessage.Show()
EndEvent
