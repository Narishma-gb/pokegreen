CeladonMartRoof_Script:
	jp EnableAutoTextBoxDrawing

CeladonMartRoofScript_GetDrinksInBag:
; construct a list of all drinks in the player's bag
	xor a
	ld [wFilteredBagItemsCount], a
	ld de, wFilteredBagItems
	ld hl, CeladonMartRoofDrinkList
.loop
	ld a, [hli]
	and a
	jr z, .done
	push hl
	push de
	ld [wTempByteValue], a
	ld b, a
	predef GetQuantityOfItemInBag
	pop de
	pop hl
	ld a, b
	and a
	jr z, .loop
	; A drink is in the bag
	ld a, [wTempByteValue]
	ld [de], a
	inc de
	push hl
	ld hl, wFilteredBagItemsCount
	inc [hl]
	pop hl
	jr .loop
.done
	ld a, $ff
	ld [de], a
	ret

CeladonMartRoofDrinkList:
	db FRESH_WATER
	db SODA_POP
	db LEMONADE
	db 0 ; end

CeladonMartRoofScript_GiveDrinkToGirl:
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	ld hl, CeladonMartRoofLittleGirlGiveHerWhichDrinkText
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	ld a, [wFilteredBagItemsCount]
	dec a
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
	ld a, [wFilteredBagItemsCount]
	dec a
	ld bc, 2
	ld hl, 3
	call AddNTimes
	dec l
	ld b, l
	ld c, 7
	hlcoord 0, 0
	call TextBoxBorder
	call UpdateSprites
	call CeladonMartRoofScript_PrintDrinksInBag
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	ret nz
	ld hl, wFilteredBagItems
	ld a, [wCurrentMenuItem]
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	ldh [hItemToRemoveID], a
	cp FRESH_WATER
	jr z, .gaveFreshWater
	cp SODA_POP
	jr z, .gaveSodaPop
; gave Lemonade
	CheckEvent EVENT_GOT_TM49
	jr nz, .alreadyGaveDrink
	ld hl, CeladonMartRoofLittleGirlYayLemonadeText
	call PrintText
	call RemoveItemByIDBank12
	lb bc, TM_TRI_ATTACK, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, CeladonMartRoofLittleGirlReceivedTM49Text
	call PrintText
	SetEvent EVENT_GOT_TM49
	ret
.gaveSodaPop
	CheckEvent EVENT_GOT_TM48
	jr nz, .alreadyGaveDrink
	ld hl, CeladonMartRoofLittleGirlYaySodaPopText
	call PrintText
	call RemoveItemByIDBank12
	lb bc, TM_ROCK_SLIDE, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, CeladonMartRoofLittleGirlReceivedTM48Text
	call PrintText
	SetEvent EVENT_GOT_TM48
	ret
.gaveFreshWater
	CheckEvent EVENT_GOT_TM13
	jr nz, .alreadyGaveDrink
	ld hl, CeladonMartRoofLittleGirlYayFreshWaterText
	call PrintText
	call RemoveItemByIDBank12
	lb bc, TM_ICE_BEAM, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, CeladonMartRoofLittleGirlReceivedTM13Text
	call PrintText
	SetEvent EVENT_GOT_TM13
	ret
.bagFull
	ld hl, CeladonMartRoofLittleGirlNoRoomText
	jp PrintText
.alreadyGaveDrink
	ld hl, CeladonMartRoofLittleGirlImNotThirstyText
	jp PrintText

RemoveItemByIDBank12:
	farjp RemoveItemByID

CeladonMartRoofLittleGirlGiveHerWhichDrinkText:
	text "どれを　あげますか？"
	done

CeladonMartRoofLittleGirlYayFreshWaterText:
	text "わーい！"

	para "おいしいみず　くれるの？"

	para "ごちそう　さま！"

	para "おれいに　わたしの　たからもの"
	line "これ　あげるね！@"
	text_waitbutton
	text_end

CeladonMartRoofLittleGirlReceivedTM13Text:
	text "<PLAYER>は　おんなのこ　から"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_item_1
	text_start

	para "@"
	text_ram wStringBuffer
	text "の　なかは"
	line "れいとうビーム　なの！"

	para "たまに　あいてを"
	line "こおらせる　ことが　あるわ@"
	text_waitbutton
	text_end

