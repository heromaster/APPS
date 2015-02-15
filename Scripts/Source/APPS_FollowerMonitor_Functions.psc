Scriptname APPS_FollowerMonitor_Functions extends Quest Conditional
APPS_Follower_Functions Property FollowerFunctions Auto
ReferenceAlias Property Alias_PC Auto
ReferenceAlias Property Alias_Follower Auto

Int PosHistorySize = 8 ; remember to update the declarations if necessary
Float[] PlayerPosX
Float[] PlayerPosY
Float[] PlayerPosZ
Int UpdateInterval = 1
Float PlayerIdleRadius = 150.0

Event OnUpdate()
	Int i = 0
	Actor PC = Alias_PC.GetActorRef()
	Actor Follower = Alias_Follower.GetActorRef()

	If(Follower.GetCurrentScene() != None || Follower.IsInDialogueWithPlayer())
		RegisterForSingleUpdate(UpdateInterval)
		Return
	EndIf

	While (i < PosHistorySize - 1)
		PlayerPosX[i] = PlayerPosX[i + 1]
		PlayerPosY[i] = PlayerPosY[i + 1]
		PlayerPosZ[i] = PlayerPosZ[i + 1]

		i += 1
	EndWhile
	
	PlayerPosX[PosHistorySize - 1] = PC.X
	PlayerPosY[PosHistorySize - 1] = PC.Y
	PlayerPosZ[PosHistorySize - 1] = PC.Z

	If(FollowerFunctions.IsFollowing)
		Bool IsPackageConditionsSwitched = False

		If(!FollowerFunctions.IsWillingToWait && Follower.GetActorValue("WaitingForPlayer") != 0)
			Follower.SetActorValue("WaitingForPlayer", 0)
			IsPackageConditionsSwitched = True
		EndIf

		Float FactorX = PlayerPosX[0] - PC.X
		Float FactorY = PlayerPosY[0] - PC.Y
		Float FactorZ = PlayerPosZ[0] - PC.Z
		FactorX = FactorX * FactorX
		FactorY = FactorY * FactorY
		FactorZ = FactorZ * FactorZ

		Float Distance = Math.sqrt(FactorX + FactorY + FactorZ)

		If(Distance > PlayerIdleRadius)
			If(FollowerFunctions.IsPlayerIdles)
				IsPackageConditionsSwitched = True
			EndIf

			FollowerFunctions.IsPlayerIdles = False
		Else
			If(FollowerFunctions.IsPlayerIdles == False)
				IsPackageConditionsSwitched = True
			EndIf

			FollowerFunctions.IsPlayerIdles = True
		Endif

		If(IsPackageConditionsSwitched)
			Follower.EvaluatePackage()
		EndIf
	EndIf

	If(!Self.IsStopping() || !Self.IsStopped())
		RegisterForSingleUpdate(UpdateInterval)
	EndIf
EndEvent

Function Setup()
	PlayerPosX = New float[8]
	PlayerPosY = New float[8]
	PlayerPosZ = New float[8]
	Actor PC = Alias_PC.GetActorRef()
	Int i = 0

	While (i < PlayerPosX.Length)
		PlayerPosX[i] = PC.X + 1000
		PlayerPosY[i] = PC.Y + 1000
		PlayerPosZ[i] = PC.Z + 1000
		i += 1
	EndWhile

	RegisterForSingleUpdate(UpdateInterval)
EndFunction