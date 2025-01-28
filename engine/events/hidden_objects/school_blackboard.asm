PrintBlackboardLinkCableText:
	call EnableAutoTextBoxDrawing
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, [wHiddenObjectFunctionArgument]
	call PrintPredefTextID
	ret

LinkCableHelp::
	text_asm
	call SaveScreenTilesToBuffer1
	ld hl, LinkCableHelpText1
	call PrintText
	xor a
	ld [wMenuItemOffset], a ; not used
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	ld a, 3
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
.linkHelpLoop
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	hlcoord 0, 0
	ld b, 8
	ld c, 12
	call TextBoxBorder
	hlcoord 2, 2
	ld de, HowToLinkText
	call PlaceString
	ld hl, LinkCableHelpText2
	call PrintText
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .exit
	ld a, [wCurrentMenuItem]
	cp 3 ; pressed a on "STOP READING"
	jr z, .exit
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	ld hl, LinkCableInfoTexts
	add a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jp .linkHelpLoop
.exit
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	call LoadScreenTilesFromBuffer1
	jp TextScriptEnd

LinkCableHelpText1:
	text "<⋯>　#　こうざ！"

	para "つうしん　ケーブルを　つかった"
	line "あそびかた　に　ついて"
	prompt

LinkCableHelpText2:
	text "どの　こうもくを　よみますか？"
	done

HowToLinkText:
	db   "ケーブルで　あそぶには"
	next "コロシアム"
	next "トレード　センター"
	next "よむ　の　やめる@"

LinkCableInfoTexts:
	dw LinkCableInfoText1
	dw LinkCableInfoText2
	dw LinkCableInfoText3

LinkCableInfoText1:
	text "ともだちの　ゲームボーイと"
	line "ケーブルで　つないだら"
	cont "#　センター　みぎがわの"
	cont "カウンターの　おねえさんが"
	cont "あんない　してくれます"
	prompt

LinkCableInfoText2:
	text "コロシアムは"
	line "ともだちと　たいせん　するとき"
	cont "はいる　へや　です"
	prompt

LinkCableInfoText3:
	text "トレードセンターは　ともだちと"
	line "#を　こうかん　する　とき"
	cont "はいる　へや　です"
	prompt

ViridianSchoolBlackboard::
	text_asm
	call SaveScreenTilesToBuffer1
	ld hl, ViridianSchoolBlackboardText1
	call PrintText
	xor a
	ld [wMenuItemOffset], a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ld a, D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON
	ld [wMenuWatchedKeys], a
	ld a, 2
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
.blackboardLoop
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	hlcoord 0, 0
	lb bc, 6, 9
	call TextBoxBorder
	hlcoord 1, 2
	ld de, StatusAilmentText1
	call PlaceString
	hlcoord 6, 2
	ld de, StatusAilmentText2
	call PlaceString
	ld hl, ViridianSchoolBlackboardText2
	call PrintText
	call HandleMenuInput ; pressing up and down is handled in here
	bit BIT_B_BUTTON, a ; pressed b
	jr nz, .exitBlackboard
	bit BIT_D_RIGHT, a
	jr z, .didNotPressRight
	; move cursor to right column
	ld a, 2
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 6
	ld [wTopMenuItemX], a
	ld a, 3 ; in the the right column, use an offset to prevent overlap
	ld [wMenuItemOffset], a
	jr .blackboardLoop
.didNotPressRight
	bit BIT_D_LEFT, a
	jr z, .didNotPressLeftOrRight
	; move cursor to left column
	ld a, 2
	ld [wMaxMenuItem], a
	ld a, 2
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
	xor a
	ld [wMenuItemOffset], a
	jr .blackboardLoop
.didNotPressLeftOrRight
	ld a, [wCurrentMenuItem]
	ld b, a
	ld a, [wMenuItemOffset]
	add b
	cp 5 ; cursor is pointing to "QUIT"
	jr z, .exitBlackboard
	; we must have pressed a on a status condition
	; so print the text
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	ld hl, ViridianBlackboardStatusPointers
	add a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jp .blackboardLoop
.exitBlackboard
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	call LoadScreenTilesFromBuffer1
	jp TextScriptEnd

ViridianSchoolBlackboardText1:
	text "こくばんに"
	line "#が　たたかってる　とき"
	cont "おこる　たいちょうの"
	cont "へんかに　ついて　かかれてる"
	prompt

ViridianSchoolBlackboardText2:
	text "どの　こうもくを　みますか？"
	done

StatusAilmentText1:
	db   "　ねむり"
	next "　どく"
	next "　マヒ@"

StatusAilmentText2:
	db   "　やけど"
	next "　こおり"
	next "　やめる@"

	db "@" ; unused

ViridianBlackboardStatusPointers:
	dw ViridianBlackboardSleepText
	dw ViridianBlackboardPoisonText
	dw ViridianBlackboardPrlzText
	dw ViridianBlackboardBurnText
	dw ViridianBlackboardFrozenText

ViridianBlackboardSleepText:
	text "ねてしまうと　その　あいだは"
	line "こうげき　できません！"

	para "たたかい　おわっても　ねたまま"
	line "ねむけざましで　めが　さめます"
	prompt

ViridianBlackboardPoisonText:
	text "どくを　くらうと"
	line "たいりょくが　へって　いきます"

	para "たたかい　おわっても"
	line "どくは　のこりますが"
	cont "どくけしで　きえます！"
	prompt

ViridianBlackboardPrlzText:
	text "マヒすると　わざが"
	line "ときどき　でなく　なります！"

	para "たたかい　おわっても"
	line "マヒは　のこります"
	cont "また　マヒなおしで　なおります"
	prompt

ViridianBlackboardBurnText:
	text "やけどは　たいりょくが　へって"
	line "こうげきりょくと　すばやさも"
	cont "さがって　しまいます！"

	para "たたかい　おわっても"
	line "やけどは　のこります"
	cont "また　やけどなおしで　なおります"
	prompt

ViridianBlackboardFrozenText:
	text "こおって　しまうと"
	line "まったく　うごけなく　なります！"

	para "たたかい　おわっても　こおってます"
	line "こおりなおしで　とかさないと"
	cont "#が　かわいそう"
	prompt
