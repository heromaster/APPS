Scriptname APPS_FollowerMonitor_Functions extends Quest Conditional
Actor Property PlayerRef Auto
Quest Property Follower Auto
ReferenceAlias Property Alias_Follower Auto

Int PosHistorySize = 8 ; remember to update the declarations if necessary
Float[] PlayerPosX
Float[] PlayerPosY
Float[] PlayerPosZ
Int UpdateInterval = 1
Float PlayerIdleRadius = 150.0

Event OnUpdate()
	Int i = 0
	Actor CurrentFollower = Alias_Follower.GetActorRef()

	If(CurrentFollower.GetCurrentScene() || CurrentFollower.IsInDialogueWithPlayer())
		RegisterForSingleUpdate(UpdateInterval)
		Return
	EndIf

	While (i < PosHistorySize - 1)
		PlayerPosX[i] = PlayerPosX[i + 1]
		PlayerPosY[i] = PlayerPosY[i + 1]
		PlayerPosZ[i] = PlayerPosZ[i + 1]

		i += 1
	EndWhile
	
	PlayerPosX[PosHistorySize - 1] = PlayerRef.X
	PlayerPosY[PosHistorySize - 1] = PlayerRef.Y
	PlayerPosZ[PosHistorySize - 1] = PlayerRef.Z

	If((Follower As APPS_Follower_Functions).IsFollowing)
		Bool IsPackageConditionsSwitched = False

		If(!(Follower As APPS_Follower_Functions).IsWillingToWait && CurrentFollower.GetActorValue("WaitingForPlayer") != 0)
			CurrentFollower.SetActorValue("WaitingForPlayer", 0)
			IsPackageConditionsSwitched = True
		EndIf

		Float FactorX = PlayerPosX[0] - PlayerRef.X
		Float FactorY = PlayerPosY[0] - PlayerRef.Y
		Float FactorZ = PlayerPosZ[0] - PlayerRef.Z
		FactorX = FactorX * FactorX
		FactorY = FactorY * FactorY
		FactorZ = FactorZ * FactorZ

		Float Distance = Math.sqrt(FactorX + FactorY + FactorZ)

		If(Distance > PlayerIdleRadius)
			If((Follower As APPS_Follower_Functions).IsPlayerIdles)
				IsPackageConditionsSwitched = True
			EndIf

			(Follower As APPS_Follower_Functions).IsPlayerIdles = False
		Else
			If(!(Follower As APPS_Follower_Functions).IsPlayerIdles)
				IsPackageConditionsSwitched = True
			EndIf

			(Follower As APPS_Follower_Functions).IsPlayerIdles = True
		Endif

		If(IsPackageConditionsSwitched)
			CurrentFollower.EvaluatePackage()
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
	Int i = 0

	While (i < PlayerPosX.Length)
		PlayerPosX[i] = PlayerRef.X + 1000
		PlayerPosY[i] = PlayerRef.Y + 1000
		PlayerPosZ[i] = PlayerRef.Z + 1000
		i += 1
	EndWhile

	RegisterForSingleUpdate(UpdateInterval)
EndFunction