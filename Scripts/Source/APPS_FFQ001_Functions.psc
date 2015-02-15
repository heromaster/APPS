Scriptname APPS_FFQ001_Functions extends Quest Conditional
APPS_Libs_Functions Property Libs Auto
Bool Property IsChairInUse Auto Conditional Hidden
Int Property Drink Auto Conditional Hidden
Int Property EvalResult Auto Conditional Hidden
FormList Property AllowedDrinks  Auto
Keyword Property IsTable Auto
LocationAlias Property Alias_Inn Auto
Package Property SelectedChairPackage Auto
ReferenceAlias Property Alias_Dom Auto
ReferenceAlias Property Alias_PointedChair Auto
ReferenceAlias Property Alias_FavoriteChair Auto

Bool IsEvaluating
Int EVAL_SEAT_ERROR = -3
Int EVAL_SEAT_BETTER_PLACE = -2
Int EVAL_SEAT_FAV_CHAIR = -1
Int EVAL_SEAT_ALL_TAKEN = 0
Int EVAL_SEAT_GROUP = 8
Int EVAL_SEAT_CURRENT = 9
Int TargetedPlace

Event OnInit()
	If(IsStopped())
		Return
	EndIf

	Int i = 0
	Int FavoredDrink = 0

	While(i < AllowedDrinks.GetSize())
		Form TempDrink = AllowedDrinks.GetAt(i)
		Int TempDrinks = StorageUtil.GetIntValue(TempDrink, "APPS.Follower.TotalDrinks")

		If(TempDrinks > FavoredDrink)
			Drink = i + 1
			FavoredDrink = TempDrinks
		EndIf

		i += 1
	EndWhile

	If(Alias_Inn.GetLocation() == StorageUtil.GetFormValue(Alias_Dom.GetActorRef(), "APPS.Follower.FavoriteInn"))
		Alias_FavoriteChair.ForceRefTo(StorageUtil.GetFormValue(Alias_Dom.GetActorRef(), "APPS.Follower.FavoriteChair") As ObjectReference)
	EndIf
EndEvent

Event OnCrosshairRefChange(ObjectReference akTarget)
	If(akTarget == None || IsEvaluating)
		Return
	EndIf

	If(akTarget.HasKeywordString("APPS_IsChair") || akTarget.HasKeywordString("APPS_IsBench") || akTarget.HasKeywordString("isBarStool"))
		Alias_PointedChair.ForceRefTo(akTarget)
	Else
		Alias_PointedChair.Clear()
	EndIf
EndEvent

Event OnKeyUp(Int akKey, Float afTime)
	If(akKey == 47 && Alias_PointedChair.GetRef())
		If(IsEvaluating)
			Return
		Else
			IsEvaluating = True
			EvalResult = EvalSelectedChair()
			Alias_Dom.GetActorRef().EvaluatePackage()
			IsEvaluating = False
		EndIf
	EndIf
EndEvent

