Route16FlyHouse_Script:
	jp EnableAutoTextBoxDrawing

Route16FlyHouse_TextPointers:
	def_text_pointers
	dw_const Route16FlyHouseBrunetteGirlText, TEXT_ROUTE16FLYHOUSE_BRUNETTE_GIRL
	dw_const Route16FlyHouseFearowText,       TEXT_ROUTE16FLYHOUSE_FEAROW

Route16FlyHouseBrunetteGirlText:
	text_asm
	CheckEvent EVENT_GOT_HM02
	ld hl, .HM02ExplanationText
	jr nz, .got_item
	ld hl, .Text
	call PrintText
	lb bc, HM_FLY, 1
	call GiveItem
	jr nc, .bag_full
	SetEvent EVENT_GOT_HM02
	ld hl, .ReceivedHM02Text
	jr .got_item
.bag_full
	ld hl, .HM02NoRoomText
.got_item
	call PrintText
	jp TextScriptEnd

.Text:
	text "あらま<⋯>！"
	line "みつかっちゃったわね！"

	para "わたしの　こと"
	line "だれにも　いわないで"
	cont "これ　あげる　から"
	cont "<⋯>　おねがいよ"
	prompt

.ReceivedHM02Text:
	text "<PLAYER>は　おんなのこから"
	line "ひでんマシン０２を　もらった！@"
	sound_get_key_item
	text_end

.HM02ExplanationText:
	text "ひでんマシン０２は　そらをとぶ！"
	line "とても　べんりな"
	cont "すばらしい　わざ　なの！"

	para "だいじに　つかってね！"
	done

.HM02NoRoomText:
	text "あなた　にもつ　いっぱいよ"
	done

Route16FlyHouseFearowText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, FEAROW
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

.Text:
	text "オニドリル『キュイン！"
	done
