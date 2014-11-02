Scriptname APPS_SQ01_Order_Functions extends Quest Conditional
Import StorageUtil

Actor Property PlayerRef Auto
Bool Property IsOrderNoted Auto Conditional Hidden
Bool Property IsQuestStopping Auto Conditional Hidden
Int Property OrdersFailed Auto Conditional Hidden
Int Property HoursWorked Auto Conditional Hidden
Int Property Orders Auto Conditional Hidden

Bool IsCorrectFoodOrder
Int Bill

Function FillOrder(Int aiOrderNumber, Potion akOrderedFood)
	FormListAdd(None, "APPS.SQ01.Order", akOrderedFood)
	Orders += 1
EndFunction

Function FillSupposedOrder(Int auiOrderNumber, Potion akSupposedOrderedFood)
	FormListAdd(None, "APPS.SQ01.SupposedOrder", akSupposedOrderedFood)
EndFunction

Function AddOrderedItems()
	Int i = 0
	
	If(IsOrderNoted)
		While(i < Orders)
			Potion FoodItem = FormListGet(None, "APPS.SQ01.Order", i) As Potion
			PlayerRef.AddItem(FoodItem)
			Bill += FoodItem.GetGoldValue()

			i += 1
		EndWhile
	Else
		While(i < FormListCount(None, "APPS.SQ01.SupposedOrder"))
			Potion SupposedFoodItem = FormListGet(None, "APPS.SQ01.SupposedOrder", i) As Potion
			PlayerRef.AddItem(SupposedFoodItem)
			Bill += SupposedFoodItem.GetGoldValue()

			i += 1
		EndWhile
	EndIf
EndFunction

Function DeductWages()
	AdjustIntValue(None, "APPS.SQ01.Wages", -Bill)
EndFunction

Function CheckOrder()
	Int i = 0
	
	If(IsOrderNoted)
		IsCorrectFoodOrder = True
		Return
	EndIf
	
	If(FormListCount(None, "APPS.SQ01.SupposedOrder") < Orders)
		IsCorrectFoodOrder = False
		Return
	EndIf
	
	While(i < FormListCount(None, "APPS.SQ01.SupposedOrder"))
		If(FormListGet(None, "APPS.SQ01.SupposedOrder", i) != FormListGet(None, "APPS.SQ01.Order", i))
			IsCorrectFoodOrder = False
			Return
		EndIf

		i += 1
	EndWhile

	IsCorrectFoodOrder = True
EndFunction

Function RemoveOrderItems(Actor akPlayer)
	Int i = 0

	If(IsOrderNoted)
		While(i < Orders)
			akPlayer.RemoveItem(FormListGet(None, "APPS.SQ01.Order", i))
			
			i += 1
		EndWhile
	Else
		While(i < FormListCount(None, "APPS.SQ01.SupposedOrder"))
			akPlayer.RemoveItem(FormListGet(None, "APPS.SQ01.SupposedOrder", i))

			i += 1
		EndWhile
	EndIf
EndFunction