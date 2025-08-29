; Enumerate constants

MACRO const_def
	IF _NARG >= 1
		DEF const_value = \1
	ELSE
		DEF const_value = 0
	ENDC
	IF _NARG >= 2
		DEF const_inc = \2
	ELSE
		DEF const_inc = 1
	ENDC
ENDM

MACRO const
	DEF \1 EQU const_value
	DEF const_value += const_inc
ENDM

MACRO const_export
	const \1
	EXPORT \1
ENDM

MACRO shift_const
	DEF \1 EQU 1 << const_value
	DEF const_value += const_inc
ENDM

MACRO const_skip
	IF _NARG >= 1
		DEF const_value += const_inc * (\1)
	ELSE
		DEF const_value += const_inc
	ENDC
ENDM

MACRO const_next
	IF (const_value > 0 && \1 < const_value) || (const_value < 0 && \1 > const_value)
		FAIL "const_next cannot go backwards from {const_value} to \1"
	ELSE
		DEF const_value = \1
	ENDC
ENDM

MACRO dw_const
	dw \1
	const \2
ENDM

MACRO rb_skip
	IF _NARG == 1
		RSSET _RS + \1
	ELSE
		RSSET _RS + 1
	ENDC
ENDM
