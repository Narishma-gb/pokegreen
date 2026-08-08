MaskEnFreezePacket:: MASK_EN 1

; These are DATA_SND packets containing SNES code.
; This set of packets is found in several Japanese SGB-compatible titles.
; It appears to be part of NCL's SGB devkit.

DataSndPacket1::
	DATA_SND $85d, $0, 11
	db  $8C                 ; cpx #$8c (2)
	db  $D0, $F4            ; bne -$0c
	db  $60                 ; rts
	ds  7, 0

DataSndPacket2::
	DATA_SND $852, $0, 11
	db  $A9, $E7            ; lda #$e7
	db  $9F, $01, $C0, $7E  ; sta $7ec001, x
	db  $E8                 ; inx
	db  $E8                 ; inx
	db  $E8                 ; inx
	db  $E8                 ; inx
	db  $E0                 ; cpx #$8c (1)

DataSndPacket3::
	DATA_SND $847, $0, 11
	db  $C4                 ; cmp #$c4 (2)
	db  $D0, $16            ; bne +$16
	db  $A5                 ; lda dp
	db  $CB                 ; wai
	db  $C9, $05            ; cmp #$05
	db  $D0, $10            ; bne +$10
	db  $A2, $28            ; ldx #$28

DataSndPacket4::
	DATA_SND $83c, $0, 11
	db  $F0, $12            ; beq +$12
	db  $A5                 ; lda dp
	db  $C9, $C9            ; cmp #$c9
	db  $C8                 ; iny
	db  $D0, $1C            ; bne +$1c
	db  $A5                 ; lda dp
	db  $CA                 ; dex
	db  $C9                 ; cmp #$c4 (1)

DataSndPacket5::
	DATA_SND $831, $0, 11
	dbw $0C, $CAA5          ; tsb $caa5
	db  $C9, $7E            ; cmp #$7e
	db  $D0, $06            ; bne +$06
	db  $A5                 ; lda dp
	db  $CB                 ; wai
	db  $C9, $7E            ; cmp #$7e

DataSndPacket6::
	DATA_SND $826, $0, 11
	db  $39                 ; bne +$39 (2)
	dbw $CD, $C48           ; cmp $c48
	db  $D0, $34            ; bne +$34
	db  $A5                 ; lda dp
	db  $C9, $C9            ; cmp #$c9
	db  $80, $D0            ; bra -$30

DataSndPacket7::
	DATA_SND $81b, $0, 11
	db  $EA                 ; nop
	db  $EA                 ; nop
	db  $EA                 ; nop
	db  $EA                 ; nop
	db  $EA                 ; nop
	                        ; $820:
	db  $A9,$01             ; lda #01
	dbw $CD,$C4F            ; cmp $c4f
	db  $D0                 ; bne +$39 (1)

DataSndPacket8::
	DATA_SND $810, $0, 11
	dbw $4C, $820           ; jmp $820
	db  $EA                 ; nop
	db  $EA                 ; nop
	db  $EA                 ; nop
	db  $EA                 ; nop
	db  $EA                 ; nop
	db  $60                 ; rts
	db  $EA                 ; nop
	db  $EA                 ; nop
