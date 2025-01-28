PrintCardKeyText:
	ld hl, SilphCoMapList
	ld a, [wCurMap]
	ld b, a
.silphCoMapListLoop
	ld a, [hli]
	cp -1
	ret z
	cp b
	jr nz, .silphCoMapListLoop
	ld a, [wTileInFrontOfPlayer]
	cp $18
	jr z, .cardKeyDoorInFrontOfPlayer
	cp $24
	jr z, .cardKeyDoorInFrontOfPlayer
	ld b, a
	ld a, [wCurMap]
	cp SILPH_CO_11F
	ret nz
	ld a, b
	cp $5e
	ret nz
.cardKeyDoorInFrontOfPlayer
	ld b, CARD_KEY
	call IsItemInBag
	jr z, .noCardKey
	tx_pre_id CardKeySuccessText
	ldh [hTextID], a
	call PrintPredefTextID
	call GetCoordsInFrontOfPlayer
	srl d
	ld a, d
	ld b, a
	ld [wCardKeyDoorY], a
	srl e
	ld a, e
	ld c, a
	ld [wCardKeyDoorX], a
	ld a, [wCurMap]
	cp SILPH_CO_11F
	jr nz, .notSilphCo11F
	ld a, $3
	jr .replaceCardKeyDoorTileBlock
.notSilphCo11F
	ld a, $e
.replaceCardKeyDoorTileBlock
	ld [wNewTileBlockID], a
	predef ReplaceTileBlock
	ld hl, wCurrentMapScriptFlags
	set BIT_CUR_MAP_LOADED_1, [hl]
	ld a, SFX_GO_INSIDE
	jp PlaySound
.noCardKey
	tx_pre_id CardKeyFailText
	ldh [hTextID], a
	jp PrintPredefTextID

INCLUDE "data/events/card_key_maps.asm"

CardKeySuccessText::
	text "<⋯>ピンポーン！@"
	sound_get_item_1
	text_start
	line "カードキーで　ロック　をはずした！"
	done

CardKeyFailText::
	text "<⋯>だめだ！"
	line "カードキーが　ないと　あかない！"
	done

; d = Y
; e = X
GetCoordsInFrontOfPlayer:
	ld a, [wYCoord]
	ld d, a
	ld a, [wXCoord]
	ld e, a
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a
	jr nz, .notFacingDown
; facing down
	inc d
	ret
.notFacingDown
	cp SPRITE_FACING_UP
	jr nz, .notFacingUp
; facing up
	dec d
	ret
.notFacingUp
	cp SPRITE_FACING_LEFT
	jr nz, .notFacingLeft
; facing left
	dec e
	ret
.notFacingLeft
; facing right
	inc e
	ret
