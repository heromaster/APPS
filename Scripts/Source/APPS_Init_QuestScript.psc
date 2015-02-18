;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_Init_QuestScript Extends APPS_FW_Registrar Hidden
Import StorageUtil

;BEGIN ALIAS PROPERTY PC
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PC Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;The following lines are registering the mod with the APPS Framework
RegisterMod()
RegisterInitQuest(Self, 10)
RegisterForExceptionModule("APPS")
RegisterForRelationshipModule()
SetInfoHandling(True, False) ;log to file, don't show ingame
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
;Create sexuality stats for Brenuin the beggar
If(!SexLab.Stats.HadSex(Brenuin))
	Int Anal = Utility.RandomInt(20, 45)
	Int Oral = Utility.RandomInt(60, 100)
	SexLab.Stats.SetInt(Brenuin, "Anal", Anal)
	SexLab.Stats.SetInt(Brenuin, "Vaginal", 0)
	SexLab.Stats.SetInt(Brenuin, "Oral", Oral)
	SexLab.Stats.SetInt(Brenuin, "Males", Anal + Oral)
	FormListAdd(None, "SexLab.SkilledActors", Brenuin, False)
EndIf

;Set synchronization mode for Hulda specifically
RS.SetSyncMode(Self, HuldaRef, 3)

Int Level = EvaenneRef.GetLevel()

;Create armor lists for Evaenne
If(Level < 6)
	FormListAdd(EvaenneRef, OUTFIT_LVL_01, Evaenne_EnchCirclet01)
	FormListAdd(EvaenneRef, OUTFIT_LVL_01, Evaenne_HideBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_01, Evaenne_StuddedCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_01, Evaenne_HideGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_01, Evaenne_DomRing)
EndIf

If(Level < 12)
	FormListAdd(EvaenneRef, OUTFIT_LVL_06, Evaenne_EnchCirclet02)
	FormListAdd(EvaenneRef, OUTFIT_LVL_06, Evaenne_LeatherBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_06, Evaenne_LeatherCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_06, Evaenne_LeatherGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_06, Evaenne_DomRing)
EndIf

If(Level < 19)
	FormListAdd(EvaenneRef, OUTFIT_LVL_12, Evaenne_EnchCirclet03)
	FormListAdd(EvaenneRef, OUTFIT_LVL_12, Evaenne_ElvenBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_12, Evaenne_ElvenCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_12, Evaenne_ElvenGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_12, Evaenne_DomRing)
EndIf

If(Level < 27)
	FormListAdd(EvaenneRef, OUTFIT_LVL_19, Evaenne_EnchCirclet03)
	FormListAdd(EvaenneRef, OUTFIT_LVL_19, Evaenne_ScaledBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_19, Evaenne_ScaledCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_19, Evaenne_ScaledGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_19, Evaenne_DomRing)
EndIf

If(Level < 36)
	FormListAdd(EvaenneRef, OUTFIT_LVL_27, Evaenne_EnchCirclet03)
	FormListAdd(EvaenneRef, OUTFIT_LVL_27, Evaenne_ScaledBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_27, Evaenne_ElvenGildedCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_27, Evaenne_ScaledGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_27, Evaenne_DomRing)
EndIf

If(Level < 46)
	FormListAdd(EvaenneRef, OUTFIT_LVL_36, Evaenne_EnchCirclet04)
	FormListAdd(EvaenneRef, OUTFIT_LVL_36, Evaenne_GlassBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_36, Evaenne_GlassCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_36, Evaenne_GlassGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_36, Evaenne_DomRing)
EndIf

FormListAdd(EvaenneRef, OUTFIT_LVL_46, Evaenne_EnchCirclet05)
FormListAdd(EvaenneRef, OUTFIT_LVL_46, Evaenne_DragonscaleBoots)
FormListAdd(EvaenneRef, OUTFIT_LVL_46, Evaenne_DragonscaleCuirass)
FormListAdd(EvaenneRef, OUTFIT_LVL_46, Evaenne_DragonscaleGauntlets)
FormListAdd(EvaenneRef, OUTFIT_LVL_46, Evaenne_DomRing)

