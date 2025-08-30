CopyDebugName:
	ld bc, NAME_LENGTH
	jp CopyData

PrepareTitleScreen::
; These debug names are already copied later in PrepareOakSpeech.
; Removing the unused copies below has no apparent impact.
; CopyDebugName can also be safely deleted afterwards.
	ld hl, DebugNewGamePlayerName
	ld de, wPlayerName
	call CopyDebugName
	ld hl, DebugNewGameRivalName
	ld de, wRivalName
	call CopyDebugName
	xor a
	ldh [hWY], a
	ld [wLetterPrintingDelayFlags], a
	ld hl, wStatusFlags6
	ld [hli], a
	ASSERT wStatusFlags6 + 1 == wStatusFlags7
	ld [hli], a
	ASSERT wStatusFlags7 + 1 == wElite4Flags
	ld [hl], a
	ld a, BANK(Music_TitleScreen)
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a

DisplayTitleScreen:
	call GBPalWhiteOut
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	xor a
	ldh [hTileAnimations], a
	ld a, $90
	ldh [hSCX], a
	ld a, $90
	ldh [hWY], a
	call ClearScreen
	call DisableLCD
	call LoadFontTilePatterns
	ld hl, NintendoCopyrightLogoGraphics
	ld de, vTitleLogo2 tile 16
	ld bc, 13 tiles
	ld a, BANK(NintendoCopyrightLogoGraphics)
	call FarCopyData2
	ld hl, PokemonLogoGraphics
	ld de, vTitleLogo
	ld bc, $60 tiles
	ld a, BANK(PokemonLogoGraphics)
	call FarCopyData2          ; first chunk
	ld hl, PokemonLogoGraphics tile $60
	ld de, vTitleLogo2
	ld bc, $10 tiles
	ld a, BANK(PokemonLogoGraphics)
	call FarCopyData2          ; second chunk
	ld hl, Version_GFX
	ld de, vChars2 tile $60
	ld bc, Version_GFXEnd - Version_GFX
	ld a, BANK(Version_GFX)
	call FarCopyDataDouble
	call ClearBothBGMaps

; place tiles for pokemon logo (except for the last row)
	hlcoord 2, 1
	ld a, $80
	ld de, SCREEN_WIDTH
	ld c, 6
.pokemonLogoTileLoop
	ld b, $10
	push hl
.pokemonLogoTileRowLoop ; place tiles for one row
	ld [hli], a
	inc a
	dec b
	jr nz, .pokemonLogoTileRowLoop
	pop hl
	add hl, de
	dec c
	jr nz, .pokemonLogoTileLoop

; place tiles for the last row of the pokemon logo
	hlcoord 2, 7
	ld a, $31
	ld b, $10
.pokemonLogoLastTileRowLoop
	ld [hli], a
	inc a
	dec b
	jr nz, .pokemonLogoLastTileRowLoop

	call DrawPlayerCharacter

; place tiles for title screen copyright
	hlcoord 3, 17
	ld a, $41
	ld b, $0D
.tileScreenCopyrightTilesLoop
	ld [hli], a
	inc a
	dec b
	jr nz, .tileScreenCopyrightTilesLoop

	call SaveScreenTilesToBuffer2
	call PrintGameVersionOnTitleScreen
	call SaveScreenTilesToBuffer1
	call LoadScreenTilesFromBuffer2
	call EnableLCD

IF DEF(_RED)
	ld a, STARTER1 ; which Pokemon to show first on the title screen
ENDC
IF DEF(_GREEN)
	ld a, STARTER3 ; which Pokemon to show first on the title screen
ENDC
	ld [wTitleMonSpecies], a
	call LoadTitleMonSprite

	ld a, HIGH(vBGMap0 + $300)
	call TitleScreenCopyTileMapToVRAM
	ld a, $40
	ldh [hWY], a
	ld a, HIGH(vBGMap0)
	call TitleScreenCopyTileMapToVRAM
	ld b, SET_PAL_TITLE_SCREEN
	call RunPaletteCommand
	call GBPalNormal
	ld a, %11100100
	ldh [rOBP0], a

	ld a, SFX_INTRO_WHOOSH
	call PlaySound

; Scrolls the Pocket Monsters title in from the right
.scrollTitleScreenLogoLoop
	call DelayFrame
	ldh a, [hSCX]
	add 4
	ldh [hSCX], a
	jr nz, .scrollTitleScreenLogoLoop

	ld a, $90
	ldh [hWY], a
	ld c, $14
	call DelayFrames
	call PrintGameVersionOnTitleScreen
	call Delay3

	ld a, HIGH(vBGMap1)
	call TitleScreenCopyTileMapToVRAM
	call LoadScreenTilesFromBuffer1
	call Delay3
	ld a, MUSIC_TITLE_SCREEN
	ld [wNewSoundID], a
	call PlaySound

; Keep scrolling in new mons indefinitely until the user performs input.
.awaitUserInterruptionLoop
	ld c, $ff
	call CheckForUserInterruption
	jr c, .finishedWaiting
	call TitleScreenScrollInMon
	call TitleScreenPickNewMon
	jr .awaitUserInterruptionLoop

