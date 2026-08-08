MACRO ATTR_BLK
; This is a command macro.
; Use ATTR_BLK_DATA for data sets.
	db ($4 << 3) + ((\1 * 6) / 16 + 1)
	db \1
ENDM

MACRO ATTR_BLK_DATA
	db \1 ; which regions are affected
	db \2 + (\3 << 2) + (\4 << 4) ; palette for each region
	db \5, \6, \7, \8 ; x1, y1, x2, y2
ENDM

MACRO PAL_SET
	db ($a << 3) + 1
	dw \1, \2, \3, \4
	ds 7, 0
ENDM

MACRO PAL_TRN
	db ($b << 3) + 1
	ds 15, 0
ENDM

MACRO MLT_REQ
	db ($11 << 3) + 1
	db \1 - 1
	ds 14, 0
ENDM

MACRO CHR_TRN
	db ($13 << 3) + 1
	db \1 + (\2 << 1)
	ds 14, 0
ENDM

MACRO PCT_TRN
	db ($14 << 3) + 1
	ds 15, 0
ENDM

MACRO MASK_EN
	db ($17 << 3) + 1
	db \1
	ds 14, 0
ENDM

MACRO DATA_SND
	db ($f << 3) + 1
	dw \1 ; address
	db \2 ; bank
	db \3 ; length (1-11)
ENDM
