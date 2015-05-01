Scriptname APPS_SQ01_PlayerDancing_Functions Extends Quest Conditional
Import StorageUtil

Bool Property HasPlayerStoppedDancing Auto Hidden Conditional
Float Property DanceRewardMulti Auto Hidden Conditional
Int Property PlayerSelectedDance Auto Hidden Conditional

Scene Property PlayerNormalDancingScene Auto

Event OnInit()
	RegisterForModEvent("APPS_Dance", "OnDancing")
EndEvent

Event OnDancing(Form akSender, Int auiSelectedDance)
	PlayerSelectedDance = auiSelectedDance
	PlayerNormalDancingScene.Start()
EndEvent