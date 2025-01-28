Route11Gate2F_Script:
	jp DisableAutoTextBoxDrawing

Route11Gate2F_TextPointers:
	def_text_pointers
	dw_const Route11Gate2FYoungsterText,       TEXT_ROUTE11GATE2F_YOUNGSTER
	dw_const Route11Gate2FOaksAideText,        TEXT_ROUTE11GATE2F_OAKS_AIDE
	dw_const Route11Gate2FLeftBinocularsText,  TEXT_ROUTE11GATE2F_LEFT_BINOCULARS
	dw_const Route11Gate2FRightBinocularsText, TEXT_ROUTE11GATE2F_RIGHT_BINOCULARS

Route11Gate2FYoungsterText:
	text_asm
	xor a ; TRADE_FOR_TERRY
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
Route11Gate2FScriptEnd:
	jp TextScriptEnd

Route11Gate2FOaksAideText:
	text_asm
	CheckEvent EVENT_GOT_ITEMFINDER, 1
	jr c, .got_item
	ld a, 30
	ldh [hOaksAideRequirement], a
	ld a, ITEMFINDER
	ldh [hOaksAideRewardItem], a
	ld [wNamedObjectIndex], a
	call GetItemName
	ld h, d
	ld l, e
	ld de, wOaksAideRewardItemName
	ld bc, ITEM_NAME_LENGTH
	call CopyData
	predef OaksAideScript
	ldh a, [hOaksAideResult]
	dec a ; OAKS_AIDE_GOT_ITEM?
	jr nz, .no_item
	SetEvent EVENT_GOT_ITEMFINDER
.got_item
	ld hl, .ItemfinderDescriptionText
	call PrintText
.no_item
	jr Route11Gate2FScriptEnd

.ItemfinderDescriptionText:
	text "めに　みえて　なくても"
	line "べんりな　どうぐが"
	cont "あちこちに　おちて　います！"

	para "ダウジング　マシンで"
	line "ちかくに　なにか　おちてるか"
	cont "どうかが　わかります！"

	para "くわしい　ばしょは"
	line "マシンでも　わかりません！"
	cont "ちかくを　さがして　みて　ください"
	done

Route11Gate2FLeftBinocularsText:
	text_asm
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jp nz, GateUpstairsScript_PrintIfFacingUp
	CheckEvent EVENT_BEAT_ROUTE12_SNORLAX
	ld hl, .SnorlaxText
	jr z, .print
	ld hl, .NoSnorlaxText
.print
	call PrintText
	jp TextScriptEnd

.SnorlaxText:
	text "ぼうえんきょうを　のぞいた！"

	para "どうろに　#が　ねてる！"
	done

.NoSnorlaxText:
	text "ぼうえんきょうを　のぞいた！"

	para "すばらしい　けしきだ！"
	done

Route11Gate2FRightBinocularsText:
	text_asm
	ld hl, .Text
	jp GateUpstairsScript_PrintIfFacingUp

.Text:
	text "ぼうえんきょうを　のぞいた！"

	para "シオン　タウンに　いく　には<⋯>"
	line "ハナダ　シティ　から"
	cont "イワヤマを　ぬければ　よさそう<⋯>"
	done
