PrintStatusAilment::
	ld a, [de]
	bit PSN, a
	jr nz, .psn
	bit BRN, a
	jr nz, .brn
	bit FRZ, a
	jr nz, .frz
	bit PAR, a
	jr nz, .par
	and SLP_MASK
	ret z
	ld a, 'ね'
	ld [hli], a
	ld a, 'む'
	ld [hli], a
	ld [hl], 'り'
	ret
.psn
	ld a, '<do>'
	ld [hli], a
	ld [hl], 'く'
	ret
.brn
	ld a, 'や'
	ld [hli], a
	ld a, 'け'
	ld [hli], a
	ld [hl], '<do>'
	ret
.frz
	ld a, 'こ'
	ld [hli], a
	ld a, 'お'
	ld [hli], a
	ld [hl], 'り'
	ret
.par
	ld a, 'ま'
	ld [hli], a
	ld [hl], 'ひ'
	ret
