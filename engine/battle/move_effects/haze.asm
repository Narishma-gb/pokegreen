HazeEffect_:
	ld a, $7
; store 7 on every stat mod
	ld hl, wPlayerMonStatMods
	call ResetStatMods
	ld hl, wEnemyMonStatMods
	call ResetStatMods
; copy unmodified stats to battle stats
	ld hl, wPlayerMonUnmodifiedAttack
	ld de, wBattleMonAttack
	call ResetStats
	ld hl, wEnemyMonUnmodifiedAttack
	ld de, wEnemyMonAttack
	call ResetStats
; cure non-volatile status, but only for the target
	ld hl, wEnemyMonStatus
	ld de, wEnemySelectedMove
	ldh a, [hWhoseTurn]
	and a
	jr z, .cureStatuses
	ld hl, wBattleMonStatus
	dec de ; wPlayerSelectedMove

.cureStatuses
	ld a, [hl]
	ld [hl], $0
IF DEF(_REV0)
	and SLP_MASK
ENDC
IF DEF(_REV1)
	and (1 << FRZ) | SLP_MASK
ENDC
	jr z, .cureVolatileStatuses
; prevent the Pokemon from executing a move if it was asleep or frozen
	ld a, $ff
	ld [de], a

.cureVolatileStatuses
	xor a
	ld [wPlayerDisabledMove], a
	ld [wEnemyDisabledMove], a
	ld hl, wPlayerDisabledMoveNumber
	ld [hli], a
	ld [hl], a ; wEnemyDisabledMoveNumber
	ld hl, wPlayerBattleStatus1
	res CONFUSED, [hl]
	inc hl
	ld a, [hl] ; wPlayerBattleStatus2
	; clear USING_X_ACCURACY, PROTECTED_BY_MIST, GETTING_PUMPED, and SEEDED statuses
	and ~((1 << USING_X_ACCURACY) | (1 << PROTECTED_BY_MIST) | (1 << GETTING_PUMPED) | (1 << SEEDED))
	ld [hli], a
	ld a, [hl] ; wPlayerBattleStatus3
	; clear Bad Poison, Reflect and Light Screen statuses
	and ~((1 << BADLY_POISONED) | (1 << HAS_LIGHT_SCREEN_UP) | (1 << HAS_REFLECT_UP))
	ld [hl], a
	ld hl, wEnemyBattleStatus1
	res CONFUSED, [hl]
	inc hl
	ld a, [hl] ; wEnemyBattleStatus2
	; clear USING_X_ACCURACY, PROTECTED_BY_MIST, GETTING_PUMPED, and SEEDED statuses
	and ~((1 << USING_X_ACCURACY) | (1 << PROTECTED_BY_MIST) | (1 << GETTING_PUMPED) | (1 << SEEDED))
	ld [hli], a
	ld a, [hl] ; wEnemyBattleStatus3
	; clear Bad Poison, Reflect and Light Screen statuses
	and ~((1 << BADLY_POISONED) | (1 << HAS_LIGHT_SCREEN_UP) | (1 << HAS_REFLECT_UP))
	ld [hl], a
	callfar PlayCurrentMoveAnimation
	ld hl, StatusChangesEliminatedText
	jp PrintText

ResetStatMods:
	ld b, $8
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

ResetStats:
	ld b, $8
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret

StatusChangesEliminatedText:
	text "すべての　ステータスが"
	line "もとに　もどった！"
	prompt
