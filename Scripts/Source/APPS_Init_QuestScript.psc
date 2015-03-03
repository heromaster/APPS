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
Form[] ArmorList = New Form[5]
Bool IsWAFInstalled = Game.GetFormFromFile(0xD62, "Weapons & Armor_TrueOrcish&DaedricWeapons.esp")
Int ID
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

HuldaRef.SetFactionRank(HuldaFamilyFaction, 4)
PlayerRef.SetFactionRank(HuldaFamilyFaction, 0)

Int Level = EvaenneRef.GetLevel()

;Create armor lists for Evaenne
If(Level < 6)
	FormListAdd(EvaenneRef, OUTFIT_LVL_01, EnchCirclet01)
	FormListAdd(EvaenneRef, OUTFIT_LVL_01, ArmorHideBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_01, ArmorStuddedCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_01, ArmorHideGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_01, DomRing)
EndIf

If(Level < 12)
	FormListAdd(EvaenneRef, OUTFIT_LVL_06, EnchCirclet02)
	FormListAdd(EvaenneRef, OUTFIT_LVL_06, ArmorLeatherBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_06, ArmorLeatherCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_06, ArmorLeatherGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_06, DomRing)
EndIf

If(Level < 19)
	FormListAdd(EvaenneRef, OUTFIT_LVL_12, EnchCirclet03)
	FormListAdd(EvaenneRef, OUTFIT_LVL_12, ArmorElvenBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_12, ArmorElvenCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_12, ArmorElvenGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_12, DomRing)
EndIf

If(Level < 27)
	FormListAdd(EvaenneRef, OUTFIT_LVL_19, EnchCirclet03)
	FormListAdd(EvaenneRef, OUTFIT_LVL_19, ArmorScaledBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_19, ArmorScaledCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_19, ArmorScaledGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_19, DomRing)
EndIf

If(Level < 36)
	FormListAdd(EvaenneRef, OUTFIT_LVL_27, EnchCirclet03)
	FormListAdd(EvaenneRef, OUTFIT_LVL_27, ArmorScaledBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_27, ArmorElvenGildedCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_27, ArmorScaledGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_27, DomRing)
EndIf

If(Level < 46)
	FormListAdd(EvaenneRef, OUTFIT_LVL_36, EnchCirclet04)
	FormListAdd(EvaenneRef, OUTFIT_LVL_36, ArmorGlassBoots)
	FormListAdd(EvaenneRef, OUTFIT_LVL_36, ArmorGlassCuirass)
	FormListAdd(EvaenneRef, OUTFIT_LVL_36, ArmorGlassGauntlets)
	FormListAdd(EvaenneRef, OUTFIT_LVL_36, DomRing)
EndIf

FormListAdd(EvaenneRef, OUTFIT_LVL_46, EnchCirclet05)
FormListAdd(EvaenneRef, OUTFIT_LVL_46, ArmorDragonscaleBoots)
FormListAdd(EvaenneRef, OUTFIT_LVL_46, ArmorDragonscaleCuirass)
FormListAdd(EvaenneRef, OUTFIT_LVL_46, ArmorDragonscaleGauntlets)
FormListAdd(EvaenneRef, OUTFIT_LVL_46, DomRing)
FormListAdd(EvaenneRef, CASUAL_WEAR, ClothesNighthawkTorso)
FormListAdd(EvaenneRef, CASUAL_WEAR, ClothesNighthawkBoots)
FormListAdd(EvaenneRef, CASUAL_WEAR, ClothesNighthawkGloves)
FormListAdd(EvaenneRef, CASUAL_WEAR, DomRing)

;Give Evaenne base items
If(Level < 3)
	EvaenneRef.AddItem(IronArrow, 100)
ElseIf(Level < 6)
	FormListSlice(EvaenneRef, OUTFIT_LVL_01, ArmorList)
	EvaenneRef.EquipItem(EvaenneBowLvl01)
	EvaenneRef.AddItem(SteelArrow, 100)
