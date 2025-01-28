Trade_PrintPlayerMonInfoText:
	hlcoord 6, 0
	ld de, Trade_MonInfoText
	call PlaceString
	ld a, [wTradedPlayerMonSpecies]
	ld [wPokedexNum], a
	predef IndexToPokedex
	hlcoord 10, 0
	ld de, wPokedexNum
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber
	hlcoord 6, 2
	ld de, wStringBuffer
	call PlaceString
	hlcoord 9, 4
	ld de, wTradedPlayerMonOT
	call PlaceString
	hlcoord 9, 6
	ld de, wTradedPlayerMonOTID
	lb bc, LEADING_ZEROES | 2, 5
	jp PrintNumber

Trade_PrintEnemyMonInfoText:
	hlcoord 6, 10
	ld de, Trade_MonInfoText
	call PlaceString
	ld a, [wTradedEnemyMonSpecies]
	ld [wPokedexNum], a
	predef IndexToPokedex
	hlcoord 10, 10
	ld de, wPokedexNum
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber
	hlcoord 6, 12
	ld de, wNameBuffer
	call PlaceString
	hlcoord 9, 14
	ld de, wTradedEnemyMonOT
	call PlaceString
	hlcoord 9, 16
	ld de, wTradedEnemyMonOTID
	lb bc, LEADING_ZEROES | 2, 5
	jp PrintNumber

Trade_MonInfoText:
	db   "──№．"
	next ""
	next "おや／"
	next "<ID>№．@"
