SetDebugNewGameParty: ; unreferenced except in _DEBUG
	ld de, DebugNewGameParty
.loop
	ld a, [de]
	cp -1
	ret z
	ld [wCurPartySpecies], a
	inc de
	ld a, [de]
	ld [wCurEnemyLevel], a
	inc de
	call AddPartyMon
	jr .loop

DebugNewGameParty:
	; Exeggutor is the only debug party member shared with Red, Green, and Japanese Blue.
	; "Tsunekazu Ishihara: Exeggutor is my favorite. That's because I was
	; always using this character while I was debugging the program."
	; From https://web.archive.org/web/20000607152840/http://pocket.ign.com/news/14973.html
	db EXEGGUTOR, 90
	db EKANS, 90
	db RHYDON, 5
	db -1 ; end

PrepareNewGameDebug: ; dummy except in _DEBUG
IF DEF(_DEBUG)
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a

	; Fly anywhere.
	dec a ; $ff (all bits)
	ld [wTownVisitedFlag], a
	ld [wTownVisitedFlag + 1], a

	; Get all badges except Earth Badge.
	ld a, ~(1 << BIT_EARTHBADGE)
	ld [wObtainedBadges], a

	call SetDebugNewGameParty

	; Exeggutor gets four HM moves.
	ld hl, wPartyMon1Moves
	ld a, FLY
	ld [hli], a
	ld a, CUT
	ld [hli], a
	ld a, SURF
	ld [hli], a
	ld a, STRENGTH
	ld [hl], a
	ld hl, wPartyMon1PP
	ld a, 15
	ld [hli], a
	ld a, 30
	ld [hli], a
	ld a, 15
	ld [hli], a
	ld [hl], a

	; Get some debug items.
	ld hl, wNumBagItems
	ld de, DebugNewGameItemsList
.items_loop
	ld a, [de]
	cp -1
	jr z, .items_end
	ld [wCurItem], a
	inc de
	ld a, [de]
	inc de
	ld [wItemQuantity], a
	call AddItemToInventory
	jr .items_loop
.items_end

	; Get some debug items in PC.
	ld hl, wNumBoxItems
	ld de, DebugNewGamePCItemsList
.pc_items_loop
	ld a, [de]
	cp -1
	jr z, .pc_items_end
	ld [wCurItem], a
	inc de
	ld a, [de]
	inc de
	ld [wItemQuantity], a
	call AddItemToInventory
	jr .pc_items_loop
.pc_items_end

	; fill box 1 with Mewtwo.
	; Its stats will be copied from the first party mon (Lv 90 Exeggutor)
	xor a
	ld [wWhichPokemon], a
	inc a
	ld [wMoveMonType], a
	ld a, MEWTWO
	ld [wCurPartySpecies], a
	ld b, MONS_PER_BOX

.addMon
	push bc
	call MoveMon
	pop bc
	dec b
	jr nz, .addMon

	; edit the box Mewtwo's moves: go through all moves from Pound to Thundershock,
	; giving 4 to each of the 21 first box mons
	lb bc, POUND, 21
	ld hl, wBoxMon1Moves
	ld de, wBoxMon2Moves - wBoxMon1OTID

.mon_loop
	ld a, NUM_MOVES

.set_moves_loop
	ld [hl], b
	inc hl
	inc b
	dec a
	jr nz, .set_moves_loop

	add hl, de
	dec c
	jr nz, .mon_loop


	; Complete the Pokédex.
	ld hl, wPokedexOwned
	call DebugSetPokedexEntries
	ld hl, wPokedexSeen
	call DebugSetPokedexEntries
	SetEvent EVENT_GOT_POKEDEX

	; Rival chose Squirtle,
	; Player chose Charmander.
	ld hl, wRivalStarter
	ASSERT wRivalStarter + 2 == wPlayerStarter
	ld a, STARTER2
	ld [hli], a
	inc hl
	ld a, STARTER1
	ld [hl], a

	ret

DebugSetPokedexEntries:
IF NUM_POKEMON / 8
	ld b, NUM_POKEMON / 8 ; 151 / 8 == 18
	ld a, %11111111
.loop
	ld [hli], a
	dec b
	jr nz, .loop
ENDC
IF NUM_POKEMON % 8
	ld [hl], (1 << (NUM_POKEMON % 8)) - 1 ; (1 << 151 % 8)) - 1 == %01111111
ENDC
	ret

DebugNewGameItemsList:
	db BICYCLE, 1
	db FULL_RESTORE, 99
	db FULL_HEAL, 99
	db ESCAPE_ROPE, 99
	db RARE_CANDY, 99
	db MASTER_BALL, 99
	db TOWN_MAP, 1
	db SECRET_KEY, 1
	db CARD_KEY, 1
	db S_S_TICKET, 1
	db LIFT_KEY, 1
	db -1 ; end

DebugNewGamePCItemsList:
	db	OLD_AMBER, 1
	db	DOME_FOSSIL, 1
	db	HELIX_FOSSIL, 1
	db	X_ACCURACY, 99
	db	DIRE_HIT, 99
	db	FRESH_WATER, 1
	db	GOLD_TEETH, 1
	db	COIN_CASE, 1
	db	SILPH_SCOPE, 1
	db	POKE_FLUTE, 1
	db	MAX_ETHER, 99
	db	ELIXER, 99
	db	MAX_ELIXER, 99
	db -1 ; end
ELSE
	ret
ENDC