ElseIf(Level < 12)
	FormListSlice(EvaenneRef, OUTFIT_LVL_06, ArmorList)

	If(IsWAFInstalled)
		EvaenneRef.EquipItem(EvaenneBowLvl06_WAF)
	Else
		EvaenneRef.EquipItem(EvaenneBowLvl06)
	EndIf

	EvaenneRef.AddItem(OrcishArrow, 100)
ElseIf(Level < 19)
	FormListSlice(EvaenneRef, OUTFIT_LVL_12, ArmorList)

	If(IsWAFInstalled)
		EvaenneRef.EquipItem(EvaenneBowLvl12_WAF)
	Else
		EvaenneRef.EquipItem(EvaenneBowLvl12)
	EndIf

	EvaenneRef.AddItem(DwarvenArrow, 100)
ElseIf(Level < 27)
	FormListSlice(EvaenneRef, OUTFIT_LVL_19, ArmorList)

	If(IsWAFInstalled)
		EvaenneRef.EquipItem(EvaenneBowLvl19_WAF)
	Else
		EvaenneRef.EquipItem(EvaenneBowLvl19)
	EndIf

	EvaenneRef.AddItem(ElvenArrow, 100)
ElseIf(Level < 36)
	FormListSlice(EvaenneRef, OUTFIT_LVL_27, ArmorList)

	If(IsWAFInstalled)
		EvaenneRef.EquipItem(EvaenneBowLvl27_WAF)
	Else
		EvaenneRef.EquipItem(EvaenneBowLvl27)
	EndIf

	EvaenneRef.AddItem(GlassArrow, 100)
ElseIf(Level < 46)
	FormListSlice(EvaenneRef, OUTFIT_LVL_36, ArmorList)
	EvaenneRef.EquipItem(EvaenneBowLvl36)
	EvaenneRef.AddItem(EbonyArrow, 100)
Else
	FormListSlice(EvaenneRef, OUTFIT_LVL_46, ArmorList)

	If(IsWAFInstalled)
		EvaenneRef.EquipItem(EvaenneBowLvl46_WAF)
	Else
		EvaenneRef.EquipItem(EvaenneBowLvl46)
	EndIf

	EvaenneRef.AddItem(DaedricArrow, 100)
EndIf

EvaenneRef.SetOutfit(OutfitFactory.CreateOutfit(ArmorList))

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
DynamicInteractions.Start()

;Creating entries for the wheel menu
ID = (DynamicInteractions As APPS_DI_Functions).AddMenuGroup("Tanzen", "Tanzen")

