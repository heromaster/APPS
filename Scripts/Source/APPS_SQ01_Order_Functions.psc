Scriptname APPS_SQ01_Order_Functions extends Quest Conditional
Import StorageUtil

Actor Property PlayerRef Auto
Bool Property IsOrderNoted Auto Conditional Hidden
Bool Property IsQuestStopping Auto Conditional Hidden
Int Property OrdersFailed Auto Conditional Hidden
Int Property HoursWorked Auto Conditional Hidden
Int Property Orders Auto Conditional Hidden

Int Bill
Int SupposedOrders

Function FillOrder(Int aiOrderNumber, Potion akOrderedFood)
	FormListAdd(None, "APPS.SQ01.Order", akOrderedFood)
	Orders += 1
EndFunction

Function FillSupposedOrder(Int auiOrderNumber, Potion akSupposedOrderedFood)
	FormListAdd(None, "APPS.SQ01.SupposedOrder", akSupposedOrderedFood)
	SupposedOrders += 1
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
		While(i < SupposedOrders)
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