Int Function EvalSelectedChair(ObjectReference akFavoriteChair = None, Bool ForceUseSelectedChair = False)
	ObjectReference SelectedChair = Alias_PointedChair.GetRef()
	ObjectReference FavoriteChair = Alias_FavoriteChair.GetRef()

	;Cancel function if Follower is not available
	If(!Alias_Dom)
		Return EVAL_SEAT_ERROR
	EndIf

	If(akFavoriteChair)
		FavoriteChair = akFavoriteChair
	EndIf

	;If this var is set, then just take this seat
	If(ForceUseSelectedChair)
		If(SelectedChair != FavoriteChair)
			Return EVAL_SEAT_FAV_CHAIR
		Else
			Return 1
		EndIf
	EndIf

	;If no favorite seat is submitted, look up in StorageUtil and use this if available
	If(!FavoriteChair)
		 FavoriteChair = StorageUtil.GetFormValue(Alias_Dom.GetActorRef(), "APPS.Follower.FavoriteChair") As ObjectReference
	EndIf

	;If the favorite chair is disabled or deleted, null the objectreference
	If(FavoriteChair)
		If(FavoriteChair.IsDisabled() || FavoriteChair.IsDeleted())
			FavoriteChair = None
		EndIf
	EndIf

	; Check if favorite chair is in group the player selected (based on seleted chair)
	If(SelectedChair.GetLinkedRef(IsTable) == FavoriteChair.GetLinkedRef(IsTable))
		;Check if the selected chair is actually the favorite chair
		If(SelectedChair == FavoriteChair)
			If(!FavoriteChair.IsFurnitureInUse())
				Return EVAL_SEAT_FAV_CHAIR
			EndIf
		Else
			If(!FavoriteChair.IsFurnitureInUse())
				Return EVAL_SEAT_FAV_CHAIR
			EndIf
		EndIf
	EndIf

	TargetedPlace=CountFreeSeatsInGroup(SelectedChair)
	If(TargetedPlace >= 2)
		If(SelectedChair.IsFurnitureInUse())
			Alias_PointedChair.ForceRefTo(Libs.GetFreeSeatInGroup(SelectedChair))
			Return EVAL_SEAT_GROUP
		Else
			Return EVAL_SEAT_CURRENT
		EndIf
	EndIf

	Int FreeSeatsResult = GetNextFreeGroup("TableGroup")
	If(FreeSeatsResult == 0)
		FreeSeatsResult = GetNextFreeGroup("LooseChairGroup")
		If(FreeSeatsResult == 0)

			FreeSeatsResult = GetNextFreeGroup("BarGroup")
			If(FreeSeatsResult == 0)

				FreeSeatsResult = GetNextFreeGroup("Bench")
				If(FreeSeatsResult == 0)
					Return EVAL_SEAT_ALL_TAKEN
				Else
					Return EvalBenches(FreeSeatsResult, FavoriteChair)
				EndIf
			Else
				Return EvalBarGroup(FreeSeatsResult, FavoriteChair)
			EndIf
		Else
			Return EvalLooseChairGroup(FreeSeatsResult, FavoriteChair)
		EndIf
	Else
		Return EvalTableGroup(FreeSeatsResult, FavoriteChair)
	EndIf
	
EndFunction

Int Function EvalBenches(Int aiFreeSeatsResult, ObjectReference akFavoriteChair)
	If(aiFreeSeatsResult == 1)
		If(EvalFavChair(akFavoriteChair))
			Return EVAL_SEAT_FAV_CHAIR
		Else
			Return EVAL_SEAT_BETTER_PLACE
		EndIf
	Else
		If(EvalFavChair(akFavoriteChair))
			Return EVAL_SEAT_FAV_CHAIR
		Else
			if(TargetedPlace >= aiFreeSeatsResult)
				Return EVAL_SEAT_CURRENT
			Else
				Return EVAL_SEAT_BETTER_PLACE
			EndIf
		EndIf
	EndIf
EndFunction

Int Function EvalBarGroup(Int aiFreeSeatsResult, ObjectReference akFavoriteChair)
	If(aiFreeSeatsResult == 1)
		If(EvalFavChair(akFavoriteChair))
			Return EVAL_SEAT_FAV_CHAIR
		Else
			If(EvalBenches(GetNextFreeGroup("Bench"), akFavoriteChair) > aiFreeSeatsResult)
				Return EVAL_SEAT_BETTER_PLACE
			Else
				Return EVAL_SEAT_BETTER_PLACE
			EndIf
		EndIf
	Else
		If(EvalFavChair(akFavoriteChair))
			Return EVAL_SEAT_FAV_CHAIR
		Else
			if(TargetedPlace >= aiFreeSeatsResult)
				Return EVAL_SEAT_CURRENT
			Else
				Return EVAL_SEAT_BETTER_PLACE
			EndIf
		EndIf
	EndIf
EndFunction

