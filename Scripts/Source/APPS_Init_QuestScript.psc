;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname APPS_Init_QuestScript Extends APPS_FW_Registrar Hidden
Import StorageUtil

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
RegisterMod()
RegisterInitQuest(Self, 10)
RegisterForExceptionModule("APPS")
RegisterForRelationshipModule()
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

;/
Bool IsDLC1Active = Quest.GetQuest("DLC1Init")
Bool IsDLC2Active = Quest.GetQuest("DLC2Init")
Bool IsDLC3Active = Quest.GetQuest("BYOHHouseBanditAttack")

FormListAdd(None, FOLLOWERS_VANILLA, Brelyna)
FormListAdd(None, FOLLOWERS_VANILLA, Jzargo)
FormListAdd(None, FOLLOWERS_VANILLA, Onmund)
FormListAdd(None, FOLLOWERS_VANILLA, Aela)
FormListAdd(None, FOLLOWERS_VANILLA, Athis)
FormListAdd(None, FOLLOWERS_VANILLA, Farkas)
FormListAdd(None, FOLLOWERS_VANILLA, Njada)
FormListAdd(None, FOLLOWERS_VANILLA, Ria)
FormListAdd(None, FOLLOWERS_VANILLA, Torvar)
FormListAdd(None, FOLLOWERS_VANILLA, Vilkas)
FormListAdd(None, FOLLOWERS_SPECIAL, Cicero)
FormListAdd(None, FOLLOWERS_SPECIAL, DBInitiateF)
FormListAdd(None, FOLLOWERS_SPECIAL, DBInitiateM)
FormListAdd(None, FOLLOWERS_VANILLA, Erandur)
FormListAdd(None, FOLLOWERS_VANILLA, Golldir)
FormListAdd(None, FOLLOWERS_VANILLA, Illia)
FormListAdd(None, FOLLOWERS_VANILLA, Belrand)
FormListAdd(None, FOLLOWERS_VANILLA, Erik)
FormListAdd(None, FOLLOWERS_VANILLA, Jenassa)
FormListAdd(None, FOLLOWERS_VANILLA, Marcurio)
FormListAdd(None, FOLLOWERS_VANILLA, Stenvar)
FormListAdd(None, FOLLOWERS_VANILLA, Vorstag)
FormListAdd(None, FOLLOWERS_VANILLA, Argis)
FormListAdd(None, FOLLOWERS_VANILLA, Calder)
FormListAdd(None, FOLLOWERS_VANILLA, Iona)
FormListAdd(None, FOLLOWERS_VANILLA, Jordis)
FormListAdd(None, FOLLOWERS_VANILLA, Lydia)
FormListAdd(None, FOLLOWERS_VANILLA, Borgakh)
FormListAdd(None, FOLLOWERS_VANILLA, Ghorbash)
FormListAdd(None, FOLLOWERS_VANILLA, Lob)
FormListAdd(None, FOLLOWERS_VANILLA, Ogol)
FormListAdd(None, FOLLOWERS_VANILLA, Ugor)
FormListAdd(None, FOLLOWERS_VANILLA, Adelaisa)
FormListAdd(None, FOLLOWERS_VANILLA, Ahtar)
FormListAdd(None, FOLLOWERS_VANILLA, Annekke)
FormListAdd(None, FOLLOWERS_VANILLA, Aranea)
FormListAdd(None, FOLLOWERS_VANILLA, Benor)
FormListAdd(None, FOLLOWERS_VANILLA, Cosnach)
FormListAdd(None, FOLLOWERS_VANILLA, Derkeethus)
FormListAdd(None, FOLLOWERS_VANILLA, Eola)
FormListAdd(None, FOLLOWERS_VANILLA, Faendal)
FormListAdd(None, FOLLOWERS_VANILLA, Kharjo)
FormListAdd(None, FOLLOWERS_VANILLA, Mjoll)
FormListAdd(None, FOLLOWERS_VANILLA, Roggi)
FormListAdd(None, FOLLOWERS_VANILLA, Sven)
FormListAdd(None, FOLLOWERS_VANILLA, Uthgerd)

