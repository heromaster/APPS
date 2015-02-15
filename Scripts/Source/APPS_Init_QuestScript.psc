;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_Init_QuestScript Extends APPS_FW_Registrar Hidden

;BEGIN ALIAS PROPERTY PC
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PC Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
RegisterMod()
RegisterInitQuest(Self, 10)
RegisterForExceptionModule("APPS")
RegisterForRelationshipModule()
SetInfoHandling(True, False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
If(!SexLab.Stats.HadSex(Brenuin))
	Int Anal = Utility.RandomInt(20, 45)
	Int Oral = Utility.RandomInt(60, 100)
	SexLab.Stats.SetInt(Brenuin, "Anal", Anal)
	SexLab.Stats.SetInt(Brenuin, "Vaginal", 0)
	SexLab.Stats.SetInt(Brenuin, "Oral", Oral)
	SexLab.Stats.SetInt(Brenuin, "Males", Anal + Oral)
EndIf

RS.SetSyncMode(Self, HuldaRef, 3)

StorageUtil.IntListAdd(EvaenneRef, "APPS.Follower.Armors", 1)
StorageUtil.IntListAdd(EvaenneRef, "APPS.Follower.Armors", 4)
StorageUtil.IntListAdd(EvaenneRef, "APPS.Follower.Armors", 9)
StorageUtil.IntListAdd(EvaenneRef, "APPS.Follower.Armors", 12)
StorageUtil.IntListAdd(EvaenneRef, "APPS.Follower.Armors", 19)
StorageUtil.IntListAdd(EvaenneRef, "APPS.Follower.Armors", 27)
StorageUtil.IntListAdd(EvaenneRef, "APPS.Follower.Armors", 36)
StorageUtil.IntListAdd(EvaenneRef, "APPS.Follower.Armors", 46)
StorageUtil.IntListAdd(EvaenneRef, "APPS.Follower.Armors", 56)
StorageUtil.FormListAdd(EvaenneRef, "APPS.Follower.Armors", Lvl1Outfit)
StorageUtil.FormListAdd(EvaenneRef, "APPS.Follower.Armors", Lvl4Outfit)
StorageUtil.FormListAdd(EvaenneRef, "APPS.Follower.Armors", Lvl9Outfit)
StorageUtil.FormListAdd(EvaenneRef, "APPS.Follower.Armors", Lvl12Outfit)
StorageUtil.FormListAdd(EvaenneRef, "APPS.Follower.Armors", Lvl19Outfit)
StorageUtil.FormListAdd(EvaenneRef, "APPS.Follower.Armors", Lvl27Outfit)
StorageUtil.FormListAdd(EvaenneRef, "APPS.Follower.Armors", Lvl36Outfit)
StorageUtil.FormListAdd(EvaenneRef, "APPS.Follower.Armors", Lvl46Outfit)
StorageUtil.FormListAdd(EvaenneRef, "APPS.Follower.Armors", Lvl56Outfit)
StorageUtil.IntListAdd(None, "APPS.Follower.Tasks.Stage0", 0)
StorageUtil.IntListAdd(None, "APPS.Follower.Tasks.Stage0", 1)
StorageUtil.IntListAdd(None, "APPS.Follower.ExcludedTasks", 1001)
StorageUtil.SetFormValue(Room1BedDH, "APPS.DrunkenHuntsman.RoomGuest", Brenuin)
StorageUtil.SetFormValue(Room3BedDH, "APPS.DrunkenHuntsman.RoomGuest", EvaenneRef)
StorageUtil.SetFormValue(BanneredMare, "APPS.FFQ001Helper", BanneredMareHelper)
StorageUtil.SetFormValue(EvaenneRef, "APPS.Framework.Relationship.FavoriteInn", BanneredMare)
StorageUtil.SetFormValue(EvaenneRef, "APPS.Framework.Relationship.FavoriteChair", FavoriteChair)

Domina.Start()
DominaSD.Start()
EvaenneQuest.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SexLabFramework Property SexLab Auto
APPS_FW_Relationship Property RS Auto

Actor Property HuldaRef Auto
Actor Property Brenuin Auto
Actor Property EvaenneRef Auto
Location Property BanneredMare Auto
ObjectReference Property FavoriteChair Auto
ObjectReference Property Room1BedDH Auto
ObjectReference Property Room3BedDH Auto
Outfit Property Lvl1Outfit Auto
Outfit Property Lvl4Outfit Auto
Outfit Property Lvl9Outfit Auto
Outfit Property Lvl12Outfit Auto
Outfit Property Lvl19Outfit Auto
Outfit Property Lvl27Outfit Auto
Outfit Property Lvl36Outfit Auto
Outfit Property Lvl46Outfit Auto
Outfit Property Lvl56Outfit Auto
Quest Property BanneredMareHelper Auto
Quest Property Domina Auto
Quest Property DominaSD Auto
Quest Property EvaenneQuest Auto