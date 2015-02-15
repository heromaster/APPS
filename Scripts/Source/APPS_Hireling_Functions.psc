Scriptname APPS_Hireling_Functions extends Quest  Conditional
APPS_Follower_Functions Property FollowerFunctions Auto
APPS_HirelingMonitor_Functions Property HirelingMonitorFunctions Auto
FormList Property CanFollowList Auto
GlobalVariable Property HasHirelingGV Auto
MiscObject Property Septims Auto
Quest Property HirelingMonitor Auto
ReferenceAlias Property Alias_Hireling Auto
ReferenceAlias Property Alias_PC Auto

Function PayHireling(Actor akHireling, Int aiPayment)
	Alias_PC.GetActorRef().RemoveItem(Septims, aiPayment)
	StorageUtil.SetIntValue(akHireling, "APPS.Follower.Gold", StorageUtil.GetIntValue(akHireling, "APPS.Follower.Gold") + aiPayment)
	HasHirelingGV.Value = 1
	Alias_Hireling.ForceRefTo(akHireling)
	CanFollowList.AddForm(akHireling)
	HirelingMonitor.Start()
	HirelingMonitorFunctions.SetPaymentInterval()
	HirelingMonitor.SetStage(10)
	FollowerFunctions.SetFollower(akHireling)
EndFunction

Function DismissHireling(Actor akHireling)
	HasHirelingGV.Value = 0
	Alias_Hireling.Clear()
	CanFollowList.RemoveAddedForm(akHireling)
	HirelingMonitor.Stop()
EndFunction
