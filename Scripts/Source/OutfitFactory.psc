ScriptName OutfitFactory hidden

; creates an outfit based on the form array - only armor will be copied, none objects will be skipped.
; returns none if the form array did not contain any valid armor
Outfit Function CreateOutfit(Form[] formArray) global native

; creates an outfit based on the actor's equipped armor - weapons will be skipped
; returns none if the actor has not equipped any valid armor.
Outfit Function CreateOutfitFromActor(Actor theActor) global native
