CeruleanBadgeHouse_Script:
	ld a, 1 << BIT_NO_AUTO_TEXT_BOX
	ld [wAutoTextBoxDrawingControl], a
	dec a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ret

CeruleanBadgeHouse_TextPointers:
	def_text_pointers
	dw_const CeruleanBadgeHouseMiddleAgedManText, TEXT_CERULEANBADGEHOUSE_MIDDLE_AGED_MAN

CeruleanBadgeHouseMiddleAgedManText:
	text_asm
	ld hl, .Text
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
.loop
	ld hl, .WhichBadgeText
	call PrintText
	ld hl, .BadgeItemList
	call LoadItemList
	ld hl, wItemList
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	xor a
	ld [wPrintItemPrices], a
	ld a, SPECIALLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	jr c, .done
	ld hl, CeruleanBadgeHouseBadgeTextPointers
	ld a, [wCurItem]
	sub BOULDERBADGE
	add a
	ld d, $0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jr .loop
.done
	xor a
	ld [wListScrollOffset], a
	ld hl, .VisitAnyTimeText
	call PrintText
	jp TextScriptEnd

.BadgeItemList:
	table_width 1
	db NUM_BADGES ; #
	db BOULDERBADGE
	db CASCADEBADGE
	db THUNDERBADGE
	db RAINBOWBADGE
	db SOULBADGE
	db MARSHBADGE
	db VOLCANOBADGE
	db EARTHBADGE
	db -1 ; end
	assert_table_length NUM_BADGES + 2

.Text:
	text "うでが　あがった"
	line "#<TRAINER>だけが　もらえる"
	cont "#　バッジ"

	para "あなたも　いくつか　もってるね"

	para "その　バッジには"
	line "すごい　ひみつが　あるのです"
	prompt

.WhichBadgeText:
	text "では<⋯>"

	para "#　バッジ　８つの　ひみつ"
	line "どれに　ついて　はなし　ましょう？"
	done

.VisitAnyTimeText:
	text "はなしを　ききたく　なったら"
	line "また　いらっしゃい"
	done

CeruleanBadgeHouseBadgeTextPointers:
	table_width 2
	dw CeruleanBadgeHouseBoulderBadgeText
	dw CeruleanBadgeHouseCascadeBadgeText
	dw CeruleanBadgeHouseThunderBadgeText
	dw CeruleanBadgeHouseRainbowBadgeText
	dw CeruleanBadgeHouseSoulBadgeText
	dw CeruleanBadgeHouseMarshBadgeText
	dw CeruleanBadgeHouseVolcanoBadgeText
	dw CeruleanBadgeHouseEarthBadgeText
	assert_table_length NUM_BADGES

CeruleanBadgeHouseBoulderBadgeText:
	text "すべての"
	line "#の　こうげき　りょくが"
	cont "すこし　たかく　なります"

	para "それから　フラッシュの　わざは"
	line "たたかって　いない　ときでも"
	cont "つかえるように　なります"
	prompt

CeruleanBadgeHouseCascadeBadgeText:
	text "レベル３０までの　#は"
	line "おとなしく　いうことを　ききます"

	para "それいじょう　レベルが　たかいと"
	line "うまく　あつかえません"

	para "それから　いあいぎりの　わざは"
	line "たたかって　いない　ときでも"
	cont "つかえるように　なります"
	prompt

CeruleanBadgeHouseThunderBadgeText:
	text "すべての"
	line "#の　すばやさが"
	cont "すこし　たかく　なります"

	para "それから　そらをとぶ　わざは"
	line "たたかって　いない　ときでも"
	cont "つかえるように　なります"
	prompt

CeruleanBadgeHouseRainbowBadgeText:
	text "レベル５０までの　#は"
	line "おとなしく　いうことを　ききます"

	para "それいじょう　レベルが　たかいと"
	line "うまく　あつかえません"

	para "それから　かいりきの　わざは"
	line "たたかって　いない　ときでも"
	cont "つかえるように　なります"
	prompt

CeruleanBadgeHouseSoulBadgeText:
	text "すべての"
	line "#の　ぼうぎょ　りょくが"
	cont "すこし　たかく　なります"

	para "それから　なみのりの　わざは"
	line "たたかって　いない　ときでも"
	cont "つかえるように　なります"
	prompt

CeruleanBadgeHouseMarshBadgeText:
	text "レベル７０までの　#は"
	line "おとなしく　いうことを　ききます"

	para "それいじょう　レベルが　たかいと"
	line "うまく　あつかえません"
	prompt

CeruleanBadgeHouseVolcanoBadgeText:
	text "すべての"
	line "#の　とくしゅ　のうりょくが"
	cont "すこし　たかく　なります"
	prompt

CeruleanBadgeHouseEarthBadgeText:
	text "すべての　#は"
	line "おとなしく　いうことを　ききます"
	prompt
