CeladonDiner_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonDiner_TextPointers:
	def_text_pointers
	dw_const CeladonDinerCookText,            TEXT_CELADONDINER_COOK
	dw_const CeladonDinerMiddleAgedWomanText, TEXT_CELADONDINER_MIDDLE_AGED_WOMAN
	dw_const CeladonDinerMiddleAgedManText,   TEXT_CELADONDINER_MIDDLE_AGED_MAN
	dw_const CeladonDinerFisherText,          TEXT_CELADONDINER_FISHER
	dw_const CeladonDinerGymGuideText,        TEXT_CELADONDINER_GYM_GUIDE

CeladonDinerCookText:
	text "らっしゃい！"

	para "じょうれん　ばかりで　わるいね！"
	done

CeladonDinerMiddleAgedWomanText:
	text "うちで　かってる　#<⋯>"
	line "たいりょく　ないから　いつも"
	cont "デパートで　おくすり　かって　くるの"
	done

CeladonDinerMiddleAgedManText:
	text "ひそひそ<⋯>　むしゃ　むしゃ<⋯>"
	line "<⋯>　ゲーム　コーナーの　したに"
	cont "ちかしつが　ある　らしいね<⋯>"
	done

CeladonDinerFisherText:
	text "もぐもぐ<⋯>！"

	para "あそこの　テーブルの　おっさん"
	line "スロットで　おかね　ぜんぶ"
	cont "つかっちゃった　らしいよ！"
	done

CeladonDinerGymGuideText:
	text_asm
	CheckEvent EVENT_GOT_COIN_CASE
	jr nz, .got_item
	ld hl, .ImFlatOutBustedText
	call PrintText
	lb bc, COIN_CASE, 1
	call GiveItem
	jr nc, .bag_full
	SetEvent EVENT_GOT_COIN_CASE
	ld hl, .ReceivedCoinCaseText
	call PrintText
	jr .done
.bag_full
	ld hl, .CoinCaseNoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, .WinItBackText
	call PrintText
.done
	jp TextScriptEnd

.ImFlatOutBustedText:
	text "うおう<⋯>　わらってくれ！"

	para "ゲーム　コーナーで　すって"
	line "いちもん　なしに　なっちまった！"

	para "もう　スロットは　やらん！"
	line "じみちに　はたらくぞ！"

	para "<⋯>　というわけで"
	line "これは　おまえに　やる！"
	prompt

.ReceivedCoinCaseText:
	text "<PLAYER>は　おっさん　から"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_key_item
	text_end

.CoinCaseNoRoomText:
	text "にもつが　いっぱい　だぜ"
	done

.WinItBackText:
	text "あーあ！"
	line "いつか　かならず　かてる！"
	cont "と　おもったのに　この　ざまだ<⋯>！"
	done
