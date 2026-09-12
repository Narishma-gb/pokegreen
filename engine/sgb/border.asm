ReloadSGBBorder::
	push af
	push bc
	push de
	push hl

	ld a, [wOnSGB]
	and a
	jp z, .done
	ld a, [wForceBorderRedraw]
	and a
	jr nz, .start
	callfar UpdateBorderParty
	jp nc, .done

.start
	di
	xor a
	ldh [rIF], a
	inc a
	ldh [hUseTimer], a
	ld a, IE_TIMER
	ldh [rIE], a
	ld a, TAC_START | TAC_4KHZ
	ld [rTAC], a
	ld a, 188
	ld [rTMA], a
	ei
	ld hl, MaskEnFreezePacket
	call SendSGBPacket
	call BorderDisableLCD
	ldh a, [rLCDC]
	push af
	ld a, LCDC_OFF | LCDC_WIN_9C00 | LCDC_WIN_OFF | LCDC_BLOCK21 | LCDC_BG_9800 | LCDC_OBJ_8 | LCDC_OBJ_OFF | LCDC_BG_ON
	ldh [rLCDC], a
	ldh a, [rBGP]
	push af
	ld a, $e4
	ldh [rBGP], a
	ldh a, [rWX]
	ld b, a
	ldh a, [rWY]
	ld c, a
	push bc
	ldh a, [rSCX]
	ld b, a
	ldh a, [rSCY]
	ld c, a
	push bc
	xor a
	ldh [rWX], a
	ldh [rWY], a
	ldh [rSCX], a
	ldh [rSCY], a

	ld a, [wSGBReloadTileset]
	and a
	jr z, .skip
	call BackupBGMap0

.skip
	call LoadLZDecompressor

	ld de, vChars1
	ld hl, SGBBorderGraphics
	ld bc, 80 tiles
	call CopyData

	call BuildSGBTiles0
	call DisplayVRAMTileData
	call EnableLCD
	ld hl, ChrTrn0Packet
	call SendSGBPacket

	call BorderDisableLCD
	call BuildSGBTiles1
	call DisplayVRAMTileData
	call EnableLCD
	ld hl, ChrTrn1Packet
	call SendSGBPacket

	call BorderDisableLCD
	ld de, vChars1
	ld hl, BorderPalettes
	ld bc, 134 tiles
	call CopyData

	call BuildSGBTilemap
	call DisplayVRAMTileData
	call EnableLCD
	ld hl, PctTrnPacket
	call SendSGBPacket

	call BorderDisableLCD
	call BorderClearVram

	ld a, [wSGBReloadTileset]
	and a
	jr z, .skip2
	push af
	call LoadTilesetTilePatternData
	call RestoreBGMap0
	pop af
	dec a ; start menu?
	jr z, .skip2
; Bill's PC
	call LoadFontTilePatterns
	call LoadHpBarAndStatusTilePatterns

.skip2
	pop bc
	ld a, b
	ldh [rSCX], a
	ld a, c
	ldh [rSCY], a
	pop bc
	ld a, b
	ldh [rWX], a
	ld a, c
	ldh [rWY], a
	pop af
	ldh [rBGP], a
	pop af
	ldh [rLCDC], a
	call EnableLCD
	ld hl, MaskEnCancelPacket
	call SendSGBPacket
	di
	xor a
	ldh [hUseTimer], a
	ldh [rIF], a
	ld a, TAC_STOP
	ld [rTAC], a
	ld a, IE_VBLANK | IE_TIMER | IE_SERIAL
	ldh [rIE], a
	ei

.done
	xor a
	ld [wForceBorderRedraw], a
	ld [wSGBReloadTileset], a
	pop hl
	pop de
	pop bc
	pop af
	ret

BorderDisableLCD:
	di
	ldh a, [rIE]
	res B_IE_VBLANK, a
	set B_IE_STAT, a
	ldh [rIE], a

	ldh a, [rIF]
	res B_IF_VBLANK, a
	ldh [rIF], a

	ldh a, [rSTAT]
	set B_STAT_MODE_1, a
	ldh [rSTAT], a
	ei

.wait
	ldh a, [rLCDC]
	bit B_LCDC_ENABLE, a
	jr nz, .wait
	ret

BorderClearVram::
	ld hl, vChars1
	ld bc, vBGMap1 - vChars1
	xor a
	jp FillMemory

BackupBGMap0:
	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	xor a
	ld [rRAMB], a
	ld hl, vBGMap0
	ld de, sSGBTilemapBackup
	ld bc, TILEMAP_AREA
	call CopyData
	ld a, RAMG_SRAM_DISABLE
	ld [rRAMG], a
	ret

RestoreBGMap0:
	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	xor a
	ld [rRAMB], a
	ld hl, sSGBTilemapBackup
	ld de, vBGMap0
	ld bc, TILEMAP_AREA
	call CopyData
	ld a, RAMG_SRAM_DISABLE
	ld [rRAMG], a
	ret

BuildSGBTiles0:
	ld b, 0
	ld a, [wLastPartyDrawn]
	call BuildSGBCardTiles
	ret

