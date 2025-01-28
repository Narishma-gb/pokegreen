ConversionEffect_:
	ld hl, wEnemyMonType1
	ld de, wBattleMonType1
	ldh a, [hWhoseTurn]
	and a
	ld a, [wEnemyBattleStatus1]
	jr z, .conversionEffect
	push hl
	ld h, d
	ld l, e
	pop de
	ld a, [wPlayerBattleStatus1]
.conversionEffect
	bit INVULNERABLE, a ; is mon immune to typical attacks (dig/fly)
	jr nz, PrintButItFailedText
; copy target's types to user
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	callfar PlayCurrentMoveAnimation
	ld hl, ConvertedTypeText
	jp PrintText

ConvertedTypeText:
	text "<TARGET>の　ぞくせいを"
	line "じぶんに　はりつけた！"
	prompt

PrintButItFailedText:
	jpfar PrintButItFailedText_
