Scriptname APPS_Libs_Functions extends Quest  Conditional
GlobalVariable Property GameDay Auto
GlobalVariable Property GameHour Auto
GlobalVariable Property GameMonth Auto
Keyword[] Property Chairs Auto
Keyword Property IsTable Auto
Int[] MonthLengths

Event OnInit()
MonthLengths = New Int[12]
MonthLengths[0] = 31
MonthLengths[1] = 28
MonthLengths[2] = 31
MonthLengths[3] = 30
MonthLengths[4] = 31
MonthLengths[5] = 30
MonthLengths[6] = 31
MonthLengths[7] = 31
MonthLengths[8] = 30
MonthLengths[9] = 31
MonthLengths[10] = 30
MonthLengths[11] = 31
EndEvent

;Returns the last day of the given month, submitting no value returns the last day of the current month
Int Function LastDayOfMonth(Int aiMonth = 0)
	If(aiMonth < 0 || aiMonth > 12)
		Return - 1
	ElseIf(aiMonth == 0)
		Return MonthLengths[GameMonth.GetValueInt()]
	Else
		Return MonthLengths[aiMonth]
	EndIf
EndFunction

;Returns the week of a specific date
;Tamriel calendar does not have leap years, so there is no need to submit a specific year
;This function does not follow the ISO standard which says that the first week of a year/month has to contain Thursday (or Wednesday for leap years)
Int Function WeekOfYear(Int aiDayOfMonth = 0, Int aiMonth = 0)
	Int TotalDaysPassed
	Int i

	If(aiDayOfMonth == 0)
		aiDayOfMonth = GameDay.GetValueInt()
	EndIf

	If(aiMonth == 0)
		aiMonth = GameMonth.GetValueInt()
	EndIf

	If(!IsValidDate(aiDayOfMonth, aiMonth))
		Return -1
	EndIf

	While(i < aiMonth)
		TotalDaysPassed += MonthLengths[i]
		i += 1
	EndWhile

	TotalDaysPassed += aiDayOfMonth

	Return Math.Floor(TotalDaysPassed / 7)
EndFunction

;Checks the given date if it is valid
Bool Function IsValidDate(Int aiDayofMonth, Int aiMonth)
	If(aiMonth < 1 || aiMonth > 12 || aiDayOfMonth < 1 || aiDayOfMonth > MonthLengths[aiMonth])
		Return False
	EndIf

	Return True
EndFunction

Function RegisterDailyCalendarEvent(Int aiHour, Int aiPreHourStart = 0, Int aiPreHourEnd)
	If(aiHour < 0 || aiHour > 24)
		Return
	EndIf

EndFunction

Float Function RandomGameTime(Int aiStart, Int aiEnd, Int aiHourSplit = 4, Int aiInDays = 0)
	If(aiInDays < 0)
		aiInDays = 0
	EndIf

	aiInDays = aiInDays * 24

	If(aiHourSplit <= 0)
		aiHourSplit = 4
	EndIf

	Int NormalizedStart = NormalizeTime(GameHour.GetValueInt(), aiStart + aiInDays) * aiHourSplit
	Int NormalizedEnd = (NormalizeTime(aiStart, aiEnd) + aiInDays) * aiHourSplit
	Return Utility.RandomInt(NormalizedStart, NormalizedStart + NormalizedEnd) / aiHourSplit
EndFunction

Int Function NormalizeTime(Int aiEventStart, Int aiEventEnd)
	If(aiEventStart < aiEventEnd)
		Return (aiEventEnd - aiEventStart)
	ElseIf(aiEventStart >= aiEventEnd)
		Return (24 - aiEventStart + aiEventEnd)
	EndIf
EndFunction

Function AddFreeSeats(ObjectReference akSeatGroup, Bool abIsAddingFreeChair = True, Bool abIsInitializing = False)
	Int Seats = CountSeats(akSeatGroup)
	Int i

	If(abIsInitializing)
		While(i < Seats)
			If(!akSeatGroup.HasKeywordString("APPS_IsBench"))
				If(!akSeatGroup.GetLinkedRef(Chairs[i]).IsFurnitureInUse())
					StorageUtil.SetIntValue(akSeatGroup, "APPS.Follower.FFQ001.FreeSeats", StorageUtil.GetIntValue(akSeatGroup, "APPS.Follower.FFQ001.FreeSeats") + 1)
				EndIf
			Else
				If(!akSeatGroup.IsFurnitureMarkerInUse(i))
					StorageUtil.SetIntValue(akSeatGroup, "APPS.Follower.FFQ001.FreeSeats", StorageUtil.GetIntValue(akSeatGroup, "APPS.Follower.FFQ001.FreeSeats") + 1)
				EndIf
			EndIf

			i += 1
		EndWhile
	Else
		If(abIsAddingFreeChair)
			StorageUtil.SetIntValue(akSeatGroup, "APPS.Follower.FFQ001.FreeSeats", StorageUtil.GetIntValue(akSeatGroup, "APPS.Follower.FFQ001.FreeSeats") + 1)
		Else
			StorageUtil.SetIntValue(akSeatGroup, "APPS.Follower.FFQ001.FreeSeats", StorageUtil.GetIntValue(akSeatGroup, "APPS.Follower.FFQ001.FreeSeats") - 1)
		EndIf
	EndIf
EndFunction

Int Function CountSeats(ObjectReference akSeatGroup)
	If(akSeatGroup.HasKeywordString("APPS_IsBench") || akSeatGroup.HasKeywordString("IsTable"))
		If(akSeatGroup.HasKeywordString("APPS_Seats4"))
			Return 4
		ElseIf(akSeatGroup.HasKeywordString("APPS_Seats3"))
			Return 3
		ElseIf(akSeatGroup.HasKeywordString("APPS_Seats2"))
			Return 2
		Else
			Return 1
		EndIf
	Else
		Return 1
	EndIf
EndFunction

ObjectReference Function GetFreeSeatInGroup(ObjectReference akPointedSeat)
	ObjectReference Table = akPointedSeat.GetLinkedRef(IsTable)
	Int Seats = CountSeats(Table)
	Int i

	While(i < Seats)
		ObjectReference FreeSeat = Table.GetLinkedRef(Chairs[i])
		If(!FreeSeat.IsFurnitureInUse() && FreeSeat != akPointedSeat)
			Return FreeSeat
		EndIf

		i += 1
	EndWhile
EndFunction 