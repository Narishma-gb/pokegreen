DrawPartyMenu_::
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	call UpdateSprites
	farcall LoadMonPartySpriteGfxWithLCDDisabled ; load pokemon icon graphics

RedrawPartyMenu_::
	ld a, [wPartyMenuTypeOrMessageID]
	cp SWAP_MONS_PARTY_MENU
	jp z, .printMessage
	call ErasePartyMenuCursors
	farcall InitPartyMenuBlkPacket
	hlcoord 3, 1
	ld de, wPartySpecies
	xor a
	ld c, a
	ldh [hPartyMonIndex], a
	ld [wWhichPartyMenuHPBar], a
.loop
	ld a, [de]
	cp $FF ; reached the terminator?
	jp z, .afterDrawingMonEntries
	push bc
	push de
	push hl
	ld a, c
	push hl
	ld hl, wPartyMonNicks
	call GetPartyMonName
	pop hl
	call PlaceString ; print the pokemon's name
	farcall WriteMonPartySpriteOAMByPartyIndex ; place the appropriate pokemon icon
	ldh a, [hPartyMonIndex]
	ld [wWhichPokemon], a
	inc a
	ldh [hPartyMonIndex], a
	call LoadMonData
	pop hl
	push hl
	ld a, [wMenuItemToSwap]
	and a ; is the player swapping pokemon positions?
	jr z, .skipUnfilledRightArrow
; if the player is swapping pokemon positions
	dec a
	ld b, a
	ld a, [wWhichPokemon]
	cp b ; is the player swapping the current pokemon in the list?
	jr nz, .skipUnfilledRightArrow
; the player is swapping the current pokemon in the list
	dec hl
	dec hl
	dec hl
	ld a, '▷' ; unfilled right arrow menu cursor
	ld [hli], a ; place the cursor
	inc hl
	inc hl
.skipUnfilledRightArrow
	ld a, [wPartyMenuTypeOrMessageID] ; menu type
	cp TMHM_PARTY_MENU
	jr z, .teachMoveMenu
	cp EVO_STONE_PARTY_MENU
	jr z, .evolutionStoneMenu
	push hl
	ld bc, 5 - SCREEN_WIDTH ; 1 line up and 5 columns to the right
	add hl, bc
	ld de, wLoadedMonStatus
	call PrintStatusCondition
	pop hl
	push hl
	ld bc, 8 - SCREEN_WIDTH ; 1 line up and 8 columns to the right
	add hl, bc
	predef DrawHP2 ; draw HP bar and prints current / max HP
	call SetPartyMenuHPBarColor ; color the HP bar (on SGB)
	pop hl
	jr .printLevel
.teachMoveMenu
	push hl
	predef CanLearnTM ; check if the pokemon can learn the move
	pop hl
	ld de, .ableToLearnMoveText
	ld a, c
	and a
	jr nz, .placeMoveLearnabilityString
	ld de, .notAbleToLearnMoveText
.placeMoveLearnabilityString
	push hl
	ld bc, 9 ; 9 columns to the right
	add hl, bc
	call PlaceString
	pop hl
.printLevel
	ld bc, 5 ; 5 columns to the right
	add hl, bc
	call PrintLevel
	pop hl
	pop de
	inc de
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	inc c
	jp .loop
.ableToLearnMoveText
	db "おぼえられる@"
.notAbleToLearnMoveText
	db "おぼえられない@"
.evolutionStoneMenu
	push hl
	ld hl, EvosMovesPointerTable
	ld b, 0
	ld a, [wLoadedMonSpecies]
	dec a
	add a
	rl b
	ld c, a
	add hl, bc
	ld de, wEvoDataBuffer
	ld a, BANK(EvosMovesPointerTable)
	ld bc, 2
	call FarCopyData
	ld hl, wEvoDataBuffer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wEvoDataBuffer
	ld a, BANK(EvosMovesPointerTable)
	ld bc, wEvoDataBufferEnd - wEvoDataBuffer
	call FarCopyData
	ld hl, wEvoDataBuffer
	ld de, .notAbleToEvolveText
; loop through the pokemon's evolution entries
.checkEvolutionsLoop
	ld a, [hli]
	and a ; reached terminator?
	jr z, .placeEvolutionStoneString ; if so, place the "NOT ABLE" string
	inc hl
	inc hl
	cp EVOLVE_ITEM
	jr nz, .checkEvolutionsLoop