BuildSGBTiles1:
	ld b, 1
	ld hl, wLastPartyDrawn + 1
.party_loop
	ld a, [hli]
	push hl
	push bc
	call BuildSGBCardTiles
	pop bc
	pop hl
	inc b
	ld a, b
	cp PARTY_LENGTH
	jr nz, .party_loop
	ret

BuildSGBCardTiles:
	ld c, a
	call CheckLegit
	ret c

	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	xor a
	ld [rRAMB], a

	ld a, c
	push bc
	call GetSGBCardPointer
	call vFarDecompress
	pop bc
	push bc

	ld hl, SGBCardTilesCoords
	call SGBGetPointer
	push hl

	ld hl, ColorRemapFunctions
	call SGBGetPointer

	pop bc
	ld de, sLZBuffer
	call .WriteMonCard

	ld a, RAMG_SRAM_DISABLE
	ld [rRAMG], a

	pop bc
	call FixKabuto
	ret

; hl = remap function
; bc = dest tiles (VRAM)
; de = 2bpp source tiles
.WriteMonCard:
	ld a, 24
.next_tile
	push af
	push hl
	call .jp_hl
	ld b, h
	ld c, l
	pop hl
	pop af
	dec a
	jr nz, .next_tile
	ret

.jp_hl
	jp hl

FixKabuto:
	ld a, c
	cp KABUTO
	ret nz
	ld hl, SGBCardTilesCoords
	call SGBGetPointer
	call RemapColorsKabuto
	ret

BuildSGBTilemap:
	ld b, 0
	ld hl, wLastPartyDrawn
.party_loop
	ld a, [hli]
	ld c, a
	push hl
	call CheckLegit
	jr c, .skip

	push bc
	ld hl, SGBCardTilemapCoords
	call SGBGetPointer
	call SGBGetCardTileID

	push hl
	call WriteCardTileIndexes
	pop hl
	pop bc

	ld a, c
	push bc
	call GetSGBCardColormap
	call WriteCardTileAttr
	pop bc

	ld a, b
	ld hl, SGBCardPalCoords
	call SGBGetPointer
	ld a, c
	push bc
	call GetSGBCardPalette
	call WriteCardPalette
	pop bc

.skip
	pop hl
	inc b
	ld a, b
	cp PARTY_LENGTH
	jr nz, .party_loop
	ret

; hl = start position (VRAM)
; a = card first tile ID
; b is preserved
WriteCardTileIndexes:
	ld d, 4
	ld c, a
.row
	ld e, 6
.col
	ld a, c
	ld [hli], a
	inc hl
	inc c
	dec e
	jr nz, .col
	push bc
	ld bc, (TILEMAP_WIDTH - 6) * 2
	add hl, bc
	pop bc
	dec d
	jr nz, .row
	ret

; hl = start position (VRAM)
; bc = pointer to card colormap
WriteCardTileAttr:
	inc hl
	ld d, 4
	ld a, [bc]
	push bc
	ld b, a
	ld c, 8
.row
	ld e, 6
.col
	ld a, b
	rlca
	ld b, a
	ld a, SGB_PAL5
	jr nc, .ok
	ld a, SGB_PAL6
.ok
	ld [hli], a
	inc hl
	dec c
	jr nz, .skip
; use next colormap byte
	pop bc
	inc bc
	ld a, [bc]
	push bc
	ld b, a
	ld c, 8
.skip
	dec e
	jr nz, .col
	push bc
	ld bc, (TILEMAP_WIDTH - 6) * 2
	add hl, bc
	pop bc
	dec d
	jr nz, .row
	pop bc
	ret

; hl = start position (VRAM)
; bc = pointer to card palette
WriteCardPalette:
	call .write_color_pair
	ld de, 14 * 2
	add hl, de
	; fallthrough
.write_color_pair:
REPT 4
	ld a, [bc]
	inc bc
	ld [hli], a
ENDR
	ret

CheckLegit:
	ld c, a
	cp NUM_POKEMON_INDEXES + 1
	jr nc, .invalid
	ld hl, InvalidMonIDs
.loop
	ld a, [hli]
	cp -1
	ret z ; valid
	cp c
	jr nz, .loop
.invalid
	scf
	ret

InvalidMonIDs:
	db $00, $1f, $20, $32, $34, $38, $3d, $3e
	db $3f, $43, $44, $45, $4f, $50, $51, $56
	db $57, $5e, $5f, $73, $79, $7a, $7f, $86
	db $87, $89, $8c, $92, $9c, $9f, $a0, $a1
	db $a2, $ac, $ae, $af, $b5, $b6, $b7, $b8
	db -1

SGBGetCardTileID:
	push bc
	push hl
	ld hl, .TilesIDs
	ld c, b
	ld b, 0
	add hl, bc
	ld a, [hl]
	pop hl
	pop bc
	ret

.TilesIDs
	db $28
	db $80
	db $98
	db $b0
	db $c8
	db $e0

SGBGetPointer:
	push bc
	ld a, b
	add a
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