If(IsDLC1Active)
	FormListAdd(None, FOLLOWERS_SPECIAL, Game.GetFormFromFile(0x2B6C, "Dawnguard.esm")) ;Serana
	FormListAdd(None, FOLLOWERS_DLC1, Game.GetFormFromFile(0x336E, "Dawnguard.esm")) ;Agmaer
	FormListAdd(None, FOLLOWERS_DLC1, Game.GetFormFromFile(0x1541B, "Dawnguard.esm")) ;Ingjard
	FormListAdd(None, FOLLOWERS_DLC1, Game.GetFormFromFile(0x1541C, "Dawnguard.esm")) ;Beleval
	FormListAdd(None, FOLLOWERS_DLC1, Game.GetFormFromFile(0x1541D, "Dawnguard.esm")) ;Durak
	FormListAdd(None, FOLLOWERS_DLC1, Game.GetFormFromFile(0x1541E, "Dawnguard.esm")) ;Celann
EndIf

If(IsDLC2Active)
	FormListAdd(None, FOLLOWERS_DLC2, Game.GetFormFromFile(0x17777, "Dragonborn.esm")) ;Talvas
	FormListAdd(None, FOLLOWERS_DLC2, Game.GetFormFromFile(0x17934, "Dragonborn.esm")) ;Frea
	FormListAdd(None, FOLLOWERS_DLC2, Game.GetFormFromFile(0x179C7, "Dragonborn.esm")) ;Ralis
	FormListAdd(None, FOLLOWERS_DLC2, Game.GetFormFromFile(0x38560, "Dragonborn.esm")) ;Teldryn
EndIf

If(IsDLC3Active)
	FormListAdd(None, FOLLOWERS_DLC3, Game.GetFormFromFile(0x5215, "HearthFires.esm")) ;Gregor
	FormListAdd(None, FOLLOWERS_DLC3, Game.GetFormFromFile(0x521B, "HearthFires.esm")) ;Rayya
	FormListAdd(None, FOLLOWERS_DLC3, Game.GetFormFromFile(0x521E, "HearthFires.esm")) ;Valdimar
EndIf
/;
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SexLabFramework Property SexLab Auto

;/
Actor Property Adelaisa Auto
Actor Property Aela Auto
Actor Property Ahtar Auto
Actor Property Annekke Auto
Actor Property Aranea Auto
Actor Property Argis Auto
Actor Property Athis Auto
Actor Property Belrand Auto
Actor Property Benor Auto
Actor Property Borgakh Auto
Actor Property Brelyna Auto
/;
Actor Property Brenuin Auto
;/
Actor Property Calder Auto
Actor Property Cicero Auto
Actor Property Cosnach Auto
Actor Property DBInitiateF Auto
Actor Property DBInitiateM Auto
Actor Property Derkeethus Auto
Actor Property Eola Auto
Actor Property Erandur Auto
Actor Property Erik Auto
Actor Property Faendal Auto
Actor Property Farkas Auto
Actor Property Ghorbash Auto
Actor Property Golldir Auto
Actor Property Illia Auto
Actor Property Iona Auto
Actor Property Jenassa Auto
Actor Property Jordis Auto
Actor Property Jzargo Auto
Actor Property Kharjo Auto
Actor Property Lob Auto
Actor Property Lydia Auto
Actor Property Marcurio Auto
Actor Property Mjoll Auto
Actor Property Njada Auto
Actor Property Ogol Auto
Actor Property Onmund Auto
Actor Property Ria Auto
Actor Property Roggi Auto
Actor Property Stenvar Auto
Actor Property Sven Auto
Actor Property Torvar Auto
Actor Property Ugor Auto
Actor Property Uthgerd Auto
Actor Property Vilkas Auto
Actor Property Vorstag Auto

String Property FOLLOWERS_DLC1 = "APPS.SupportedFollowers.Dawnguard" AutoReadOnly Hidden
String Property FOLLOWERS_DLC2 = "APPS.SupportedFollowers.Dragonborn" AutoReadOnly Hidden
String Property FOLLOWERS_DLC3 = "APPS.SupportedFollowers.HearthFires" AutoReadOnly Hidden
String Property FOLLOWERS_SPECIAL = "APPS.SupportedFollowers.Special" AutoReadOnly Hidden
String Property FOLLOWERS_VANILLA = "APPS.SupportedFollowers.Vanilla" AutoReadOnly Hidden
/;