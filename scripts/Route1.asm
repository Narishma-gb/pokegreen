Route1_Script:
	jp EnableAutoTextBoxDrawing

Route1_TextPointers:
	def_text_pointers
	dw_const Route1Youngster1Text, TEXT_ROUTE1_YOUNGSTER1
	dw_const Route1Youngster2Text, TEXT_ROUTE1_YOUNGSTER2
	dw_const Route1SignText,       TEXT_ROUTE1_SIGN

Route1Youngster1Text:
	text_asm
	CheckAndSetEvent EVENT_GOT_POTION_SAMPLE
	jr nz, .got_item
	ld hl, .MartSampleText
	call PrintText
	lb bc, POTION, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .GotPotionText
	jr .done
.bag_full
	ld hl, .NoRoomText
	jr .done
.got_item
	ld hl, .AlsoGotPokeballsText
.done
	call PrintText
	jp TextScriptEnd

.MartSampleText:
	text "わたし　フレンドリィ　ショップの"
	line "てんいん　です"

	para "べんりな　どうぐや　ですから"
	line "トキワ　シティで"
	cont "ぜひ　よって　くださいね！"

	para "そうだ！"
	line "みほんを　さしあげましょう"
	cont "<⋯>　どうぞ！"
	prompt

.GotPotionText:
	text "<PLAYER>は"
	line "「@"
	text_ram wStringBuffer
	text "」を　もらった！@"
	sound_get_item_1
	text_end

.AlsoGotPokeballsText:
	text "#を　つかまえる"
	line "モンスターボール　かう　ときも"
	cont "ショップへ　いらして　ください！"
	done

.NoRoomText:
	text "にもつが　いっぱいだ！"
	done

Route1Youngster2Text:
	text "みちに　だんさが　あるだろ！"

	para "とび　おりるのは"
	line "ちょっと　こわいけど<⋯>"

	para "マサラ　タウンに　かえる　ときは"
	line "はやく　かえれて　いいよ"
	done

Route1SignText:
	text "ここは　１ばん　どうろ"
	line "マサラ　タウン　<⋯>　トキワ　シティ"
	done
