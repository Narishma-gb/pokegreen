LCD::
	push af
	ldh a, [rLY]
	cp 153
	jr nc, .done
	cp LY_VBLANK
	jr c, .done

	ldh a, [rLCDC]
	and ~LCDC_ON
	ldh [rLCDC], a

	ldh a, [rIE]
	res B_IE_STAT, a
	ldh [rIE], a

	ldh a, [rSTAT]
	res B_STAT_MODE_1, a
	ldh [rSTAT], a

.done
	pop af
	reti