; if it's a stone evolution entry
	dec hl
	dec hl
	ld b, [hl]
	ld a, [wEvoStoneItemID] ; the stone the player used
	inc hl
	inc hl
	inc hl
	cp b ; does the player's stone match this evolution entry's stone?
	jr nz, .checkEvolutionsLoop
; if it does match
	ld de, .ableToEvolveText
.placeEvolutionStoneString
	pop hl
	push hl
	ld bc, 9 ; 9 columns to the right
	add hl, bc
	call PlaceString
	pop hl
	jr .printLevel
.ableToEvolveText
	db "つかえる@"
.notAbleToEvolveText
	db "つかえない@"
.afterDrawingMonEntries
	ld b, SET_PAL_PARTY_MENU
	call RunPaletteCommand
.printMessage
	ld hl, wStatusFlags5
	ld a, [hl]
	push af
	push hl
	set BIT_NO_TEXT_DELAY, [hl]
	ld a, [wPartyMenuTypeOrMessageID] ; message ID
	cp FIRST_PARTY_MENU_TEXT_ID
	jr nc, .printItemUseMessage
	add a
	ld hl, PartyMenuMessagePointers
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
.done
	pop hl
	pop af
	ld [hl], a
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	jp GBPalNormal
.printItemUseMessage
	and $0F
	ld hl, PartyMenuItemUseMessagePointers
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, [wUsedItemOnWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	pop hl
	call PrintText
	jr .done

PartyMenuItemUseMessagePointers:
	dw AntidoteText
	dw BurnHealText
	dw IceHealText
	dw AwakeningText
	dw ParlyzHealText
	dw PotionText
	dw FullHealText
	dw ReviveText
	dw RareCandyText

PartyMenuMessagePointers:
	dw PartyMenuNormalText
	dw PartyMenuItemUseText
	dw PartyMenuBattleText
	dw PartyMenuUseTMText
	dw PartyMenuSwapMonText
	dw PartyMenuItemUseText

PartyMenuNormalText:
	text "#を　えらんで　ください"
	done

PartyMenuItemUseText:
	text "どの#に　つかいますか？"
	done

PartyMenuBattleText:
	text "どの#を　だしますか？"
	done

PartyMenuUseTMText:
	text "どの#に　おしえますか？"
	done

PartyMenuSwapMonText:
	text "どこに　いどうしますか？"
	done

PotionText:
	text_ram wNameBuffer
	text "の　たいりょくが"
	line "@"
	text_decimal wHPBarHPDifference, 2, 3
	text "　かいふくした"
	done

AntidoteText:
	text_ram wNameBuffer
	text "の　どくは"
	line "きれい　さっぱり　なくなった！"
	done

ParlyzHealText:
	text_ram wNameBuffer
	text "の　からだの"
	line "しびれが　とれた"
	done

BurnHealText:
	text_ram wNameBuffer
	text "の"
	line "やけどが　なおった"
	done

IceHealText:
	text_ram wNameBuffer
	text "の　からだの"
	line "こおりが　とけた"
	done

AwakeningText:
	text_ram wNameBuffer
	text "は"
	line "めを　さました"
	done

FullHealText:
	text_ram wNameBuffer
	text "は"
	line "けんこうになった！"
	done

ReviveText:
	text_ram wNameBuffer
	text "は"
	line "げんきを　とりもどした！"
	done

RareCandyText:
	text_ram wNameBuffer
	text "の　レベルが@"
	text_decimal wCurEnemyLevel, 1, 3
	text "になった@"
	sound_get_item_1 ; probably supposed to play SFX_LEVEL_UP but the wrong music bank is loaded
	text_promptbutton
	text_end

SetPartyMenuHPBarColor:
	ld hl, wPartyMenuHPBarColors
	ld a, [wWhichPartyMenuHPBar]
	ld c, a
	ld b, 0
	add hl, bc
	call GetHealthBarColor
	ld b, SET_PAL_PARTY_MENU_HP_BARS
	call RunPaletteCommand
	ld hl, wWhichPartyMenuHPBar
	inc [hl]
	ret