Int Function EvalLooseChairGroup(Int aiFreeSeatsResult, ObjectReference akFavoriteChair)
	If(aiFreeSeatsResult == 1)
		If(EvalFavChair(akFavoriteChair))
			Return EVAL_SEAT_FAV_CHAIR
		Else
			If(EvalBarGroup(GetNextFreeGroup("BarGroup"), akFavoriteChair) > aiFreeSeatsResult)
				Return EVAL_SEAT_BETTER_PLACE
			Else
				If(EvalBenches(GetNextFreeGroup("Bench"), akFavoriteChair) > aiFreeSeatsResult)
					Return EVAL_SEAT_BETTER_PLACE
				EndIf
				Return EVAL_SEAT_BETTER_PLACE
			EndIf
		EndIf
	Else
		If(EvalFavChair(akFavoriteChair))
			Return EVAL_SEAT_FAV_CHAIR
		Else
			if(TargetedPlace >= aiFreeSeatsResult)
				Return EVAL_SEAT_CURRENT
			Else
				Return EVAL_SEAT_BETTER_PLACE
			EndIf
		EndIf
	EndIf
EndFunction

Int Function EvalTableGroup(Int aiFreeSeatsResult, ObjectReference akFavoriteChair)
	If(aiFreeSeatsResult == 1)
		If(EvalFavChair(akFavoriteChair))
			Return EVAL_SEAT_FAV_CHAIR
		Else
			If(EvalLooseChairGroup(GetNextFreeGroup("LooseChairGroup"), akFavoriteChair) > aiFreeSeatsResult)
				Return EVAL_SEAT_BETTER_PLACE
			Else
				If(EvalBarGroup(GetNextFreeGroup("BarGroup"), akFavoriteChair) > aiFreeSeatsResult)
					Return EVAL_SEAT_BETTER_PLACE
				Else
					If(EvalBenches(GetNextFreeGroup("Bench"), akFavoriteChair) > aiFreeSeatsResult)
						Return EVAL_SEAT_BETTER_PLACE
					EndIf
				EndIf
				Return EVAL_SEAT_BETTER_PLACE
			EndIf
		EndIf
	Else
		If(EvalFavChair(akFavoriteChair))
			Return EVAL_SEAT_FAV_CHAIR
		Else
			if(TargetedPlace >= aiFreeSeatsResult)
				Return EVAL_SEAT_CURRENT
			Else
				Return EVAL_SEAT_BETTER_PLACE
			EndIf
		EndIf
	EndIf
EndFunction

Bool Function EvalFavChair(ObjectReference akFavoriteChair = None)
	If(akFavoriteChair && !akFavoriteChair.IsFurnitureInUse())
		Return True
	EndIf

	Return False
EndFunction

Int Function CountFreeSeatsInGroup(ObjectReference akChair)
	Return StorageUtil.GetIntValue(akChair.GetLinkedRef(IsTable), "APPS.Follower.FFQ001.FreeSeats")
EndFunction

Int Function GetNextFreeGroup(String asObjectType)
	Quest HelperQuest = StorageUtil.GetFormValue(Alias_Inn.GetLocation(), "APPS.Follower.FFQ001Helper") As Quest
	Int i = 1
	Int HighestSeatsFree

	While(i <= 6)
		ReferenceAlias TempAlias = HelperQuest.GetAliasByName(asObjectType + i) As ReferenceAlias

		If(TempAlias)
			Int TempSeats = StorageUtil.GetIntValue(TempAlias.GetRef(), "APPS.Follower.FFQ001.FreeSeats")

			If(TempSeats > HighestSeatsFree)
				HighestSeatsFree = TempSeats
			EndIf

			If(HighestSeatsFree > 1)
				Return HighestSeatsFree
			EndIf
		EndIf

		i += 1
	EndWhile

	Return HighestSeatsFree
EndFunction

Function CountDrinks(Int aiDrink)
	If(aiDrink < 1 || aiDrink > AllowedDrinks.GetSize())
		Return
	EndIf

	Form ThisDrink = AllowedDrinks.GetAt(aiDrink - 1)
	Int DrinkCounter = StorageUtil.GetIntValue(ThisDrink, "APPS.Follower.TotalDrinks") + 1

	StorageUtil.SetIntValue(ThisDrink, "APPS.Follower.TotalDrinks", DrinkCounter)
	Drink = aiDrink
EndFunction

Function BeginSelectChairEvents()
	RegisterForCrosshairRef()
	RegisterForKey(47)
EndFunction

Function EndSelectChairEvents()
	UnregisterForCrosshairRef()
	UnregisterForKey(47)
EndFunction