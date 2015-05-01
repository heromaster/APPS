;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 16
Scriptname APPS_SQ01_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Saadia
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Saadia Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Tavern
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Tavern Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Patron
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Patron Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY HoldingCell
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_HoldingCell Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Bed
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Bed Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerDanceAudienceMarker3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerDanceAudienceMarker3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Olfina
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Olfina Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Ysolda
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Ysolda Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerDanceAudienceMarker2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerDanceAudienceMarker2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerDanceAudienceMarker4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerDanceAudienceMarker4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Innkeeper
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Innkeeper Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerDanceAudienceMarker5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerDanceAudienceMarker5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PC
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PC Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerDanceAudienceMarker1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerDanceAudienceMarker1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY InnkeeperReplacement
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_InnkeeperReplacement Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
SetObjectiveCompleted(50)
RoomTrigger.Disable()
PunterScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(160)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 10

If(kmyQuest.IsQuestStopping)
	SetStage(150)
Else
	SetObjectiveDisplayed(10)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
Alias_Patron.GetActorRef().EvaluatePackage()
SetObjectiveDisplayed(20, False)
SetObjectiveDisplayed(30, False)
SetObjectiveDisplayed(35, False)
SetObjectiveCompleted(10, False)
SetObjectiveCompleted(20, False)
SetObjectiveFailed(30, False)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 50
RoomTrigger.Enable()
Alias_Patron.GetActorRef().EvaluatePackage()
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
SetObjectiveFailed(20)

If(RS.GetRelationshipPoints(Alias_Patron.GetActorRef()) > -150)
	RS.ModRelationshipPoints(Alias_Patron.GetActorRef(), -10)
EndIf

kmyQuest.AddDissatisfiedClient(Alias_Patron.GetActorRef(), 1)

SetObjectiveDisplayed(10, False)
SetObjectiveDisplayed(20, False)
SetObjectiveCompleted(10, False)
SetObjectiveFailed(20, False)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 70
Controller.PerformSexAct()
Controller.SkillLevelDifference(PlayerRef, Alias_Patron.GetActorRef(), Controller.SexAct)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.RemoveOrderedItems()
kmyQuest.AddSatisfiedClient(Alias_Patron.GetActorRef(), 1)
Controller.EarnReward(Alias_Patron.GetActorRef(), 1)
SetObjectiveCompleted(30)
Alias_Patron.GetActorRef().EvaluatePackage()
SetObjectiveDisplayed(20, False)
SetObjectiveDisplayed(30, False)
SetObjectiveCompleted(10, False)
SetObjectiveCompleted(20, False)
SetObjectiveCompleted(30, False)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 35
kmyQuest.RemoveOrderedItems()
kmyQuest.AddDissatisfiedClient(Alias_Patron.GetActorRef(), 1)
SetObjectiveFailed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
If(!WheelMenu.IsWheelMenuActive())
	WheelMenu.SetWheelMenuActive()
Else
	StorageUtil.SetIntValue(None, "APPS.TempVar.IsWheelMenuActive", 1)
EndIf

Int DanceGroupID = WheelMenu.GetMenuGroup("Tanzen")

If(DanceGroupID == 0)
	Exception.Throw("APPS", "Unable to continue because the ID for the selected menu group couldn't be found!", "Critical error")
	SetStage(10)
Else
	If(!WheelMenu.IsMenuGroupActive(DanceGroupID))
		WheelMenu.SetMenuGroupActive(DanceGroupID)
	Else
		StorageUtil.SetIntValue(None, "APPS.TempVar.IsDanceMenuActive", 1)
	EndIf

	If(!WheelMenu.IsMenuGroupExclusive(DanceGroupID))
		WheelMenu.SetMenuGroupExclusive(DanceGroupID)
	Else
		StorageUtil.SetIntValue(None, "APPS.TempVar.IsDanceMenuExclusive", 1)
	EndIf
EndIf

If(Alias_Tavern.GetLocation() == WhiterunBanneredMareLocation)
	Location Tavern = Alias_Tavern.GetLocation()
	ObjectReference Marker1 = Alias_PlayerDanceAudienceMarker1.GetRef()
	ObjectReference Marker2 = Alias_PlayerDanceAudienceMarker2.GetRef()
	ObjectReference Marker3 = Alias_PlayerDanceAudienceMarker3.GetRef()
	ObjectReference Marker4 = Alias_PlayerDanceAudienceMarker4.GetRef()

	Marker1.MoveTo(PlayerRef)
	Marker1.SetPosition(StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 0), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 1), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 2))
	Marker1.SetAngle(StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 3), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 4), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 5))
	Marker1.Enable()

	Marker2.MoveTo(PlayerRef)
	Marker2.SetPosition(StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 0), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 1), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 2))
	Marker2.SetAngle(StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 3), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 4), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 5))
	Marker2.Enable()

	Marker3.MoveTo(PlayerRef)
	Marker3.SetPosition(StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 0), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 1), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 2))
	Marker3.SetAngle(StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 3), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 4), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 5))
	Marker3.Enable()

	Marker4.MoveTo(PlayerRef)
	Marker4.SetPosition(StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 0), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 1), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 2))
	Marker4.SetAngle(StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 3), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 4), StorageUtil.FloatListGet(Tavern, "APPS.SQ01.Dance.MarkerPosition", 5))
	Marker4.Enable()
EndIf

SQ01_PlayerDancing.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 20
Alias_Patron.GetActorRef().EvaluatePackage()
SetObjectiveCompleted(10)
SetObjectiveDisplayed(20)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
PlayerRef.AddToFaction(ServicesWhiterunBanneredMare)

RegisterForSingleUpdateGameTime(1)

;/ temporarily disabled until full support of known Follower Frameworks
SQ01_DismissFollower.Start()
/;

SetObjectiveDisplayed(0)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 30
kmyQuest.CheckOrder()
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE APPS_SQ01_Functions
Quest __temp = self as Quest
APPS_SQ01_Functions kmyQuest = __temp as APPS_SQ01_Functions
;END AUTOCAST
;BEGIN CODE
kmyQuest.CurrentStage = 60
SetObjectiveCompleted(50)
SetObjectiveDisplayed(60)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
APPS_Controller_Functions Property Controller Auto
APPS_FW_Relationship Property RS Auto
APPS_DI_Functions Property WheelMenu Auto

Actor Property PlayerRef Auto
Faction Property ServicesWhiterunBanneredMare Auto
GlobalVariable Property PlayerFollowerCount Auto
Location Property WhiterunBanneredMareLocation Auto
ObjectReference Property RoomTrigger Auto
Quest Property SQ01_PlayerDancing Auto
Scene Property PunterScene Auto
