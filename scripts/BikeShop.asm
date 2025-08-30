BikeShop_Script:
	jp EnableAutoTextBoxDrawing

BikeShop_TextPointers:
	def_text_pointers
	dw_const BikeShopClerkText,             TEXT_BIKESHOP_CLERK
	dw_const BikeShopMiddleAgedWomanText,   TEXT_BIKESHOP_MIDDLE_AGED_WOMAN
	dw_const BikeShopYoungsterText,         TEXT_BIKESHOP_YOUNGSTER

BikeShopClerkText:
	text_asm
	CheckEvent EVENT_GOT_BICYCLE
	jr z, .dontHaveBike
	ld hl, BikeShopClerkHowDoYouLikeYourBicycleText
	call PrintText
	jp .Done
.dontHaveBike
	ld b, BIKE_VOUCHER
	call IsItemInBag
	jr z, .dontHaveVoucher
	ld hl, BikeShopClerkOhThatsAVoucherText
	call PrintText
	lb bc, BICYCLE, 1
	call GiveItem
	jr nc, .BagFull
	ld a, BIKE_VOUCHER
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_GOT_BICYCLE
	ld hl, BikeShopExchangedVoucherText
	call PrintText
	jr .Done
.BagFull
	ld hl, BikeShopBagFullText
	call PrintText
	jr .Done
.dontHaveVoucher
	ld hl, BikeShopClerkWelcomeText
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, PAD_A | PAD_B
	ld [wMenuWatchedKeys], a
	ld a, $1
	ld [wMaxMenuItem], a
	ld a, $2
	ld [wTopMenuItemY], a
	ld a, $1
	ld [wTopMenuItemX], a
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	hlcoord 0, 0
	ld b, 4
	ld c, 15
	call TextBoxBorder
	call UpdateSprites
	hlcoord 2, 2
	ld de, BikeShopMenuText
	call PlaceString
	ld hl, BikeShopClerkDoYouLikeItText
	call PrintText
	call HandleMenuInput
	bit B_PAD_B, a
	jr nz, .cancel
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .cancel
	ld hl, BikeShopCantAffordText
	call PrintText
.cancel
	ld hl, BikeShopComeAgainText
	call PrintText
.Done
	jp TextScriptEnd

BikeShopMenuText:
	db   "じてんしゃ　１００００００円"
	next "かわない@"

BikeShopClerkWelcomeText:
	text "はい　はい！　いらっしゃい！"
	line "ここは　ミラクル　じてんしゃや！"

	para "ほりだしもの　あるよー！"
	line "かってくー？"
	prompt

BikeShopClerkDoYouLikeItText:
	text "かっこいい　じてんしゃ　あるけど"
	line "かって　いかない？"
	done

BikeShopCantAffordText:
	text "おきゃくさん！"
	line "おかねが　たりませんなー！"
	prompt

BikeShopClerkOhThatsAVoucherText:
	text "あー　それは<⋯>！"

	para "じてんしゃ　ひきかえけん！"

	para "<⋯>わかりました！"
	line "ささっ　これを　どうぞ！"
	prompt

BikeShopExchangedVoucherText:
	text "<PLAYER>は　ひきかえけんで"
	line "じてんしゃを　もらった！@"
	sound_get_key_item
	text_end

BikeShopComeAgainText:
	text "また　よろしく！"
	line "ありがとう　ございました！"
	done

BikeShopClerkHowDoYouLikeYourBicycleText:
	text "やあ　こんちは！　じてんしゃの"
	line "のりごこちは　いかが　です？"

	para "あの　じてんしゃ　なら"
	line "サイクリング　ロードは　もちろん"
	cont "どうくつ　だって　はしれちゃうよ！"
	done

BikeShopBagFullText:
	text "じてんしゃを　もっていけないよ"
	done

BikeShopMiddleAgedWomanText:
	text_asm
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text "うーん<⋯>！"
	line "やっぱり　ママチャリ　かしら？"

	para "マウンテン　バイクに"
	line "かいものカゴ　にあわない　もん"
	done

BikeShopYoungsterText:
	text_asm
	CheckEvent EVENT_GOT_BICYCLE
	ld hl, .CoolBikeText
	jr nz, .gotBike
	ld hl, .TheseBikesAreExpensiveText
.gotBike
	call PrintText
	jp TextScriptEnd

.TheseBikesAreExpensiveText:
	text "この　みせの　じてんしゃ"
	line "ものは　いいけど　たかいよ！"
	cont "ぼくには　かえないね"
	done

.CoolBikeText:
	text "きみの　じてんしゃ　かっこいい"
	line "うらやましいなあ"
	done
