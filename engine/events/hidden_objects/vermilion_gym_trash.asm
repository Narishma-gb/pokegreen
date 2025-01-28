PrintTrashText:
	call EnableAutoTextBoxDrawing
	tx_pre_jump VermilionGymTrashText

VermilionGymTrashText::
	text "ガサゴソ<⋯>！"
	line "なかは　ゴミ　ばっかり！"
	done

GymTrashScript:
	call EnableAutoTextBoxDrawing
	ld a, [wHiddenObjectFunctionArgument]
	ld [wGymTrashCanIndex], a

; Don't do the trash can puzzle if it's already been done.
	CheckEvent EVENT_2ND_LOCK_OPENED
	jr z, .ok

	tx_pre_jump VermilionGymTrashText

.ok
	CheckEventReuseA EVENT_1ST_LOCK_OPENED
	jr nz, .trySecondLock

	ld a, [wFirstLockTrashCanIndex]
	ld b, a
	ld a, [wGymTrashCanIndex]
	cp b
	jr z, .openFirstLock

	tx_pre_id VermilionGymTrashText
	jr .done

.openFirstLock
; Next can is trying for the second switch.
	SetEvent EVENT_1ST_LOCK_OPENED

	ld hl, GymTrashCans
	ld a, [wGymTrashCanIndex]
	; * 5
	ld b, a
	add a
	add a
	add b

	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]

; There is a bug in this code. It should calculate a value in the range [0, 3]
; but if the mask and random number don't have any 1 bits in common, then
; the result of the AND will be 0. When 1 is subtracted from that, the value
; will become $ff. This will result in 255 being added to hl, which will cause
; hl to point to one of the bytes in VermilionGymTrashSuccessText3 or
; VermilionGymTrashFailText. These are:
; $51, $7F, $13, $DE, $CB, $50, $3E, $CD, $0F, $8E, $B6, $7F, $E7, $7F, $13.
; In case of underflow, the 2nd lock will be in any of the cans 0, 1, 3, 6, 7,
; 11, 13, 14 or 15, depending on where the first lock is located,
; likely breaking the "rule" that it should be in an adjacent trash can.

	ldh [hGymTrashCanRandNumMask], a
	push hl
	call Random
	swap a
	ld b, a
	ldh a, [hGymTrashCanRandNumMask]
	and b
	dec a
	pop hl

	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	and $f
	ld [wSecondLockTrashCanIndex], a

	tx_pre_id VermilionGymTrashSuccessText1
	jr .done

.trySecondLock
	ld a, [wSecondLockTrashCanIndex]
	ld b, a
	ld a, [wGymTrashCanIndex]
	cp b
	jr z, .openSecondLock

; Reset the cans.
	ResetEvent EVENT_1ST_LOCK_OPENED
	call Random

	and $e
	ld [wFirstLockTrashCanIndex], a

	tx_pre_id VermilionGymTrashFailText
	jr .done

.openSecondLock
; Completed the trash can puzzle.
	SetEvent EVENT_2ND_LOCK_OPENED
	ld hl, wCurrentMapScriptFlags
	set BIT_CUR_MAP_LOADED_2, [hl]

	tx_pre_id VermilionGymTrashSuccessText3

.done
	jp PrintPredefTextID

GymTrashCans:
; byte 0: mask for random number
; bytes 1-4: indices of the trash cans that can have the second lock
;            (but see the comment above explaining a bug regarding this)
; Note that the mask is simply the number of valid trash can indices that
; follow. The remaining bytes are filled with 0 to pad the length of each entry
; to 5 bytes.
	db 2,  1,  3,  0,  0 ; 0
	db 3,  0,  2,  4,  0 ; 1
	db 2,  1,  5,  0,  0 ; 2
	db 3,  0,  4,  6,  0 ; 3
	db 4,  1,  3,  5,  7 ; 4
	db 3,  2,  4,  8,  0 ; 5
	db 3,  3,  7,  9,  0 ; 6
	db 4,  4,  6,  8, 10 ; 7
	db 3,  5,  7, 11,  0 ; 8
	db 3,  6, 10, 12,  0 ; 9
	db 4,  7,  9, 11, 13 ; 10
	db 3,  8, 10, 14,  0 ; 11
	db 2,  9, 13,  0,  0 ; 12
	db 3, 10, 12, 14,  0 ; 13
	db 2, 11, 13,  0,  0 ; 14

VermilionGymTrashSuccessText1::
	text "ガサゴソ<⋯>！"
	line "おっと！　ゴミばこの　そこに"
	cont "スイッチが　あった！"
	cont "おして　みよう！　<⋯>　ポチッとな"

	para "でんどうドアの"
	line "だい１　ロックが　はずれた！@"
	text_asm
	call WaitForSoundToFinish
	ld a, SFX_SWITCH
	call PlaySound
	call WaitForSoundToFinish
	jp TextScriptEnd

; unused
VermilionGymTrashSuccessText2::
	text "ガサゴソ<⋯>！"
	line "おっと！　ゴミばこの　そこに"
	cont "また　スイッチが　あった！"
	cont "おして　みよう！　<⋯>　ポチッとな"
	prompt

; unused
VermilionGymTrashSuccesPlaySfx:
	text_asm
	call WaitForSoundToFinish
	ld a, SFX_SWITCH
	call PlaySound
	call WaitForSoundToFinish
	jp TextScriptEnd

VermilionGymTrashSuccessText3::
	text "でんどうドアの"
	line "だい２　ロックが　はずれた！"

	para "おおきな　でんどうドアが"
	line "かんぜんに　ひらいた！@"
	text_asm
	call WaitForSoundToFinish
	ld a, SFX_GO_INSIDE
	call PlaySound
	call WaitForSoundToFinish
	jp TextScriptEnd

VermilionGymTrashFailText::
	text "ガサゴソ<⋯>！"
	line "なかは　ゴミ　ばっかり！"
	cont "あッ！　でんどうドアの"
	cont "ロックが　もどって　しまった！@"
	text_asm
	call WaitForSoundToFinish
	ld a, SFX_DENIED
	call PlaySound
	call WaitForSoundToFinish
	jp TextScriptEnd
