BorderPalettes:
INCLUDE "data/sgb/sgb_tilemap.asm"

	ds $100 ; padding

IF DEF(_RED)
	RGB 30,29,29 ; PAL_SGB4
	RGB 30,29,29
	RGB 21,21,21
	RGB 03,02,02

	RGB  0, 0, 0 ; unused
	RGB 25,22,25
	RGB 25,17,21
	RGB 24,14,12

ELIF DEF(_GREEN)
	RGB 30,29,29 ; PAL_SGB4
	RGB 30,29,29
	RGB 21,21,21
	RGB 03,02,02

	RGB  0, 0, 0 ; unused
	RGB 25,31,18
	RGB 18,25,12
	RGB 12,20,09
ENDC
	ds $10 ; unused

; Kabuto has one non-standard palette where color White is absent

IF DEF(_RED)
	RGB 30,29,29 ; PAL_SGB5
	RGB 31, 6, 0 ; Kabuto
	RGB 03,02,02
	RGB 30,29,29

ELIF DEF(_GREEN)
	RGB 30,29,29 ; PAL_SGB5
	RGB 31, 6, 0 ; Kabuto
	RGB 03,02,02
	RGB 30,29,29
ENDC
	ds $18 ; dynamically set

IF DEF(_RED)
	RGB 30,29,29 ; PAL_SGB6
	RGB 31, 6, 0 ; Kabuto
	RGB 03,02,02
	RGB 30,29,29

ELIF DEF(_GREEN)
	RGB 30,29,29 ; PAL_SGB6
	RGB 31, 6, 0 ; Kabuto
	RGB 03,02,02
	RGB 30,29,29
ENDC
	ds $18 ; dynamically set

SGBBorderGraphics:
IF DEF(_RED)
	INCBIN "gfx/sgb/red_border_tiles.2bpp"
ENDC
IF DEF(_GREEN)
	INCBIN "gfx/sgb/green_border_tiles.2bpp"
ENDC

DebugRandomizeLastCaught:: ; unreferenced
	ld e, 6
	ld hl, wLastCaughtList
	xor a
.clear_loop
	ld [hli], a
	dec e
	jr nz, .clear_loop

	ld e, 6
	ld hl, wLastCaughtList
.loop
	push hl
.random
	call Random
	ldh a, [hRandomAdd]
	ld b, a
	cp NUM_POKEMON_INDEXES + 1
	jr nc, .random
	call CheckLegit
	jr c, .random
	call .CheckDuplicate
	jr z, .random
	ld a, b
	pop hl
	ld [hli], a
	dec e
	jr nz, .loop
	ret

.CheckDuplicate:
	ld d, 6
	ld hl, wLastCaughtList
.loop2
	ld a, [hli]
	cp b
	ret z
	dec d
	jr nz, .loop2
	ld a, 1
	and a
	ret
