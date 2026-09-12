UpdateBorderParty:
	ld hl, wLastCaughtList
	ld de, wLastPartyDrawn
	ld a, [wSGBBorderOption]
	and a
	jr z, .ok
	ld hl, wPartySpecies
.ok
	push hl
	ld c, PARTY_LENGTH
.loop
	ld a, [hli]
	ld b, a
	ld a, [de]
	inc de
	cp b
	jr nz, .new
	dec c
	jr nz, .loop
; no change
	pop hl
	and a
	ret
.new
	pop hl
	ld de, wLastPartyDrawn
	ld bc, PARTY_LENGTH
	call CopyData
	scf
	ret

NewGameInitBorderParty:
	call DelayFrame
	ld a, 1
	ld [wForceBorderRedraw], a
	xor a
	ld hl, wLastPartyDrawn
	call .ClearParty
	ld hl, wLastCaughtList
	call .ClearParty
	ld hl, wPartySpecies
	; fallthrough

.ClearParty:
	ld c, PARTY_LENGTH
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

SGBAddCaughtMonEvo:
	push hl
	push bc
	push de
	ld a, [wCurSpecies]
	jr SGBAddCaughtMonCommon

SGBAddCaughtMon:
	push hl
	push bc
	push de
	ld a, [wCurPartySpecies]
	;fallthrough
SGBAddCaughtMonCommon:
	ld b, a
	call CheckCaughtDuplicate
	jr z, .done
; shift down the list, add new caught mon
	ld c, 5
	ld hl, wLastCaughtList + 4
	ld de, wLastCaughtList + 5
.shift
	ld a, [hld]
	ld [de], a
	dec de
	dec c
	jr nz, .shift
	ld a, b
	ld [wLastCaughtList], a
.done
	pop de
	pop bc
	pop hl
	ret

CheckCaughtDuplicate:
	ld c, 6
	ld hl, wLastCaughtList
.loop
	ld a, [hli]
	cp b
	ret z
	dec c
	jr nz, .loop
	ld a, 1
	and a
	ret

CheckFullCaughtList: ; unreferenced
	ld c, 6
	ld hl, wLastCaughtList
.loop
	ld a, [hli]
	and a
	ret z
	dec c
	jr nz, .loop
	ld a, 1
	and a
	ret

InitLastCaughtList: ; unreferenced
	ld c, 6
	ld hl, wLastCaughtList
	xor a
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

LoadSaveRedrawBorder:
	ld a, [wSaveFileStatus]
	cp 2
	ret nz
	dec a
	ld [wForceBorderRedraw], a
	call UpdateBorderParty
	ret
