DebugMenu:
	ret

TestBattle: ; unreferenced debug leftover
	call GBPalNormal

	; Don't mess around with obedience.
	ld a, 1 << BIT_EARTHBADGE
	ld [wObtainedBadges], a

	ld hl, wStatusFlags7
	set BIT_TEST_BATTLE, [hl]

	; wNumBagItems and wBagItems are not initialized here,
	; and their garbage values happen to act as if EXP_ALL
	; is in the bag at the end of the test battle.
	; pokeyellow fixes this by initializing them with a
	; list of items.

	; Reset the party.
	ld hl, wPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

	; Give the player a level 20 Rhydon.
	ld a, RHYDON
	ld [wCurPartySpecies], a
	ld a, 20
	ld [wCurEnemyLevel], a
	xor a
	ld [wMonDataLocation], a
	ld [wCurMap], a
	call AddPartyMon

	; Fight against a level 20 Rhydon.
	ld a, RHYDON
	ld [wCurOpponent], a

	predef InitOpponent

	; When the battle ends, do it all again.
	; There are some graphical quirks in SGB mode.
	ld a, 1
	ld [wUpdateSpritesEnabled], a
	ldh [hAutoBGTransferEnabled], a
	jr TestBattle
