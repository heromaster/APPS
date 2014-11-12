Scriptname APPS_SQ01_Order_Functions Extends Quest Conditional
Import StorageUtil

Bool Property IsOrderNoted Auto Conditional Hidden
Int Property Orders Auto Conditional Hidden

Function FillOrder(Int aiOrderNumber, Potion akOrderedFood)
	FormListAdd(None, "APPS.SQ01.Order", akOrderedFood)
	Orders += 1
EndFunction

