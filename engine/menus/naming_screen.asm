AskName:
	call SaveScreenTilesToBuffer1
	call GetPredefRegisters
	push hl
	ld a, [wIsInBattle]
	dec a
	hlcoord 1, 0
	ld b, 4
	ld c, 10
	call z, ClearScreenArea ; only if in wild battle
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetMonName
	ld hl, DoYouWantToNicknameText
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	pop hl
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .declinedNickname
	ld a, [wUpdateSpritesEnabled]
	push af
	xor a
	ld [wUpdateSpritesEnabled], a
	push hl
	ld a, NAME_MON_SCREEN
	ld [wNamingScreenType], a
	call DisplayNamingScreen
	ld a, [wIsInBattle]
	and a
	jr nz, .inBattle
	call ReloadMapSpriteTilePatterns
.inBattle
	call LoadScreenTilesFromBuffer1
	pop hl
	pop af
	ld [wUpdateSpritesEnabled], a
	ld a, [wStringBuffer]
	cp "@"
	ret nz
.declinedNickname
	ld d, h
	ld e, l
	ld hl, wNameBuffer
	ld bc, NAME_LENGTH
	jp CopyData

DoYouWantToNicknameText:
	text_ram wNameBuffer
	text "に"
	line "ニックネームを　つけますか？"
	done

DisplayNameRaterScreen::
	ld hl, wBuffer
	xor a
	ld [wUpdateSpritesEnabled], a
	ld a, NAME_MON_SCREEN
	ld [wNamingScreenType], a
	call DisplayNamingScreen
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	ld a, [wStringBuffer]
	cp "@"
	jr z, .playerCancelled
	ld hl, wPartyMonNicks
	ld bc, NAME_LENGTH
	ld a, [wWhichPokemon]
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wBuffer
	ld bc, NAME_LENGTH
	call CopyData
	and a
	ret
.playerCancelled
	scf
	ret

DisplayNamingScreen:
	push hl
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
	call LoadHpBarAndStatusTilePatterns
	call LoadEDTile
	farcall LoadMonPartySpriteGfx
	hlcoord 0, 4
	ld b, 11
	ld c, 18
	call TextBoxBorder
	call PrintNamingText
	ld a, 3
	ld [wTopMenuItemY], a
	ld a, 1
	ld [wTopMenuItemX], a
	ld [wLastMenuItem], a
	ld [wCurrentMenuItem], a
	ld a, $ff
	ld [wMenuWatchedKeys], a
	ld a, 8
	ld [wMaxMenuItem], a
	ld a, "@"
	ld [wStringBuffer], a
	xor a
	ld hl, wNamingScreenSubmitName
	ld [hli], a
	ld [hli], a
	ld [wAnimCounter], a
.selectReturnPoint
	call PrintAlphabet
	call GBPalNormal
.ABStartReturnPoint
	ld a, [wNamingScreenSubmitName]
	and a
	jr nz, .submitNickname
	call PrintNicknameAndUnderscores
.dPadReturnPoint
	call PlaceMenuCursor
.inputLoop
	ld a, [wCurrentMenuItem]
	push af
	farcall AnimatePartyMon_ForceSpeed1
	pop af
	ld [wCurrentMenuItem], a
	call JoypadLowSensitivity
	ldh a, [hJoyPressed]
	and a
	jr z, .inputLoop
	ld hl, .namingScreenButtonFunctions
.checkForPressedButton
	sla a
	jr c, .foundPressedButton
	inc hl
	inc hl
	inc hl
	inc hl
	jr .checkForPressedButton
.foundPressedButton
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push de
	jp hl

.submitNickname
	pop de
	ld hl, wStringBuffer
	ld bc, NAME_LENGTH
	call CopyData
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call ClearSprites
	call RunDefaultPaletteCommand
	call GBPalNormal
	xor a
	ld [wAnimCounter], a
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	ld a, [wIsInBattle]
	and a
	jp z, LoadTextBoxTilePatterns
	jpfar LoadHudTilePatterns