CeladonMartRoofLittleGirlYaySodaPopText:
	text "わーい！"

	para "サイコソーダ　くれるの？"

	para "ごちそうさま！"

	para "おれいに　わたしの　たからもの"
	line "これ　あげるね！@"
	text_waitbutton
	text_end

CeladonMartRoofLittleGirlReceivedTM48Text:
	text "<PLAYER>は　おんなのこから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_item_1
	text_start

	para "@"
	text_ram wStringBuffer
	text "の　なかは"
	line "いわなだれ　なの！"

	para "たまに　あいてを"
	line "きぜつ　させる　ことが　あるわ@"
	text_waitbutton
	text_end

CeladonMartRoofLittleGirlYayLemonadeText:
	text "わーい！"

	para "ミックスオレ　くれるの？"

	para "ごちそうさま！"

	para "おれいに　わたしの　たからもの"
	line "これ　あげるね！@"
	text_waitbutton
	text_end

CeladonMartRoofLittleGirlReceivedTM49Text:
	text "<PLAYER>は　おんなのこから"
	line "<TM>４９を　もらった！@"
	sound_get_item_1
	text_start

	para "<TM>４９の　なかは"
	line "トライアタック　なの！"

	para "たまに　あいてを"
	line "まひ　させる　ことが　あるわ@"
	text_waitbutton
	text_end

CeladonMartRoofLittleGirlNoRoomText:
	text "にもつ　いっぱいよ！@"
	text_waitbutton
	text_end

CeladonMartRoofLittleGirlImNotThirstyText:
	text "うーん！"
	line "やっぱり　がまん　する！@"
	text_waitbutton
	text_end

CeladonMartRoofScript_PrintDrinksInBag:
	ld hl, wFilteredBagItems
	xor a
	ldh [hItemCounter], a
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wNamedObjectIndex], a
	call GetItemName
	hlcoord 2, 2
	ldh a, [hItemCounter]
	ld bc, SCREEN_WIDTH * 2
	call AddNTimes
	ld de, wNameBuffer
	call PlaceString
	ld hl, hItemCounter
	inc [hl]
	pop hl
	jr .loop

CeladonMartRoof_TextPointers:
	def_text_pointers
	dw_const CeladonMartRoofSuperNerdText,        TEXT_CELADONMARTROOF_SUPER_NERD
	dw_const CeladonMartRoofLittleGirlText,       TEXT_CELADONMARTROOF_LITTLE_GIRL
	dw_const CeladonMartRoofVendingMachineText,   TEXT_CELADONMARTROOF_VENDING_MACHINE1
	dw_const CeladonMartRoofVendingMachineText,   TEXT_CELADONMARTROOF_VENDING_MACHINE2
	dw_const CeladonMartRoofVendingMachineText,   TEXT_CELADONMARTROOF_VENDING_MACHINE3
	dw_const CeladonMartRoofCurrentFloorSignText, TEXT_CELADONMARTROOF_CURRENT_FLOOR_SIGN

CeladonMartRoofSuperNerdText:
	text "ウチの　いもうと　あれでも"
	line "#　<TRAINER>の　はしくれ！"

	para "だけど<⋯>"
	line "わがままで　イヤんなっちゃうよ"
	done

CeladonMartRoofLittleGirlText:
	text_asm
	call CeladonMartRoofScript_GetDrinksInBag
	ld a, [wFilteredBagItemsCount]
	and a
	jr z, .noDrinksInBag
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, .GiveHerADrinkText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done
	call CeladonMartRoofScript_GiveDrinkToGirl
	jr .done
.noDrinksInBag
	ld hl, .ImThirstyText
	call PrintText
.done
	jp TextScriptEnd

.ImThirstyText:
	text "えーん<⋯>！"
	line "おにいちゃん！"
	cont "ジュース　のみたいよー！"
	done

.GiveHerADrinkText:
	text "えーん<⋯>！"
	line "おにいちゃん！"
	cont "ジュース　のみたいよー！"

	para "のみものを　あげますか？"
	done

CeladonMartRoofVendingMachineText:
	script_vending_machine

CeladonMartRoofCurrentFloorSignText:
	text "おくじょう　<⋯>　いこいの　ひろば"
	line "　　　　　　<⋯>　じどう　はんばいき"
	done
