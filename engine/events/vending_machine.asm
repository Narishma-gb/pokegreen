VendingMachineMenu::
	ld hl, VendingMachineText1
	call PrintText
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	ld a, 3
	ld [wMaxMenuItem], a
	ld a, 5
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	hlcoord 0, 3
	ld b, 8
	ld c, 12
	call TextBoxBorder
	call UpdateSprites
	hlcoord 2, 5
	ld de, DrinkText
	call PlaceString
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .notThirsty
	ld a, [wCurrentMenuItem]
	cp 3 ; chose Cancel?
	jr z, .notThirsty
	xor a
	ldh [hMoney], a
	ldh [hMoney + 2], a
	ld a, $2
	ldh [hMoney + 1], a
	call HasEnoughMoney
	jr nc, .enoughMoney
	ld hl, VendingMachineText4
	jp PrintText
.enoughMoney
	call LoadVendingMachineItem
	ldh a, [hVendingMachineItem]
	ld b, a
	ld c, 1
	call GiveItem
	jr nc, .BagFull

	ld b, 60 ; number of times to play the "brrrrr" sound
.playDeliverySound
	ld c, 2
	call DelayFrames
	push bc
	ld a, SFX_PUSH_BOULDER
	call PlaySound
	pop bc
	dec b
	jr nz, .playDeliverySound

	ld hl, VendingMachineText5
	call PrintText
	ld hl, hVendingMachinePrice + 2
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	jp DisplayTextBoxID
.BagFull
	ld hl, VendingMachineText6
	jp PrintText
.notThirsty
	ld hl, VendingMachineText7
	jp PrintText

VendingMachineText1:
	text "じどう　はんばいき　だ！"
	line "ほしい　のみものは<⋯>　<⋯>"
	prompt

DrinkText:
	db   "おいしいみず　２００円"
	next "サイコソーダ　３００円"
	next "ミックスオレ　３５０円"
	next "いらない@"

VendingMachineText4:
	text "おかねが　たりないぞ！"
	done

VendingMachineText5:
	text_ram wStringBuffer
	text "が　でてきた！"
	done

VendingMachineText6:
	text "これ　いじょう　もてない！"
	done

VendingMachineText7:
	text "やっぱり　やめた！"
	done

LoadVendingMachineItem:
	ld hl, VendingPrices
	ld a, [wCurrentMenuItem]
	add a
	add a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ldh [hVendingMachineItem], a
	ld a, [hli]
	ldh [hVendingMachinePrice], a
	ld a, [hli]
	ldh [hVendingMachinePrice + 1], a
	ld a, [hl]
	ldh [hVendingMachinePrice + 2], a
	ret

INCLUDE "data/items/vending_prices.asm"
