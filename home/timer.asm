; SGB only: Timer takes over music control while the border update is sent to SNES.
Timer::
	push af
	push bc
	push de
	push hl
	ld hl, hUseTimer
	ld a, [hli]
	and a
	jr z, .done
	ASSERT hUseTimer + 1 == hTimerInterrupt
	ld a, [hl]
	and a
	jr nz, .done
	inc [hl]
	ei ; allow LCD interrupt to run

	call FadeOutAudio
	ldh a, [hLoadedROMBank]
	push af

	ld a, [wAudioROMBank] ; music ROM bank
	ldh [hLoadedROMBank], a
	ld [rROMB], a

	cp BANK(Audio1_UpdateMusic)
	jr nz, .checkForAudio2
.audio1
	call Audio1_UpdateMusic
	jr .afterMusic
.checkForAudio2
	cp BANK(Audio2_UpdateMusic)
	jr nz, .audio3
.audio2
	call Music_DoLowHealthAlarm
	call Audio2_UpdateMusic
	jr .afterMusic
.audio3
	call Audio3_UpdateMusic
.afterMusic
	pop af
	ldh [hLoadedROMBank], a
	ld [rROMB], a

.done
	di
	xor a
	ldh [hTimerInterrupt], a
	pop hl
	pop de
	pop bc
	pop af
	reti