.namingScreenButtonFunctions
	dw .dPadReturnPoint
	dw .pressedDown
	dw .dPadReturnPoint
	dw .pressedUp
	dw .dPadReturnPoint
	dw .pressedLeft
	dw .dPadReturnPoint
	dw .pressedRight
	dw .ABStartReturnPoint
	dw .pressedStart
	dw .selectReturnPoint
	dw .pressedSelect
	dw .ABStartReturnPoint
	dw .pressedB
	dw .ABStartReturnPoint
	dw .pressedA

.pressedA_changedCase
	pop de
	ld de, .selectReturnPoint
	push de
.pressedSelect
	ld a, [wAlphabetCase]
	xor $1
	ld [wAlphabetCase], a
	ret

.pressedStart
	ld a, 1
	ld [wNamingScreenSubmitName], a
	ret

.pressedA
	ld a, [wCurrentMenuItem]
	cp 6 ; "ED" row
	jr nz, .didNotPressED
	ld a, [wTopMenuItemX]
	cp $11 ; "ED" column
	jr z, .pressedStart
.didNotPressED
	ld a, [wCurrentMenuItem]
	cp $7 ; case switch row
	jr nz, .didNotPressCaseSwitch
	ld a, [wTopMenuItemX]
	cp $1 ; case switch column
	jr z, .pressedA_changedCase
.didNotPressCaseSwitch
	ld hl, wMenuCursorLocation
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	ld a, [hl]
	ld [wNamingScreenLetter], a
	call CalcStringLength
	ld a, [wNamingScreenLetter]
	cp "゛"
	ld de, Dakutens
	jr z, .dakutensAndHandakutens
	cp "゜"
	ld de, Handakutens
	jr z, .dakutensAndHandakutens
	ld a, [wNamingScreenNameLength]
	cp NAME_LENGTH - 1
	jr c, .addLetter
	ret

.dakutensAndHandakutens
	push hl
	call DakutensAndHandakutens
	pop hl
	ret nc
	dec hl
.addLetter
	ld a, [wNamingScreenLetter]
	ld [hli], a
	ld [hl], "@"
	ld a, SFX_PRESS_AB
	call PlaySound
	ret
.pressedB
	ld a, [wNamingScreenNameLength]
	and a
	ret z
	call CalcStringLength
	dec hl
	ld [hl], "@"
	ret
.pressedRight
	ld a, [wCurrentMenuItem]
	cp $7
	ret z ; can't scroll right on bottom row
	ld a, [wTopMenuItemX]
	cp $11 ; max
	jp z, .wrapToFirstColumn
	inc a
	inc a
	jr .done
.wrapToFirstColumn
	ld a, $1
	jr .done
.pressedLeft
	ld a, [wCurrentMenuItem]
	cp $7
	ret z ; can't scroll right on bottom row
	ld a, [wTopMenuItemX]
	dec a
	jp z, .wrapToLastColumn
	dec a
	jr .done
.wrapToLastColumn
	ld a, $11 ; max
	jr .done
.pressedUp
	ld a, [wCurrentMenuItem]
	dec a
	ld [wCurrentMenuItem], a
	and a
	ret nz
	ld a, $7 ; wrap to bottom row
	ld [wCurrentMenuItem], a
	ld a, $1 ; force left column
	jr .done
.pressedDown
	ld a, [wCurrentMenuItem]
	inc a
	ld [wCurrentMenuItem], a
	cp $8
	jr nz, .wrapToTopRow
	ld a, $1
	ld [wCurrentMenuItem], a
	jr .done
.wrapToTopRow
	cp $7
	ret nz
	ld a, $1
.done
	ld [wTopMenuItemX], a
	jp EraseMenuCursor

LoadEDTile:
	ld de, ED_Tile
	ld hl, vFont tile $70