;Taskplaner stuff
IntListAdd(None, "APPS.Evaenne.Tasks.Stage0", 0)
IntListAdd(None, "APPS.Evaenne.Tasks.Stage0", 1)
IntListAdd(None, "APPS.Evaenne.ExcludedTasks", 1001)
;Setting up the rooms in the Drunken Huntsman basement
SetFormValue(Room1BedDH, "APPS.DrunkenHuntsman.RoomGuest", Brenuin)
SetFormValue(Room3BedDH, "APPS.DrunkenHuntsman.RoomGuest", EvaenneRef)
;Other stuff for Evaenne
SetFormValue(BanneredMare, "APPS.FFQ001Helper", BanneredMareHelper)
SetFormValue(EvaenneRef, "APPS.Framework.Relationship.FavoriteInn", BanneredMare)
SetFormValue(EvaenneRef, "APPS.Framework.Relationship.FavoriteChair", FavoriteChair)
;Interactive menu
SetIntValue(None, "APPS.Menu.IsActive", 1)

;Evaenne quests
Domina.Start()
DominaSD.Start()
EvaenneQuest.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SexLabFramework Property SexLab Auto
APPS_FW_Relationship Property RS Auto

String Property OUTFIT_LVL_01 = "APPS.Evaenne.Armor.Level.1" AutoReadOnly Hidden
String Property OUTFIT_LVL_06 = "APPS.Evaenne.Armor.Level.6" AutoReadOnly Hidden
String Property OUTFIT_LVL_12 = "APPS.Evaenne.Armor.Level.12" AutoReadOnly Hidden
String Property OUTFIT_LVL_19 = "APPS.Evaenne.Armor.Level.19" AutoReadOnly Hidden
String Property OUTFIT_LVL_27 = "APPS.Evaenne.Armor.Level.27" AutoReadOnly Hidden
String Property OUTFIT_LVL_36 = "APPS.Evaenne.Armor.Level.36" AutoReadOnly Hidden
String Property OUTFIT_LVL_46 = "APPS.Evaenne.Armor.Level.46" AutoReadOnly Hidden

Actor Property Brenuin Auto
Actor Property EvaenneRef Auto
Actor Property HuldaRef Auto
Armor Property Evaenne_DomRing Auto
Armor Property Evaenne_DragonscaleBoots Auto
Armor Property Evaenne_DragonscaleCuirass Auto
Armor Property Evaenne_DragonscaleGauntlets Auto
Armor Property Evaenne_ElvenBoots Auto
Armor Property Evaenne_ElvenCuirass Auto
Armor Property Evaenne_ElvenGauntlets Auto
Armor Property Evaenne_ElvenGildedCuirass Auto
Armor Property Evaenne_EnchCirclet01 Auto
Armor Property Evaenne_EnchCirclet02 Auto
Armor Property Evaenne_EnchCirclet03 Auto
Armor Property Evaenne_EnchCirclet04 Auto
Armor Property Evaenne_EnchCirclet05 Auto
Armor Property Evaenne_GlassBoots Auto
Armor Property Evaenne_GlassCuirass Auto
Armor Property Evaenne_GlassGauntlets Auto
Armor Property Evaenne_HideBoots Auto
Armor Property Evaenne_HideGauntlets Auto
Armor Property Evaenne_LeatherBoots Auto
Armor Property Evaenne_LeatherCuirass Auto
Armor Property Evaenne_LeatherGauntlets Auto
Armor Property Evaenne_ScaledBoots Auto
Armor Property Evaenne_ScaledCuirass Auto
Armor Property Evaenne_ScaledGauntlets Auto
Armor Property Evaenne_StuddedCuirass Auto
Location Property BanneredMare Auto
ObjectReference Property FavoriteChair Auto
ObjectReference Property Room1BedDH Auto
ObjectReference Property Room3BedDH Auto
Quest Property BanneredMareHelper Auto
Quest Property Domina Auto
Quest Property DominaSD Auto
Quest Property EvaenneQuest Auto