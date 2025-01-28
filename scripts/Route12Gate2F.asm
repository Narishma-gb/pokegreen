Route12Gate2F_Script:
	jp DisableAutoTextBoxDrawing

Route12Gate2F_TextPointers:
	def_text_pointers
	dw_const Route12Gate2FBrunetteGirlText,    TEXT_ROUTE12GATE2F_BRUNETTE_GIRL
	dw_const Route12Gate2FLeftBinocularsText,  TEXT_ROUTE12GATE2F_LEFT_BINOCULARS
	dw_const Route12Gate2FRightBinocularsText, TEXT_ROUTE12GATE2F_RIGHT_BINOCULARS

Route12Gate2FBrunetteGirlText:
	text_asm
	CheckEvent EVENT_GOT_TM39, 1
	jr c, .got_item
	ld hl, .YouCanHaveThisText
	call PrintText
	lb bc, TM_SWIFT, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedTM39Text
	call PrintText
	SetEvent EVENT_GOT_TM39
	jr .done
.bag_full
	ld hl, .TM39NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, .TM39ExplanationText
	call PrintText
.done
	jp TextScriptEnd

.YouCanHaveThisText:
	text "わたしが　かわいがってた　#"
	line "いまは　#　タワーで"
	cont "ねむってるの<⋯>"

	para "<⋯>　そうだ　わたしの　<TM>"
	line "おにいちゃんに　あげるわ"
	cont "わたし<⋯>　もう　いらない　から"
	prompt

.ReceivedTM39Text:
	text "<PLAYER>は　おんなのこから"
	line "<TM>３９を　もらった！@"
	sound_get_item_1
	text_end

.TM39ExplanationText:
	text "<TM>３９は"
	line "スピードスター　という　わざよ"

	para "この　わざは　めいちゅうりつが"
	line "すごく　たかいの"
	cont "まけられない　しょうぶの　とき"
	cont "やくに　たつ　はずよ"
	done

.TM39NoRoomText:
	text "にもつ　いっぱいで　もてないよ"
	done

Route12Gate2FLeftBinocularsText:
	text_asm
	ld hl, .Text
	jp GateUpstairsScript_PrintIfFacingUp

.Text:
	text "ぼうえんきょうを　のぞいた！"

	para "つりを　してる　おじさんだ！"
	done

Route12Gate2FRightBinocularsText:
	text_asm
	ld hl, .Text
	jp GateUpstairsScript_PrintIfFacingUp

.Text:
	text "ぼうえんきょうを　のぞいた！"

	para "#　タワーが　みえる！"
	done

GateUpstairsScript_PrintIfFacingUp:
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jr z, .up
	ld a, TRUE
	jr .done
.up
	call PrintText
	xor a
.done
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd
