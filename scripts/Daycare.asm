Daycare_Script:
	jp EnableAutoTextBoxDrawing

Daycare_TextPointers:
	def_text_pointers
	dw_const DaycareGentlemanText, TEXT_DAYCARE_GENTLEMAN

DaycareGentlemanText:
	text_asm
	call SaveScreenTilesToBuffer2
	ld a, [wDayCareInUse]
	and a
	jr nz, .daycareInUse
	ld hl, .IntroText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, .ComeAgainText
	jp nz, .done
	ld a, [wPartyCount]
	dec a
	ld hl, .OnlyHaveOneMonText
	jp z, .done
	ld hl, .WhichMonText
	call PrintText
	xor a
	ld [wUpdateSpritesEnabled], a
	ld [wPartyMenuTypeOrMessageID], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	ld hl, .AllRightThenText
	jp c, .done
	callfar KnowsHMMove
	ld hl, .CantAcceptMonWithHMText
	jp c, .done
	xor a
	ld [wPartyAndBillsPCSavedMenuItem], a
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, .WillLookAfterMonText
	call PrintText
	ld a, 1
	ld [wDayCareInUse], a
	ld a, PARTY_TO_DAYCARE
	ld [wMoveMonType], a
	call MoveMon
	xor a
	ld [wRemoveMonFromBox], a
	call RemovePokemon
	ld a, [wCurPartySpecies]
	call PlayCry
	ld hl, .ComeSeeMeInAWhileText
	jp .done

.daycareInUse
	xor a
	ld hl, wDayCareMonName
	call GetPartyMonName
	ld a, DAYCARE_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	callfar CalcLevelFromExperience
	ld a, d
	cp MAX_LEVEL
	jr c, .skipCalcExp

	ld d, MAX_LEVEL
	callfar CalcExperience
	ld hl, wDayCareMonExp
	ldh a, [hExperience]
	ld [hli], a
	ldh a, [hExperience + 1]
	ld [hli], a
	ldh a, [hExperience + 2]
	ld [hl], a
	ld d, MAX_LEVEL

.skipCalcExp
	xor a
	ld [wDayCareNumLevelsGrown], a
	ld hl, wDayCareMonBoxLevel
	ld a, [hl]
	ld [wDayCareStartLevel], a
	cp d
	ld [hl], d
	ld hl, .MonNeedsMoreTimeText
	jr z, .next
	ld a, [wDayCareStartLevel]
	ld b, a
	ld a, d
	sub b
	ld [wDayCareNumLevelsGrown], a
	ld hl, .MonHasGrownText

.next
	call PrintText
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	ld hl, .NoRoomForMonText
	jp z, .leaveMonInDayCare
	ld de, wDayCareTotalCost
	xor a
	ld [de], a
	inc de
	ld [de], a
	ld hl, wDayCarePerLevelCost
	ld a, $1
	ld [hli], a
	ld [hl], $0
	ld a, [wDayCareNumLevelsGrown]
	inc a
	ld b, a
	ld c, 2
.calcPriceLoop
	push hl
	push de
	push bc
	predef AddBCDPredef
	pop bc
	pop de
	pop hl
	dec b
	jr nz, .calcPriceLoop
	ld hl, .OweMoneyText
	call PrintText
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	call YesNoChoice
	ld hl, .AllRightThenText
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .leaveMonInDayCare
	ld hl, wDayCareTotalCost
	ldh [hMoney], a
	ld a, [hli]
	ldh [hMoney + 1], a
	ld a, [hl]
	ldh [hMoney + 2], a
	call HasEnoughMoney
	jr nc, .enoughMoney
	ld hl, .NotEnoughMoneyText
	jp .leaveMonInDayCare

.enoughMoney
	xor a
	ld [wDayCareInUse], a
	ld hl, wDayCareNumLevelsGrown
	ld [hli], a
	inc hl
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, .HeresYourMonText
	call PrintText
	ld a, DAYCARE_TO_PARTY
	ld [wMoveMonType], a
	call MoveMon
	ld a, [wDayCareMonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wPartyCount]
	dec a
	push af
	ld bc, wPartyMon2 - wPartyMon1
	push bc
	ld hl, wPartyMon1Moves
	call AddNTimes
	ld d, h
	ld e, l
	ld a, 1
	ld [wLearningMovesFromDayCare], a
	predef WriteMonMoves
	pop bc
	pop af

; set mon's HP to max
	ld hl, wPartyMon1HP
	call AddNTimes
	ld d, h
	ld e, l
	ld bc, wPartyMon1MaxHP - wPartyMon1HP
	add hl, bc
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a

	ld a, [wCurPartySpecies]
	call PlayCry
	ld hl, .GotMonBackText
	jr .done

.leaveMonInDayCare
	ld a, [wDayCareStartLevel]
	ld [wDayCareMonBoxLevel], a

.done
	call PrintText
	jp TextScriptEnd

.IntroText:
	text "わたしは　そだてやさん"
	line "なにか　そだてて　みるかね？"
	done

.WhichMonText:
	text "それでは"
	line "なにを　そだてて　みるかね？"
	prompt

.WillLookAfterMonText:
	text "わかった"
	line "しばらく@"
	text_ram wNameBuffer
	text "を　あずかろう"
	prompt

.ComeSeeMeInAWhileText:
	text "てきとうに　じかんが　たったら"
	line "また　きなさい"
	done

.MonHasGrownText:
	text "おまえの　@"
	text_ram wNameBuffer
	text_start
	line "ずいぶんと　せいちょうしたぞ"

	para "そうだな　レベルで　いうと"
	line "@"
	text_decimal wDayCareNumLevelsGrown, 1, 3
	text "くらい　そだってるな"

	para "やっぱり　わたしは　てんさいだ！"
	prompt

.OweMoneyText:
	text "<⋯>で　#を　ひきとるなら"
	line "りょうきんは　@"
	text_bcd wDayCareTotalCost, 2 | LEADING_ZEROES | LEFT_ALIGN
	text "円　だよ"
	done

.GotMonBackText:
	text "<PLAYER>は　そだてやさんから"
	line "@"
	text_ram wDayCareMonName
	text "を　ひきとった！"
	done

.MonNeedsMoreTimeText:
	text "なんだ　もう　きたのか"
	line "おまえの　@"
	text_ram wNameBuffer
	text "は<⋯>"

	para "まだ　じかんが　かかるぞ"
	prompt

.AllRightThenText:
	text "そうか　それじゃ"
	line "@"
.ComeAgainText:
	text "また　きなさいよ"
	done

.NoRoomForMonText:
	text "だけど　つれていくには"
	line "#が　いっぱいのようだな"
	done

.OnlyHaveOneMonText:
	text "おや？　#が"
	line "１ぴきしか　いないようだな"
	done

.CantAcceptMonWithHMText:
	text "わるいけど　ひでんのわざを　もった"
	line "#は　あずかれないなぁ"
	done

.HeresYourMonText:
	text "ほい　たしかに！"
	line "じゃ　#　つれて　いきなよ"
	prompt

.NotEnoughMoneyText:
	text "かねが　たらんな"
	done