If(ID > 0)
	StringListAdd(None, "APPS.Settings.MenuGroup", "Tanzen")
	IntListAdd(None, "APPS.Settings.MenuGroup", ID)

	ID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry("Tanzen", "Ein Teil", "Ein Teil")

	If(ID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Entkleiden", ID)
		StringListAdd(None, "APPS.Settings.MenuGroups.Entry.Callbacks.Entkleiden", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack("Tanzen", ID, "StripOnePart"))
	EndIf

	ID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry("Tanzen", "Alles", "Alles")

	If(ID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Entkleiden", ID)
		StringListAdd(None, "APPS.Settings.MenuGroup.Entry.Callbacks.Entkleiden", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack("Tanzen", ID, "StripAll"))
	EndIf
EndIf

ID = (DynamicInteractions As APPS_DI_Functions).AddMenuGroup("Tanzen", "Tanzen")

If(ID > 0)
	ID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry("Tanzen", "Tanz 1", "Tanz 1")

	If(ID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Tanzen", ID)
		StringListAdd(None, "APPS.Settings.MenuGroups.Entry.Callbacks.Tanzen", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack("Tanzen", ID, "Dance"))
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt("Tanzen", ID, 1)
	EndIf

	ID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry("Tanzen", "Tanz 2", "Tanz 2", False)

	If(ID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Tanzen", ID)
		StringListAdd(None, "APPS.Settings.MenuGroups.Entry.Callbacks.Tanzen", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack("Tanzen", ID, "Dance"))
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt("Tanzen", ID, 2)
	EndIf

	ID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry("Tanzen", "Tanz 3", "Tanz 3", False)

	If(ID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Tanzen", ID)
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt("Tanzen", ID, 3)
	EndIf

	ID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry("Tanzen", "Tanz 4", "Tanz 4", False)

	If(ID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Tanzen", ID)
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt("Tanzen", ID, 4)
	EndIf

	ID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry("Tanzen", "Tanz 5", "Tanz 5", False)

	If(ID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Tanzen", ID)
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt("Tanzen", ID, 5)
	EndIf
EndIf
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
String Property CASUAL_WEAR =  "APPS.Evaenne.Armor.CasualWear" AutoReadOnly Hidden

Actor Property Brenuin Auto
Actor Property EvaenneRef Auto
Actor Property HuldaRef Auto
Actor Property PlayerRef Auto
Ammo Property DaedricArrow Auto
Ammo Property DwarvenArrow Auto
Ammo Property EbonyArrow Auto
Ammo Property ElvenArrow Auto
Ammo Property GlassArrow Auto
Ammo Property IronArrow Auto
Ammo Property OrcishArrow Auto
Ammo Property SteelArrow Auto
Armor Property ArmorDragonscaleBoots Auto
Armor Property ArmorDragonscaleCuirass Auto
Armor Property ArmorDragonscaleGauntlets Auto
Armor Property ArmorElvenBoots Auto
Armor Property ArmorElvenCuirass Auto
Armor Property ArmorElvenGauntlets Auto
Armor Property ArmorElvenGildedCuirass Auto
Armor Property ArmorGlassBoots Auto
Armor Property ArmorGlassCuirass Auto
Armor Property ArmorGlassGauntlets Auto
Armor Property ArmorHideBoots Auto
Armor Property ArmorHideGauntlets Auto
Armor Property ArmorLeatherBoots Auto
Armor Property ArmorLeatherCuirass Auto
Armor Property ArmorLeatherGauntlets Auto
Armor Property ArmorScaledBoots Auto
Armor Property ArmorScaledCuirass Auto
Armor Property ArmorScaledGauntlets Auto
Armor Property ArmorStuddedCuirass Auto
Armor Property ClothesNighthawkTorso Auto
Armor Property ClothesNighthawkBoots Auto
Armor Property ClothesNighthawkGloves Auto
Armor Property DomRing Auto
Armor Property EnchCirclet01 Auto
Armor Property EnchCirclet02 Auto
Armor Property EnchCirclet03 Auto
Armor Property EnchCirclet04 Auto
Armor Property EnchCirclet05 Auto
Faction Property HuldaFamilyFaction Auto
Location Property BanneredMare Auto
ObjectReference Property FavoriteChair Auto
ObjectReference Property Room1BedDH Auto
ObjectReference Property Room3BedDH Auto
Quest Property BanneredMareHelper Auto
Quest Property Domina Auto
Quest Property DominaSD Auto
Quest Property DynamicInteractions Auto
Quest Property EvaenneQuest Auto
ReferenceAlias Property Table1 Auto
Weapon Property EvaenneBowLvl01 Auto
Weapon Property EvaenneBowLvl06 Auto
Weapon Property EvaenneBowLvl06_WAF Auto
Weapon Property EvaenneBowLvl12 Auto
Weapon Property EvaenneBowLvl12_WAF Auto
Weapon Property EvaenneBowLvl19 Auto
Weapon Property EvaenneBowLvl19_WAF Auto
Weapon Property EvaenneBowLvl27 Auto
Weapon Property EvaenneBowLvl27_WAF Auto
Weapon Property EvaenneBowLvl36 Auto
Weapon Property EvaenneBowLvl46 Auto
Weapon Property EvaenneBowLvl46_WAF Auto
