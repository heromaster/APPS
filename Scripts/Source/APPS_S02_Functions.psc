Scriptname APPS_S02_Functions extends Quest  Conditional
SexLabFramework Property SexLab Auto
Bool[] Property StripSlots  Auto
ReferenceAlias Property Alias_Sub Auto
ReferenceAlias Property Alias_Dom Auto

Event OnAnimationEnds(String asName, String asString, Float afNum, Form akSender)
	UnregisterForModEvent("AnimationEnd")
	Stop()
EndEvent

Function StartOral(Actor akReceiver, Actor akGiver)
	sslBaseAnimation[] AnimationList
	Actor[] ActorList = New Actor[2]
	ActorList[0] = akGiver
	ActorList[1] = akReceiver

	If(ActorList[1].GetActorBase().GetSex() == 1)
		AnimationList = SexLab.GetAnimationsByTags(2, "Zyn,Sex,Oral,Lesbian", requireAll = True)
	Else
		AnimationList = SexLab.GetAnimationsByTags(2, "AP,MF,Blowjob,Standing", requireAll = True)
	EndIf

	RegisterForModEvent("AnimationEnd", "OnAnimationEnds")
	sslThreadModel th = SexLab.NewThread()
	th.AddActor(ActorList[0])
	th.AddActor(ActorList[1])
	th.SetAnimations(AnimationList)
	th.DisableLeadIn(True)
	th.DisableBedUse()
	th.StartThread()
EndFunction