SGBCardTilesCoords:
	dw vChars1 tile $50
	dw vChars1
	dw vChars1 tile $30
	dw vChars1 tile $60
	dw vChars1 tile $90
	dw vChars1 tile $c0

SGBCardTilemapCoords:
	dw vChars1 + 6 * TILEMAP_WIDTH * 2
	dw vChars1 + (6 * TILEMAP_WIDTH + SCREEN_WIDTH + 6) * 2
	dw vChars1 + 12 * TILEMAP_WIDTH * 2
	dw vChars1 + (12 * TILEMAP_WIDTH + SCREEN_WIDTH + 6) * 2
	dw vChars1 + 18 * TILEMAP_WIDTH * 2
	dw vChars1 + (18 * TILEMAP_WIDTH + SCREEN_WIDTH + 6) * 2

SGBCardPalCoords:
	dw vChars2 + (16 + 4) * COLOR_SIZE
	dw vChars2 + (16 + 6) * COLOR_SIZE
	dw vChars2 + (16 + 8) * COLOR_SIZE
	dw vChars2 + (16 + 10) * COLOR_SIZE
	dw vChars2 + (16 + 12) * COLOR_SIZE
	dw vChars2 + (16 + 14) * COLOR_SIZE

ColorRemapFunctions:
	dw RemapColors2345
	dw RemapColors2367
	dw RemapColors2389
	dw RemapColors23ab
	dw RemapColors23cd
	dw RemapColors23ef

GetSGBCardPalette:
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld bc, SGBBorderMonCardPalettes
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	ret

GetSGBCardColormap:
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add l
	ld l, a
	jr nc, .nocarry
	inc h
.nocarry
	ld bc, SGBBorderMonCardColormaps
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	ret

GetSGBCardPointer:
	ld l, a
	ld h, 0
	add hl, hl
	add l
	ld l, a
	jr nc, .nocarry
	inc h
.nocarry
	ld bc, SGBBorderMonCardPointers
	add hl, bc
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, b
	ret

; color remap functions
; bc = 4bpp dest
; de = 2bpp source

; use colors 2/3/4/5
RemapColors2345:
	ld h, b
	ld l, c
	ld bc, 14
REPT 7
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	cpl
	ld [hli], a
	push hl
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	xor a
	ld [hl], a
	pop hl
ENDR
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	cpl
	ld [hli], a
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	xor a
	ld [hli], a
	ret

; use colors 2/3/6/7
RemapColors2367:
	ld h, b
	ld l, c
	ld bc, 14
REPT 7
	ld a, [de]
	inc de
	ld [hli], a
	ld a, $ff
	ld [hli], a
	push hl
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	xor a
	ld [hl], a
	pop hl
ENDR
	ld a, [de]
	inc de
	ld [hli], a
	ld a, $ff
	ld [hli], a
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	xor a
	ld [hli], a
	ret

; use colors 2/3/8/9
RemapColors2389:
	ld h, b
	ld l, c
	ld bc, 14
REPT 7
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	cpl
	ld [hli], a
	push hl
	add hl, bc
	xor a
	ld [hli], a
	ld a, [de]
	inc de
	ld [hl], a
	pop hl
ENDR
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	cpl
	ld [hli], a
	add hl, bc
	xor a
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ret

; use colors 2/3/10/11
RemapColors23ab:
	ld h, b
	ld l, c
	ld bc, 14
REPT 7
	ld a, [de]
	inc de
	ld [hli], a
	ld a, $ff
	ld [hli], a
	push hl
	add hl, bc
	xor a
	ld [hli], a
	ld a, [de]
	inc de
	ld [hl], a
	pop hl
ENDR
	ld a, [de]
	inc de
	ld [hli], a
	ld a, $ff
	ld [hli], a
	add hl, bc
	xor a
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ret

; use colors 2/3/12/13
RemapColors23cd:
	ld h, b
	ld l, c
	ld bc, 14
REPT 7
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	cpl
	ld [hli], a
	push hl
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	ld [hl], a
	pop hl
ENDR
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	cpl
	ld [hli], a
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	ld [hli], a
	ret

; use colors 2/3/14/15
RemapColors23ef:
	ld h, b
	ld l, c
	ld bc, 14
REPT 7
	ld a, [de]
	inc de
	ld [hli], a
	ld a, $ff
	ld [hli], a
	push hl
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	ld [hl], a
	pop hl
ENDR
	ld a, [de]
	inc de
	ld [hli], a
	ld a, $ff
	ld [hli], a
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	ld [hli], a
	ret

; use colors 1/3/x/x
; hardcoded to edit only a specific set of tiles within Kabuto card
RemapColorsKabuto:
REPT 2
	ld bc, 2 * 3 tiles
	add hl, bc
	ld bc, 16
	call .remap
	call .remap
ENDR
	; fallthrough
.remap:
REPT 8
	ld a, [hli]
	cpl
	ld d, a
	push hl
	add hl, bc
	ld a, [hld]
	or [hl]
	or d
	pop hl
	and [hl]
	ld [hli], a
ENDR
	add hl, bc
	ret
