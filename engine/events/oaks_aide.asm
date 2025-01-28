OaksAideScript:
	ld hl, OaksAideHiText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .choseNo
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	ldh [hOaksAideNumMonsOwned], a
	ld b, a
	ldh a, [hOaksAideRequirement]
	cp b
	jr z, .giveItem
	jr nc, .notEnoughOwnedMons
.giveItem
	ld hl, OaksAideHereYouGoText
	call PrintText
	ldh a, [hOaksAideRewardItem]
	ld b, a
	ld c, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, OaksAideGotItemText
	call PrintText
	ld a, OAKS_AIDE_GOT_ITEM
	jr .done
.bagFull
	ld hl, OaksAideNoRoomText
	call PrintText
	xor a ; OAKS_AIDE_BAG_FULL
	jr .done
.notEnoughOwnedMons
	ld hl, OaksAideUhOhText
	call PrintText
	ld a, OAKS_AIDE_NOT_ENOUGH_MONS
	jr .done
.choseNo
	ld hl, OaksAideComeBackText
	call PrintText
	ld a, OAKS_AIDE_REFUSED
.done
	ldh [hOaksAideResult], a
	ret

OaksAideHiText:
	text "ぼく　おぼえてます？"
	line "ほら<⋯>！"
	cont "オーキド　はかせの　じょしゅ　です"

	para "#ずかんが　@"
	text_decimal hOaksAideRequirement, 1, 3
	text "しゅるい"
	line "あつまってる　ようなら"
	cont "@"
	text_ram wOaksAideRewardItemName
	text "を　わたす　よう"
	cont "はかせに　いわれ　ました"

	para "<⋯>　それでは　さっそく"
	line "<PLAYER>くん！"
	cont "つかまえた　#は"
	cont "@"
	text_decimal hOaksAideRequirement, 1, 3
	text "しゅるい　より　おおい　かな？"
	done

OaksAideUhOhText:
	text "<⋯>　<⋯>　えーと！"
	line "つかまえた　#は<⋯>"
	cont "あれれー？"
	cont "まだ　@"
	text_decimal hOaksAideNumMonsOwned, 1, 3
	text "しゅるい　ですよ！"

	para "@"
	text_decimal hOaksAideRequirement, 1, 3
	text "しゅるいに　たりない　なら"
	line "@"
	text_ram wOaksAideRewardItemName
	text "は"
	cont "また　こんど　ですね"
	done

OaksAideComeBackText:
	text "<⋯>　<⋯>　そう　ですか"

	para "@"
	text_decimal hOaksAideRequirement, 1, 3
	text "しゅるいに　たりない　なら"
	line "@"
	text_ram wOaksAideRewardItemName
	text "は"
	cont "また　こんど　ですね"
	done

OaksAideHereYouGoText:
	text "<⋯>　<⋯>　なるほど！"
	line "つかまえた　#は<⋯>"
	cont "@"
	text_decimal hOaksAideNumMonsOwned, 1, 3
	text "しゅるい　ですね！"
	cont "おめでとう！"

	para "それでは"
	line "これを　おわたし　します！"
	prompt

OaksAideGotItemText:
	text "<PLAYER>は　じょしゅ　から"
	line "@"
	text_ram wOaksAideRewardItemName
	text "を　もらった！@"
	sound_get_item_1
	text_end

OaksAideNoRoomText:
	text "<⋯>　<⋯>　と　おもった　けど"
	line "にもつが　いっぱい　だから"
	cont "@"
	text_ram wOaksAideRewardItemName
	text "は"
	cont "また　こんど　ですね"
	done
