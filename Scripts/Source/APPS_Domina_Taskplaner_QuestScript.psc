;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname APPS_Domina_Taskplaner_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY currentLoc
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_currentLoc Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Dom
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Dom Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PC
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PC Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE APPS_TaskPlaner_Functions
Quest __temp = self as Quest
APPS_TaskPlaner_Functions kmyQuest = __temp as APPS_TaskPlaner_Functions
;END AUTOCAST
;BEGIN CODE
If(kmyQuest.IsTaskConditionsFailed)
	SetStage(0)
Else
	Stop()
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE APPS_TaskPlaner_Functions
Quest __temp = self as Quest
APPS_TaskPlaner_Functions kmyQuest = __temp as APPS_TaskPlaner_Functions
;END AUTOCAST
;BEGIN CODE
Actor Dom = Alias_Dom.GetActorRef()
Quest QuestToStart
Int Stage = Dom.GetFactionRank(SubDomRankFaction)
Int LastTaskID = StorageUtil.GetIntValue(None, "APPS.Follower.LastTaskID")
Int TaskID = LastTaskID
Int TasksFromStage
Int YearlyIndex =  StorageUtil.GetIntValue(None, "APPS.Follower.Tasks.YearlyIndex") ;Stores the taskIndex from the YearlyEventCount list
Int Month = GameMonth.GetValueInt()
Int Day = GameDay.GetValueInt()
Int YearlyEventCount = StorageUtil.IntListCount(None, "APPS.Follower.Tasks." + Month + "." + Day)
;/
If(YearlyEventCount > 0)
	If(YearlyIndex < YearlyEventCount)
		TaskID = StorageUtil.IntListGet(None, "APPS.Follower.Tasks." + Month + "." + Day, YearlyIndex)
		StorageUtil.SetIntValue(None, "APPS.Follower.Tasks.YearlyIndex", YearlyIndex + 1)
	Else
		StorageUtil.SetIntValue(None, "APPS.Follower.Tasks.YearlyIndex", 0)
	EndIf
ElseIf(StorageUtil.HasIntValue(None, "APPS.Follower.NextTask"))
	TaskID = StorageUtil.GetIntValue(None, "APPS.Follower.NextTask")
Else
	While(TaskID == LastTaskID)
		TasksFromStage = Utility.RandomInt(0, Stage)
		
		RNG = Utility.RandomInt(0, Stage * 400) ; 256
		RandomStage = Math.Floor(RNG / 100) ; RandomStage = 2
		NextRNG = RNG % 100 ; 56
		RandomTaskCat = Math.Floor(RNG / 20)
		
		RandomStage = Utility.RandomInt(0, Stage)
		RandomTaskCat = Utility.RandomInt(0, 1)
		RandomGlobalOrNPC = Utility.RandomInt(0, 1)
		
		MergedList = SUList(Global) + SUList(NPC) ;ML = 10 (0 .. 9) + 15 (10 .. 24) = 25 ;MLSeperator = 10 ;MLSpecificNPC = akNPC 
		If(RandomTaskCat == 0)
			SUKey = "General.S" + RandomStage
		Else
			SUKey = "Unique.S" + RandomStage
		EndIf
		
		RandomTask = Utility.RandomInt(akNPC, SUKey)
		TaskID = (Stage + 1) * 1000 + Utility.RandomInt(0, StorageUtil.IntListCount(None, "APPS.Follower.Tasks.Stage" + Stage) - 1)

		If(TaskID == StorageUtil.IntListFind(None, "APPS.Follower.ExcludedTasks", TaskID) && TaskID != 0)
			TaskID == LastTaskID
		EndIf
	EndWhile
EndIf

Quest StartQuest = StorageUtil.GetFormValue(None, "APPS.Follower.Task" + TaskID) As Quest
StartQuest.Start()
kmyQuest.Task = TaskID
/;
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Faction Property SubDomRankFaction Auto
GlobalVariable Property GameDay Auto
GlobalVariable Property GameMonth Auto
Keyword Property HasInnKeyword Auto