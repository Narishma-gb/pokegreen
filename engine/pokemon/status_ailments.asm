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
	ld_hli_a_string "ねむり"
	ret
.psn
	ld_hli_a_string "<do>く"
	ret
.brn
	ld_hli_a_string "やけ<do>"
	ret
.frz
	ld_hli_a_string "こおり"
	ret
.par
	ld_hli_a_string "まひ"
	ret
