DEF NAME_LENGTH EQU 6
DEF ITEM_NAME_LENGTH EQU 9
DEF TRAINER_NAME_LENGTH EQU 11
DEF NAME_BUFFER_LENGTH EQU 20

; PrintNumber, PrintBCDNumber
	const_def 6
	const BIT_LEFT_ALIGN     ; 6
	const BIT_LEADING_ZEROES ; 7

DEF LEFT_ALIGN EQU     (1 << BIT_LEFT_ALIGN)     ; $40
DEF LEADING_ZEROES EQU (1 << BIT_LEADING_ZEROES) ; $80

; special text IDs (see home/text_script.asm)
	const_def $d0
	const TEXT_MON_FAINTED      ; $d0
	const TEXT_BLACKED_OUT      ; $d1
	const TEXT_REPEL_WORE_OFF   ; $d2
	const TEXT_SAFARI_GAME_OVER ; $d3

DEF TEXT_START_MENU EQU $00
