SECTION "Garbage Header", ROM0
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_header.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_header.bin"
ENDC


SECTION "Garbage 0", ROM0
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_0.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_0.bin"
ENDC


SECTION "Garbage 1", ROMX
IF DEF(_REV0)
	IF DEF(_RED)
		db $D6
	ENDC
	db $CB, $B6, $CD, $86, $1B
ENDC
IF DEF(_REV1)
	IF DEF(_RED)
		INCBIN "garbage/rev_1/garbage_1.bin"
	ENDC
	IF DEF(_GREEN)
		INCBIN "garbage/rev_1/garbage_1.bin", 1
	ENDC
ENDC


SECTION "Garbage 2", ROMX
IF DEF(_REV0)
	IF DEF(_RED)
		INCBIN "garbage/rev_0/garbage_2.bin", 16
	ENDC
	IF DEF(_GREEN)
		INCBIN "garbage/rev_0/garbage_2.bin"
	ENDC
ENDC
IF DEF(_REV1)
	IF DEF(_RED)
		INCBIN "garbage/rev_1/garbage_2.bin", 16
	ENDC
	IF DEF(_GREEN)
		INCBIN "garbage/rev_1/garbage_2.bin"
	ENDC
ENDC


SECTION "Garbage 3", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_3.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_3.bin"
ENDC


SECTION "Garbage 4", ROMX
IF DEF(_REV0)
	db $00, $0D, $35, $41, $00
ENDC
IF DEF(_REV1)
	db $00, $EF, $00, $FF, $14
ENDC


SECTION "Garbage 5", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_5.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_5.bin"
ENDC


SECTION "Garbage 6", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_6.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_6.bin"
ENDC


SECTION "Garbage 7", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_7.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_7.bin"
ENDC


SECTION "Garbage 9", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_9.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_9.bin"
ENDC


SECTION "Garbage 10", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_10.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_10.bin"
ENDC


SECTION "Garbage 11", ROMX
IF DEF(_REV0)
	db $79
ENDC
IF DEF(_REV1)
	db $EF
ENDC


SECTION "Garbage 12", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_12.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_12.bin"
ENDC


SECTION "Garbage 14", ROMX
IF DEF(_REV0)
	db $FD
ENDC
IF DEF(_REV1)
	db $FF
ENDC


IF DEF(_REV0)
	SECTION "Garbage 15", ROMX, BANK[15]
		db $DB, $E9, $E5, $35, $7F
ENDC


SECTION "Garbage 16", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_16.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_16.bin"
ENDC


SECTION "Garbage 17", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_17.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_17.bin"
ENDC


SECTION "Garbage 18", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_18.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_18.bin"
ENDC


SECTION "Garbage 19", ROMX
IF DEF(_REV0)
	db $95, $E3
ENDC
IF DEF(_REV1)
	db $10, $FF
ENDC


SECTION "Garbage 20", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_20.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_20.bin"
ENDC


SECTION "Garbage 21", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_21.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_21.bin"
ENDC


SECTION "Garbage 22", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_22.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_22.bin"
ENDC


SECTION "Garbage 23", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_23.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_23.bin"
ENDC


SECTION "Garbage 24", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_24.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_24.bin"
ENDC


SECTION "Garbage 25", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_25.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_25.bin"
ENDC


; the garbage byte is $00 in REV0, same as padding byte
IF DEF(_REV1)
	SECTION "Garbage 26", ROMX, BANK[26]
		db $FF
ENDC


SECTION "Garbage 28", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_28.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_28.bin"
ENDC


SECTION "Garbage 29", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_29.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_29.bin"
ENDC


SECTION "Garbage 30", ROMX
IF DEF(_REV0)
	INCBIN "garbage/rev_0/garbage_30.bin"
ENDC
IF DEF(_REV1)
	INCBIN "garbage/rev_1/garbage_30.bin"
ENDC


SECTION "Garbage 31", ROMX
IF DEF(_REV0)
	IF DEF(_RED)
		INCBIN "garbage/rev_0/garbage_31.bin", 16
	ENDC
	IF DEF(_GREEN)
		INCBIN "garbage/rev_0/garbage_31.bin"
	ENDC
ENDC
IF DEF(_REV1)
	IF DEF(_RED)
		INCBIN "garbage/rev_1/garbage_31.bin", 16
	ENDC
	IF DEF(_GREEN)
		INCBIN "garbage/rev_1/garbage_31.bin"
	ENDC
ENDC
