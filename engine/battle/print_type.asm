IF DEF(_REV0)
UnusedSerialFunction:
	ld a, [wLinkState]
	bit 7, a
	ret z
	ld a, [wUnknownSerialCounter3]
	dec a
	ld [wUnknownSerialCounter3], a
	ret nz
	ld a, [wUnknownSerialCounter3 + 1]
	dec a
	ld [wUnknownSerialCounter3 + 1], a
	ret nz
	ld a, $0a
	ld [wUnknownSerialCounter3 + 1], a
	ld a, [wUnknownSerialByte]
	xor $01
	ld [wUnknownSerialByte], a
	jp z, LoadScreenTilesFromBuffer1
	; bug: fallthrough
ENDC

; [wCurSpecies] = pokemon ID
; hl = dest addr
PrintMonType:
	call GetPredefRegisters
	push hl
	call GetMonHeader
	pop hl
	push hl
	ld a, [wMonHType1]
	call PrintType
	ld a, [wMonHType1]
	ld b, a
	ld a, [wMonHType2]
	cp b
	pop hl
	jr z, EraseType2Text
	ld bc, SCREEN_WIDTH * 2
	add hl, bc

; a = type
; hl = dest addr
PrintType:
	push hl
	jr PrintType_

; erase "タイプ２／" if the mon only has 1 type
EraseType2Text:
	ld a, '　'
	ld bc, SCREEN_WIDTH - 3
	add hl, bc
	ld [hl], a ; erase the Handakuten in  タイプ
	inc bc ; SCREEN_WIDTH - 2
	add hl, bc
	ld bc, 5
	jp FillMemory

PrintMoveType:
	call GetPredefRegisters
	push hl
	ld a, [wPlayerMoveType]
; fall through

PrintType_:
	add a
	ld hl, TypeNames
	ld e, a
	ld d, $0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	jp PlaceString

INCLUDE "data/types/names.asm"