; BUG: BANK("Home") should be BANK(ED_Tile), although it coincidentally works as-is,
; due to MBC behaviour when writing $0 to MBC1RomBank
	lb bc, BANK("Home"), (ED_TileEnd - ED_Tile) / $8
	jp CopyVideoDataDouble

ED_Tile:
	INCBIN "gfx/font/ED.1bpp"
ED_TileEnd:

PrintAlphabet:
	xor a
	ldh [hAutoBGTransferEnabled], a
	ld a, [wAlphabetCase]
	and a
	ld de, HiraganaCharacters
	jr nz, .lowercase
	ld de, KatakanaCharacters
.lowercase
	hlcoord 2, 5
	lb bc, 6, 9 ; 6 rows, 9 columns
.outerLoop
	push bc
.innerLoop
	ld a, [de]
	ld [hli], a
	inc hl
	inc de
	dec c
	jr nz, .innerLoop
	ld bc, SCREEN_WIDTH + 2
	add hl, bc
	pop bc
	dec b
	jr nz, .outerLoop
	call PlaceString
	hlcoord 5, 17
	ld de, KanaInputText
	call PlaceString
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	jp Delay3

INCLUDE "data/text/kana.asm"

PrintNicknameAndUnderscores:
	call CalcStringLength
	ld a, c
	ld [wNamingScreenNameLength], a
	hlcoord 13, 1
	lb bc, 2, 5
	call ClearScreenArea
	hlcoord 13, 2
	ld de, wStringBuffer
	call PlaceString
	hlcoord 13, 3
	ld a, $76 ; underscore tile id
	ld b, 5
.placeUnderscoreLoop
	ld [hli], a
	dec b
	jr nz, .placeUnderscoreLoop
	ld a, [wNamingScreenNameLength]
	cp NAME_LENGTH - 1
	jr nz, .emptySpacesRemaining
; when all spaces are filled, force the cursor onto the ED tile
	call EraseMenuCursor
	ld a, $11 ; "ED" x coord
	ld [wTopMenuItemX], a
	ld a, $6 ; "ED" y coord
	ld [wCurrentMenuItem], a
	ld a, 4 ; keep the last underscore raised
.emptySpacesRemaining
	hlcoord 13, 3
	add l
	ld l, a
	ld [hl], $77 ; raised underscore tile id
	ret

DakutensAndHandakutens:
	push de
	call CalcStringLength
	dec hl
	ld a, [hl]
	pop hl
	ld de, $2
	call IsInArray
	ret nc
	inc hl
	ld a, [hl]
	ld [wNamingScreenLetter], a
	ret

INCLUDE "data/text/dakutens.asm"

; calculates the length of the string at wStringBuffer and stores it in c
CalcStringLength:
	ld hl, wStringBuffer
	ld c, $0
.loop
	ld a, [hl]
	cp "@"
	ret z
	inc hl
	inc c
	jr .loop

PrintNamingText:
	hlcoord 1, 2
	ld a, [wNamingScreenType]
	ld de, YourTextString
	and a
	jr z, .notNickname
	ld de, RivalsTextString
	dec a
	jr z, .notNickname
	ld a, [wCurPartySpecies]
	ld [wMonPartySpriteSpecies], a
	push af
	farcall WriteMonPartySpriteOAMBySpecies
	pop af
	ld [wNamedObjectIndex], a
	call GetMonName
	hlcoord 4, 1
	call PlaceString
	ld hl, $1
	add hl, bc
	ld [hl], "の"
	hlcoord 4, 3
	ld de, NicknameTextString
	jr .placeString
.notNickname
	call PlaceString
	ld l, c
	ld h, b
	ld de, NameTextString
.placeString
	jp PlaceString

YourTextString:
	db "あなた@"

RivalsTextString:
	db "ライバル@"

NameTextString:
	db "のなまえは？@"

NicknameTextString:
	db "ニックネームは？@"
