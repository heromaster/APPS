;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname APPS_FFQ03_QuestScript Extends Quest Hidden

;BEGIN ALIAS PROPERTY Hireling
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Hireling Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PC
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PC Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE APPS_FFQ03_Functions
Quest __temp = self as Quest
APPS_FFQ03_Functions kmyQuest = __temp as APPS_FFQ03_Functions
;END AUTOCAST
;BEGIN CODE
Int i = 0
kmyQuest.IsActorNearPlayer = False

While(i < 8)
	Actor NPC =  Game.FindRandomActorFromRef(Game.GetPlayer(), 800)

	If(NPC != Alias_PC.GetActorRef() && NPC != Alias_Hireling.GetActorRef())
		kmyQuest.IsActorNearPlayer = True
		i = 8
		Debug.MessageBox(NPC.GetBaseObject().GetName())
	EndIf

	i += 1
EndWhile

Debug.MessageBox(kmyQuest.IsActorNearPlayer)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
