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
Bool IsWAFInstalled
Int GroupID
Int EntryID
Int i
Int Level = EvaenneRef.GetLevel()

SetIntValue(None, "APPS.KeyMap.DynamicInteractions", -1)
;Look up for supported mods
If(Game.GetModByName("Weapons & Armor_TrueOrcish&DaedricWeapons.esp") != 255)
	IsWAFInstalled = True
EndIf

;Create sexuality stats for BrenuinBeggerRef the beggar
If(!SexLab.Stats.HadSex(BrenuinBeggerRef))
	Int Anal = Utility.RandomInt(20, 45)
	Int Oral = Utility.RandomInt(60, 100)
	SexLab.Stats.SetInt(BrenuinBeggerRef, "Anal", Anal)
	SexLab.Stats.SetInt(BrenuinBeggerRef, "Vaginal", 0)
	SexLab.Stats.SetInt(BrenuinBeggerRef, "Oral", Oral)
	SexLab.Stats.SetInt(BrenuinBeggerRef, "Males", Anal + Oral)
	FormListAdd(None, "SexLab.SkilledActors", BrenuinBeggerRef, False)
EndIf

;Set synchronization mode for Hulda specifically
RS.SetSyncMode(Self, HuldaRef, 3)

HuldaRef.SetFactionRank(HuldaFamilyFaction, 4)
PlayerRef.SetFactionRank(HuldaFamilyFaction, 0)

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
	FormListSlice(EvaenneRef, OUTFIT_LVL_01, ArmorList)
	EvaenneRef.EquipItem(EvaenneBowLvl01)
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

i = 0

Debug.MessageBox("FormList length: " + ArmorList.Length)

While(i < ArmorList.Length)
	Debug.MessageBox(ArmorList[i].GetName())

	i += 1
EndWhile

EvaenneRef.SetOutfit(OutfitFactory.CreateOutfit(ArmorList))
;Taskplaner stuff
IntListAdd(None, "APPS.Evaenne.Tasks.Stage0", 0)
IntListAdd(None, "APPS.Evaenne.Tasks.Stage0", 1)
IntListAdd(None, "APPS.Evaenne.ExcludedTasks", 1001)
;Setting up the rooms in the Drunken Huntsman basement
SetFormValue(Room1BedDH, "APPS.DrunkenHuntsman.RoomGuest", BrenuinBeggerRef)
SetFormValue(Room3BedDH, "APPS.DrunkenHuntsman.RoomGuest", EvaenneRef)
;Other stuff for Evaenne
SetFormValue(WhiterunBanneredMareLocation, "APPS.FFQ001Helper", FFQ001_BM)
SetFormValue(EvaenneRef, "APPS.Framework.Relationship.FavoriteInn", WhiterunBanneredMareLocation)
SetFormValue(EvaenneRef, "APPS.Framework.Relationship.FavoriteChair", FavoriteChair)
;Interactive menu
SetIntValue(None, "APPS.Menu.IsActive", 1)

;Evaenne quests
Domina.Start()
DominaSD.Start()
EvaenneQuest.Start()
DynamicInteractions.Start()

;Creating entries for the wheel menu
GroupID = (DynamicInteractions As APPS_DI_Functions).AddMenuGroup("Entkleiden", "Entkleiden")

If(GroupID > 0)
	StringListAdd(None, "APPS.Settings.MenuGroup", "Entkleiden")
	IntListAdd(None, "APPS.Settings.MenuGroup", GroupID)

	EntryID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry(GroupID, "Ein Teil", "Ein Teil")

	If(EntryID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Entkleiden", EntryID)
		StringListAdd(None, "APPS.Settings.MenuGroups.Entry.Callbacks.Entkleiden", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack(GroupID, EntryID, "Strip"))
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt(GroupID, EntryID, 0)
	EndIf

	EntryID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry(GroupID, "Alles", "Alles")

	If(EntryID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Entkleiden", EntryID)
		StringListAdd(None, "APPS.Settings.MenuGroup.Entry.Callbacks.Entkleiden", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack(GroupID, EntryID, "Strip"))
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt(GroupID, EntryID, 1)
	EndIf
EndIf

GroupID = (DynamicInteractions As APPS_DI_Functions).AddMenuGroup("Tanzen", "Tanzen")

If(GroupID > 0)
	EntryID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry(GroupID, "Tanz 1", "Tanz 1")

	If(EntryID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Tanzen", EntryID)
		StringListAdd(None, "APPS.Settings.MenuGroups.Entry.Callbacks.Tanzen", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack(GroupID, EntryID, "Dance"))
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt(GroupID, EntryID, 1)
	EndIf

	EntryID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry(GroupID, "Tanz 2", "Tanz 2", False)

	If(EntryID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Tanzen", EntryID)
		StringListAdd(None, "APPS.Settings.MenuGroups.Entry.Callbacks.Tanzen", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack(GroupID, EntryID, "Dance"))
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt(GroupID, EntryID, 2)
	EndIf

	EntryID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry(GroupID, "Tanz 3", "Tanz 3", False)

	If(EntryID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Tanzen", EntryID)
		StringListAdd(None, "APPS.Settings.MenuGroups.Entry.Callbacks.Tanzen", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack(GroupID, EntryID, "Dance"))
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt(GroupID, EntryID, 3)
	EndIf

	EntryID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry(GroupID, "Tanz 4", "Tanz 4", False)

	If(EntryID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Tanzen", EntryID)
		StringListAdd(None, "APPS.Settings.MenuGroups.Entry.Callbacks.Tanzen", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack(GroupID, EntryID, "Dance"))
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt(GroupID, EntryID, 4)
	EndIf

	EntryID = (DynamicInteractions As APPS_DI_Functions).AddMenuEntry(GroupID, "Tanz 5", "Tanz 5", False)

	If(EntryID > 0)
		IntListAdd(None, "APPS.Settings.MenuGroup.Entry.Tanzen", EntryID)
		StringListAdd(None, "APPS.Settings.MenuGroups.Entry.Callbacks.Tanzen", (DynamicInteractions As APPS_DI_Functions).AddMenuEntryCallBack(GroupID, EntryID, "Dance"))
		(DynamicInteractions As APPS_DI_Functions).AddCallbackParameterInt(GroupID, EntryID, 5)
	EndIf
EndIf

;Setting up dance marker positions
SetFormValue(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.Tavern", WhiterunBanneredMareLocation)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions1", -400.8570)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions1", -95.0365)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions1", 64.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions1", 0.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions1", 0.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions1", 166.1584)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions2", -203.0190)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions2", -558.5507)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions2", 64.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions2", 0.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions2", 0.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions2", 166.1578)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions3", -43.8266)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions3", -569.7546)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions3", 64.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions3", 0.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions3", 0.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions3", -159.4639)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions4", -128.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions4", 64.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions4", -896.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions4", 0.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions4", 0.0000)
FloatListAdd(WhiterunBanneredMareLocation, "APPS.SQ01.Dance.MarkerPositions4", 69.7188)
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

Actor Property BrenuinBeggerRef Auto
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
Location Property WhiterunBanneredMareLocation Auto
ObjectReference Property FavoriteChair Auto
ObjectReference Property Room1BedDH Auto
ObjectReference Property Room3BedDH Auto
Quest Property FFQ001_BM Auto
Quest Property Domina Auto
Quest Property DominaSD Auto
Quest Property DynamicInteractions Auto
Quest Property EvaenneQuest Auto
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
