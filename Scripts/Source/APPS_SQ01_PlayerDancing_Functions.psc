Scriptname APPS_SQ01_PlayerDancing_Functions Extends Quest Conditional
Import StorageUtil

Bool Property HasPlayerStoppedDancing Auto Hidden Conditional
Int Property PlayerSelectedDance Auto Hidden Conditional

Int Property DanceScene Auto Hidden

Quest Property BardSongs Auto
Quest Property DynamicInteractions Auto
Quest Property SQ01 Auto
Scene Property PlayerNormalDancingScene Auto

Event OnInit()
	If(Self.IsRunning())
		RegisterForModEvent("APPS_Dance", "OnDancing")
	EndIf
EndEvent

Event OnDancing(Form akSender, Int auiSelectedDance)
	PlayerSelectedDance = auiSelectedDance
	Game.DisablePlayerControls()
	Game.SetPlayerAIDriven()

	(BardSongs As BardSongsScript).StopAllSongs()
	(DynamicInteractions As APPS_DI_Functions).SetWheelMenuActive(False)
	RegisterForModEvent("APPS_WheelMenuNotActive", "OnInactiveMenu")
	PlayerNormalDancingScene.Start()
EndEvent

Event OnInactiveMenu(Form akSender)
	UnregisterForModEvent("APPS_WheelMenuNotActive")
	HasPlayerStoppedDancing = True
EndEvent