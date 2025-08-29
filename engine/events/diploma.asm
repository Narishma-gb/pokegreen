DEF CIRCLE_TILE_ID EQU $70

DisplayDiploma::
	call SaveScreenTilesToBuffer2
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	xor a
	ld [wUpdateSpritesEnabled], a
	ld hl, wStatusFlags5
	set BIT_NO_TEXT_DELAY, [hl]
	call DisableLCD
	ld hl, CircleTile
	ld de, vChars2 tile CIRCLE_TILE_ID
	ld bc, $10
	ld a, BANK(CircleTile)
	call FarCopyData2
	hlcoord 0, 0
	lb bc, 16, 18
	predef Diploma_TextBoxBorder

	ld hl, DiplomaTextPointersAndCoords
	ld c, $5
.placeTextLoop
	push bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, [hl]
	ld l, a
	call PlaceString
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .placeTextLoop
	call AdjustToPlayerNameLength
	hlcoord 14, 4
	add hl, bc
	ld de, wPlayerName
	call PlaceString
	farcall DrawPlayerCharacter

; Move the player 75 pixels right and set the priority bit so he appears
; behind the background layer.
	ld hl, wShadowOAMSprite00XCoord
	lb bc, $80, $28
.adjustPlayerGfxLoop
	ld a, [hl] ; X
	add 75
	ld [hli], a
	inc hl
	ld a, b
	ld [hli], a ; attributes
	inc hl
	dec c
	jr nz, .adjustPlayerGfxLoop

	call EnableLCD
	farcall LoadTrainerInfoTextBoxTiles
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
	call Delay3
	call GBPalNormal
	ld a, $90
	ldh [rOBP0], a
	call WaitForTextScrollButtonPress
	ld hl, wStatusFlags5
	res BIT_NO_TEXT_DELAY, [hl]
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call Delay3
	jp GBPalNormal

AdjustToPlayerNameLength:
; Calculate the position of the player's name,
; so that it ends one space before "Sama" text.
	ld hl, wPlayerName
	lb bc, HIGH(-1), 0
.loop
	ld a, [hli]
	cp "@"
	ret z
	dec c
	jr .loop

MACRO diploma_text
	dw \3
	dwcoord \1, \2
ENDM

DiplomaTextPointersAndCoords:
	; x, y, text
	diploma_text  6,  2, DiplomaText
	diploma_text  3,  4, DiplomaPlayer
	diploma_text 15,  4, DiplomaSama
	diploma_text  2,  7, DiplomaCongrats
	diploma_text 11, 15, DiplomaGameFreak

DiplomaText:
	db CIRCLE_TILE_ID, "しょうじょう", CIRCLE_TILE_ID, "@"

DiplomaPlayer:
	db "プレーヤー@"

DiplomaSama:
	db "さま@"

DiplomaCongrats:
	db   "あなたは　#ずかんを"
	next "みごと　かんせい　させました！"
	next "その　いだいな　こうせきを"
	next "しょうめい　します@"

DiplomaGameFreak:
	db "ゲームフリーク@"
