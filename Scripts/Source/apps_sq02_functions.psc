Scriptname APPS_SQ02_Functions extends Quest  Conditional
SexLabFramework Property SexLab Auto
sslActorLibrary Property SexLib Auto
APPS_Controller_Variables Property Var Auto 

Function SetViewSpot(ObjectReference ViewSpot)
	ViewSpot.SetPosition(92, 263, 321)
	ViewSpot.SetAngle(0, 0, 270)
EndFunction

Function PerformSex(Actor akWhore, Actor akPlayer, Int SexAct)
	sslBaseAnimation[] SexAnimationList
	Actor[] SexActorList = New Actor[2]
	SexActorList[0] = akPlayer
	SexActorList[1] = akWhore
	SexActorList = SexLab.SortActors(SexActorList)

	If(SexAct == 1 && (akWhore.GetBaseObject() As ActorBase).GetSex() == 1 && (akPlayer.GetBaseObject() As ActorBase).GetSex() == 1)
		SexAnimationList = SexLab.GetAnimationsByTag(2, "Cunnilingus", tagSuppress = "Zaz")
	Else
		SexAnimationList = SexLab.GetAnimationsByTag(2, "Oral", tagSuppress = "Zaz")
	EndIf

	If(SexLib.bUseStrapons)
		Var.StraponOriginalValue = True
		SexLib.bUseStrapons = False
	EndIf

	sslThreadModel th = SexLab.NewThread()
	th.AddActor(SexActorList[0])
	th.AddActor(SexActorList[1])
	th.SetAnimations(SexAnimationList)
	th.DisableLeadIn(True)
	th.SetBedding(1)
	th.StartThread()
EndFunction

Function PerformMasturbation(Actor akWhore)
	sslBaseAnimation[] SexAnimationList
	Actor[] SexActorList = New Actor[1]
	SexActorList[0] = akWhore

	SexAnimationList = SexLab.GetAnimationsByTag(1, "Masturbation", "Standing", tagSuppress = "Zaz")

	sslThreadModel th = SexLab.NewThread()
	th.AddActor(SexActorList[0])
	th.SetAnimations(SexAnimationList)
	th.DisableLeadIn(True)
	th.SetBedding(0)
	th.StartThread()
EndFunction