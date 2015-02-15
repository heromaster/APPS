Scriptname APPS_TaskPlaner_Functions extends Quest  Conditional
Bool Property IsAcceptingQuests = True Auto Conditional Hidden
Bool Property IsRestrainted Auto Hidden
Bool Property IsSubTask = False Auto Conditional Hidden
Bool Property IsTaskConditionsFailed Auto Hidden
Int Property Task Auto Conditional Hidden

Bool Function AddYearlyEventTask(Quest akTask, Int auiMonth, Int auiDay, Int auiStage = 0, Actor akNPC = None)
	String SUKey

	If(!akTask || !IsValidDate(auiDay, auiMonth) || auiStage < 0 || auiStage > 4)
		Return False
	EndIf

	SUKey = "APPS.TP.Yearly.D" + auiDay + ".M" + auiMonth + ".S" + auiStage

	Return _AddTask(akNPC, SUKey, akTask)
EndFunction

Bool Function AddMonthlyEventTask(Quest akTask, Int auiDayOfMonth, Int auiStage = 0, Actor akNPC = None)
	String SUKey

	If(!akTask || auiDayOfMonth < 1 || auiDayOfMonth > 28)
		Return False
	EndIf

	SUKey = "APPS.TP.Monthly.D" + auiDayOfMonth + ".S" + auiStage

	Return _AddTask(akNPC, SUKey, akTask)
EndFunction

Bool Function AddWeeklyEventTask(Quest akTask, Int auiDayOfWeek, Int auiStage = 0, Actor akNPC = None)
	String SUKey

	If(!akTask || auiDayOfWeek < 1 || auiDayOfWeek > 7 || auiStage < 0 || auiStage > 4)
		Return False
	EndIf

	SUKey = "APPS.TP.Weekly.D" + auiDayOfWeek + ".S" + auiStage

	Return _AddTask(akNPC, SUKey, akTask)
EndFunction

Bool Function AddUniqueTask(Quest akTask, Int auiStage = 0, Int auiTargetGroup = 1, Actor akNPC = None)
	String SUKey

	If(!akTask || auiStage < 0 || auiStage > 4 || auiTargetGroup < 0 || auiTargetGroup > 2)
		Return False
	EndIf

	If(auiTargetGroup == 0)
		SUKey = "APPS.TP.Unique"
	ElseIf(auiTargetGroup == 1)
		SUKey = "APPS.TP.Dom.Unique"
	Else
		SUKey = "APPS.TP.Sub.Unique"
	EndIf

	Return _AddTask(akNPC, SUKey, akTask)
EndFunction

Bool Function AddTransitionTask(Quest akTask, Int auiStage = 0, Int auiTargetGroup = 1, Actor akNPC = None)
	String SUKey

	If(!akTask || auiStage < 0 || auiStage > 4 || auiTargetGroup < 1 || auiTargetGroup > 2)
		Return False
	EndIf

	If(auiTargetGroup == 1)
		SUKey = "APPS.TP.Dom.Trans.S" + auiStage
	Else
		SUKey = "APPS.TP.Sub.Trans.S" + auiStage
	EndIf

	Return _AddTask(akNPC, SUKey, akTask)
EndFunction

Bool Function AddGeneralTask(Quest akTask, Int auiStage = 0, Int auiTargetGroup = 1, Actor akNPC = None)
String SUKey

	If(!akTask || auiStage < 0 || auiStage > 4 || auiTargetGroup < 0 || auiTargetGroup > 2)
		Return False
	EndIf

	If(auiTargetGroup == 0)
		SUKey = "APPS.TP.General"
	ElseIf(auiTargetGroup == 1)
		SUKey = "APPS.TP.Dom.General.S" + auiStage
	Else
		SUKey = "APPS.TP.Sub.General.S" + auiStage
	EndIf

	Return _AddTask(akNPC, SUKey, akTask)
EndFunction

Bool Function AddSubTaskChain(Quest akTask, Quest akParentTask, Int auiPosition = 0)
	Return _AddTaskOrSubTaskChain(akTask, akParentTask, True, auiPosition)
EndFunction

Bool Function AddTaskChain(Quest akTask, Quest akParentTask, Int auiPosition = 0, Bool abAllowDuplicateTasks = False)
	Return _AddTaskOrSubTaskChain(akTask, akParentTask, False, auiPosition, abAllowDuplicateTasks)
EndFunction

