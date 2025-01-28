Route15Gate2F_Script:
	jp DisableAutoTextBoxDrawing

Route15Gate2F_TextPointers:
	def_text_pointers
	dw_const Route15Gate2FOaksAideText,   TEXT_ROUTE15GATE2F_OAKS_AIDE
	dw_const Route15Gate2FBinocularsText, TEXT_ROUTE15GATE2F_BINOCULARS

Route15Gate2FOaksAideText:
	text_asm
	CheckEvent EVENT_GOT_EXP_ALL
	jr nz, .got_item
	ld a, 50
	ldh [hOaksAideRequirement], a
	ld a, EXP_ALL
	ldh [hOaksAideRewardItem], a
	ld [wNamedObjectIndex], a
	call GetItemName
	ld hl, wNameBuffer
	ld de, wOaksAideRewardItemName
	ld bc, ITEM_NAME_LENGTH
	call CopyData
	predef OaksAideScript
	ldh a, [hOaksAideResult]
	cp OAKS_AIDE_GOT_ITEM
	jr nz, .no_item
	SetEvent EVENT_GOT_EXP_ALL
.got_item
	ld hl, .ExpAllText
	call PrintText
.no_item
	jp TextScriptEnd

.ExpAllText:
	text "がくしゅうそうちは"
	line "たたかわない　#も"
	cont "けいけんちが　もらえます"

	para "でも　１ぴき　あたりの"
	line "わけまえが　すくなく　なるので"
	cont "つかいたくない　ときは"
	cont "<PC>に　あずけて　ください"
	cont "そうちは　どうさ　しません"
	done

Route15Gate2FBinocularsText:
	text_asm
	ld hl, .Text
	jp GateUpstairsScript_PrintIfFacingUp

.Text:
	text "ぼうえんきょうを　のぞいた！"

	para "うみの　むこうに<⋯>"
	line "ちいさな　しまが　みえる！"
	done