.finishedWaiting
	ld a, [wTitleMonSpecies]
	call PlayCry
	call WaitForSoundToFinish
	call GBPalWhiteOutWithDelay3
	call ClearSprites
	xor a
	ldh [hWY], a
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	ld a, HIGH(vBGMap0)
	call TitleScreenCopyTileMapToVRAM
	ld a, HIGH(vBGMap1)
	call TitleScreenCopyTileMapToVRAM
	call Delay3
	call LoadGBPal
	ldh a, [hJoyHeld]
	ld b, a
	and PAD_UP | PAD_SELECT | PAD_B
	cp PAD_UP | PAD_SELECT | PAD_B
	jp z, .doClearSaveDialogue
	jp MainMenu

.doClearSaveDialogue
	farjp DoClearSaveDialogue

TitleScreenPickNewMon:
	ld a, HIGH(vBGMap0)
	call TitleScreenCopyTileMapToVRAM

.loop
; Keep looping until a mon different from the current one is picked.
	call Random
	and $f
	ld c, a
	ld b, 0
	ld hl, TitleMons
	add hl, bc
	ld a, [hl]
	ld hl, wTitleMonSpecies

; Can't be the same as before.
	cp [hl]
	jr z, .loop

	ld [hl], a
	call LoadTitleMonSprite

	ld a, $90
	ldh [hWY], a
	ld d, $a0
	ld c, $c
	jp TitleScroll

TitleScreenScrollInMon:
	ld d, 0
	ld c, $14
	call TitleScroll
	xor a
	ldh [hWY], a
	ret

TitleScroll:
	ld h, d
	ld l, $48
	call ScrollBetween

	ld h, $00
	ld l, $88
	call ScrollBetween

	ld a, d
	add 8
	ld d, a
	dec c
	jr nz, TitleScroll
	ret

ScrollBetween:
.wait
	ldh a, [rLY]
	cp l
	jr nz, .wait

	ld a, h
	ldh [rSCX], a

.wait2
	ldh a, [rLY]
	cp h
	jr z, .wait2
	ret

DrawPlayerCharacter:
	ld hl, PlayerCharacterTitleGraphics
	ld de, vSprites
	ld bc, PlayerCharacterTitleGraphicsEnd - PlayerCharacterTitleGraphics
	ld a, BANK(PlayerCharacterTitleGraphics)
	call FarCopyData2
	call ClearSprites
	xor a
	ld [wPlayerCharacterOAMTile], a
	ld hl, wShadowOAM
	lb de, $60, $30
	ld b, 7
.loop
	push de
	ld c, 5
.innerLoop
	ld a, d
	ld [hli], a ; Y
	ld a, e
	ld [hli], a ; X
	add 8
	ld e, a
	ld a, [wPlayerCharacterOAMTile]
	ld [hli], a ; tile
	inc a
	ld [wPlayerCharacterOAMTile], a
	inc hl
	dec c
	jr nz, .innerLoop
	pop de
	ld a, 8
	add d
	ld d, a
	dec b
	jr nz, .loop
	ret

ClearBothBGMaps:
	ld hl, vBGMap0
	ld bc, $400 * 2
	ld a, "　"
	jp FillMemory

LoadTitleMonSprite:
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	hlcoord 9, 10
	call GetMonHeader
	jp LoadFrontSpriteByMonIndex

TitleScreenCopyTileMapToVRAM:
	ld [hAutoBGTransferDest + 1], a
	jp Delay3

LoadCopyrightAndTextBoxTiles:
	xor a
	ldh [hWY], a
	call ClearScreen
	call LoadTextBoxTilePatterns

LoadCopyrightTiles:
	ld de, NintendoCopyrightLogoGraphics
	ld hl, vChars2 tile $60
	lb bc, BANK(NintendoCopyrightLogoGraphics), (NintendoCopyrightLogoGraphicsEnd - NintendoCopyrightLogoGraphics) / $10
	call CopyVideoData
	hlcoord 5, 7
	ld de, CopyrightTextString
	jp PlaceString

CopyrightTextString:
	db   $60, $61, $62, $63, $6D, $6E, $6F, $70, $71, $72                ; ©1995 Nintendo
	next $60, $61, $62, $63, $73, $74, $75, $76, $77, $78, $6B, $6C      ; ©1995 Creatures Inc.
	next $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C ; ©1995 GAME FREAK Inc.
	db   "@"

INCLUDE "data/pokemon/title_mons.asm"

; prints version text (red, green)
PrintGameVersionOnTitleScreen:
IF DEF(_RED)
	hlcoord 7, 8
ENDC
IF DEF(_GREEN)
	hlcoord 6, 8
ENDC
	ld de, VersionOnTitleScreenText
	jp PlaceString

; these point to special tiles specifically loaded for that purpose and are not usual text
VersionOnTitleScreenText:
IF DEF(_RED)
	db $60, $61, $7F, $65, $66, $67, $68, $69, "@" ; "Red Version"
ENDC
IF DEF(_GREEN)
	db $62, $63, $64, $7F, $65, $66, $67, $68, $69, "@" ; "Green Version"
ENDC

DebugNewGamePlayerName:
	db "やまぐち@"

DebugNewGameRivalName:
	db "いしはら@"