Bool Function AddSubTask(Quest akTask, Quest akParentTask)
	String SUKey
	
	If(!akTask || !akParentTask || StorageUtil.FormListCount(akParentTask, "APPS.TP.SubTaskChain") > 0)
		Return False
	EndIf

	SUKey = "APPS.TP.SubTask"

	Return _AddTask(akParentTask, SUKey, akTask)
EndFunction

Bool Function IsValidDate(Int auiDay, Int auiMonth)
	If(auiMonth < 1 || auiMonth > 12)
		Return False
	ElseIf(auiMonth == 2 && auiDay > 28)
		Return False
	ElseIf(auiDay > 30 && auiMonth == 4 || auiMonth == 6 || auiMonth == 9 || auiMonth == 11)
		Return False
	EndIf

	Return True
EndFunction

Bool Function _AddTask(Form akForm, String asKey, Quest akTask)
	String SUKey

	If(StorageUtil.FormListAdd(akForm, asKey, akTask, False) == -1)
		Return False
	Else
		If(akForm)
			StorageUtil.FormListAdd(None, "APPS.TP.TaskedNPC", akForm, False)
		EndIf
	EndIf

	StorageUtil.StringListAdd(akTask, "APPS.TP.Registry", SUKey)
	Return True
EndFunction

Bool Function _AddTaskOrSubTaskChain(Quest akTask, Quest akParentTask, Bool abIsSubTask, Int auiPosition = 0, Bool abAllowDuplicateTasks = False)
	String SUKey

	;Obligatory checks if the arguments are valid
	If(!akTask || !akParentTask)
		Return False
	EndIf

	If(abIsSubTask)
		SUKey = "APPS.TP.SubTaskChain"
	Else
		SUKey = "APPS.TP.TaskChain"
	EndIf

	;If a position is given, check if the position is not out of bounds
	If(auiPosition > 0)
		If(auiPosition > StorageUtil.FormListCount(akParentTask, SUKey))
			Return False
		Else
			;If this task is allowed to appear more than once in quest chain, just insert it
			If(abAllowDuplicateTasks)
				If(!StorageUtil.FormListInsert(akParentTask, SUKey, auiPosition - 1, akTask))
					Return False
				EndIf
			;If this task is not allowed to appear more than once in the quest chain, check if it is already existing
			Else
				If(StorageUtil.FormListFind(akParentTask, SUKey, akTask))
					Return False
				Else
					If(!StorageUtil.FormListInsert(akParentTask, SUKey, auiPosition - 1, akTask))
						Return False
					EndIf
				EndIf
			EndIf
		EndIf

	;If a position is not given, just add the task to the end of the array
	ElseIf(StorageUtil.FormListAdd(akParentTask, SUKey, akTask, False) == -1)
		Return False
	EndIf

	StorageUtil.FormListAdd(None, "APPS.TP.TaskChainParentTasks", akParentTask, False)
	Return True
EndFunction

Bool Function RemoveTask(Quest akTask)
	
EndFunction

Bool Function RemoveYearlyEventTask(Quest akTask, Int auiMonth, Int auiDay, Int auiStage = 0, Actor akNPC = None)
	
EndFunction

Bool Function RemoveMonthlyEventTask(Quest akTask, Int auiDayOfMonth, Int auiStage = 0, Actor akNPC = None)
	
EndFunction

Bool Function RemoveWeeklyEventTask(Quest akTask, Int auiDayOfWeek, Int auiStage = 0, Actor akNPC = None)
	
EndFunction

Bool Function RemoveUniqueTask(Quest akTask, Int auiStage = 0, Int auiTargetGroup = 1, Actor akNPC = None)

EndFunction

Bool Function RemoveTransitionTask(Quest akTask, Int auiStage = 0, Int auiTargetGroup = 1, Actor akNPC = None)
	
EndFunction

Bool Function RemoveGeneralTask(Quest akTask, Int auiStage = 0, Int auiTargetGroup = 1, Actor akNPC = None)
EndFunction

Bool Function RemoveSubTaskChain(Quest akTask, Quest akParentTask, Int auiPosition = 0)
	
EndFunction

Bool Function RemoveTaskChain(Quest akTask, Quest akParentTask, Int auiPosition = 0, Bool abAllowDuplicateTasks = False)
	
EndFunction

Bool Function RemoveSubTask(Quest akTask, Quest akParentTask)
	
EndFunction
