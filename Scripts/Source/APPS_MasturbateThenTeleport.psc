Scriptname APPS_MasturbateThenTeleport extends ObjectReference  
{Makes the actor who activated this object to masturbate. Upon completion, she teleports to the given actor}

SexLabFramework property SexLab auto
;points to the SexLab Framework script so we can use its functions

Bool Property promptForBed = False Auto
;if set to true,  will prompt the player if they want to use the nearest bed within a radius of 500. 

Actor Property playerRef Auto
;points to the player

Float Property WaitTime = 2.0 Auto
;waiting time between end of masturbation and teleportation

ObjectReference Property Destination Auto
;the destination the actor will be teleported to

Float Property XOffset = 0.0 Auto
;the offset from the destination, on the x axis

Float Property YOffset = 0.0 Auto
;the offset from the destination, on the y axis

Float Property ZOffset = 0.0 Auto
;the offset from the destination, on the z axis

Bool Property MatchRotation = False Auto
;whether to match the rotation of the destination object or not

Event OnActivate(ObjectReference akActionRef)
;when this object is activated
	
	actor[] sexActor = new Actor[1]
	;declares an actor array variable containing just 1 actor
	sexActor[0] = akActionRef as Actor
	;sets the first and only actor in this array to be the actor that activated this object
	sslBaseAnimation[] anims
	;declares an array of that class to hold the animations we will be using
	anims = SexLab.GetAnimationsByTags(1, "Masturbation")
	;fetches one-actor masturbation animations from SexLab and stores them into the array
	
	RegisterForModEvent("OrgasmEnd_ActivatedMasturbation", "ActivatedMasturbationEnd")
	;registers to catch the end of the masturbation that was started by this object
	
	SexLab.StartSex(sexActor, anims, allowBed = promptForBed, hook = "ActivatedMasturbation")
	;starts the masturbation animation for akActionRef. allowBed can be changed in CK
	;this animation will send special events containing the ActivatedMasturbation hook
	
EndEvent



Event ActivatedMasturbationEnd(string eventName, string argString, float argNum, form sender)
;when the actor has finished masturbating
	
	actor[] actorToTeleport = SexLab.HookActors(argString)
	;fetches the actor that was masturbating	
	Utility.Wait(WaitTime)
	;wait for sometime, set in the CK
	
	If (actorToTeleport[0] != playerRef)
	;if the actor is not the player
	
		actorToTeleport[0].DisableNoWait()
		;disables this actor
		actorToTeleport[0].MoveTo(Destination, XOffset, YOffset, ZOffset, MatchRotation)
		;Teleports this actor to the destination, set in the CK. Offsets and MatchRotation are set in the CK.
		actorToTeleport[0].EnableNoWait()
		;enables this actor
		actorToTeleport[0].EvaluatePackage()
		;forces this actor to re-evaluate her package
		
	Else
	;if the actor is the player
		Game.DisablePlayerControls()
		Game.SetPlayerAiDriven(True)
		actorToTeleport[0].MoveTo(Destination, XOffset, YOffset, ZOffset, MatchRotation)
		;Teleports the player to the destination, set in the CK. Offsets and MatchRotation are set in the CK.
		Game.SetPlayerAiDriven(False)
		Game.EnablePlayerControls()
	EndIf
	
	UnregisterForModEvent("OrgasmEnd_ActivatedMasturbation")
	;unregisters for this mod event as we no longer need it
	
EndEvent
