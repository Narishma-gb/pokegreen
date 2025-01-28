SafariZoneSecretHouse_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneSecretHouse_TextPointers:
	def_text_pointers
	dw_const SafariZoneSecretHouseFishingGuruText, TEXT_SAFARIZONESECRETHOUSE_FISHING_GURU

SafariZoneSecretHouseFishingGuruText:
	text_asm
	CheckEvent EVENT_GOT_HM03
	jr nz, .got_item
	ld hl, .YouHaveWonText
	call PrintText
	lb bc, HM_SURF, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedHM03Text
	call PrintText
	SetEvent EVENT_GOT_HM03
	jr .done
.bag_full
	ld hl, .HM03NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, .HM03ExplanationText
	call PrintText
.done
	jp TextScriptEnd

.YouHaveWonText:
	text "おおッ！　きたか！"

	para "ここは　いちばん　おくち　の"
	line "トレジャー　ハウス　だよ！"

	para "サファリ　ゾーンの　キャンペーン"
	line "ひらいたは　いいが　だれも　こない"
	cont "ふあんに　なってた　ところだ"

	para "いやー！　おめでとう！"
	line "しょうひんは　きみの　ものだ！"
	prompt

.ReceivedHM03Text:
	text "<PLAYER>は　かかりいん　から"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_item_1
	text_end

.HM03ExplanationText:
	text "ひでんマシン０３は　なみのり！"

	para "なんと！　#に　のって"
	line "みずの　うえを　すすめる！"

	para "しかも　この　マシンは　つかっても"
	line "なく　ならない　タイプだ！"

	para "こんなに　すばらしい"
	line "しょうひんを　もらって　しまった"
	cont "きみは　とても　ツイてるぞ！"
	done

.HM03NoRoomText:
	text "きみ　もちもの　いっぱいだよ"
	done
