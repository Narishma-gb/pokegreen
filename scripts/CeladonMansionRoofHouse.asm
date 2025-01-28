CeladonMansionRoofHouse_Script:
	jp EnableAutoTextBoxDrawing

CeladonMansionRoofHouse_TextPointers:
	def_text_pointers
	dw_const CeladonMansionRoofHouseHikerText,         TEXT_CELADONMANSION_ROOF_HOUSE_HIKER
	dw_const CeladonMansionRoofHouseEeveePokeballText, TEXT_CELADONMANSION_ROOF_HOUSE_EEVEE_POKEBALL

CeladonMansionRoofHouseHikerText:
	text "こくばんにも　かいたが<⋯>"
	line "わしに　わからぬ　ことは　ない"
	cont "ゲームボーイの　なかに"
	cont "せかいが　あることも！"

	para "ぜひ！　ともだちを　さそって"
	line "#の　こうかんを"
	cont "たのしんで　くれたまえ！"
	done

CeladonMansionRoofHouseEeveePokeballText:
	text_asm
	lb bc, EEVEE, 25
	call GivePokemon
	jr nc, .party_full
	ld a, HS_CELADON_MANSION_EEVEE_GIFT
	ld [wMissableObjectIndex], a
	predef HideObject
.party_full
	jp TextScriptEnd
