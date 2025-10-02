; base data struct members (see data/pokemon/base_stats/*.asm)
RSRESET
DEF BASE_DEX_NO      RB                      ; $00
DEF BASE_STATS       RB NUM_STATS            ; $01
RSSET BASE_STATS
DEF BASE_HP          RB                      ; $01
DEF BASE_ATK         RB                      ; $02
DEF BASE_DEF         RB                      ; $03
DEF BASE_SPD         RB                      ; $04
DEF BASE_SPC         RB                      ; $05
DEF BASE_TYPES       RW                      ; $06
RSSET BASE_TYPES
DEF BASE_TYPE_1      RB                      ; $06
DEF BASE_TYPE_2      RB                      ; $07
DEF BASE_CATCH_RATE  RB                      ; $08
DEF BASE_EXP         RB                      ; $09
DEF BASE_PIC_SIZE    RB                      ; $0a
DEF BASE_FRONTPIC    RW                      ; $0b
DEF BASE_BACKPIC     RW                      ; $0d
DEF BASE_MOVES       RB NUM_MOVES            ; $0f
DEF BASE_GROWTH_RATE RB                      ; $13
DEF BASE_TMHM        RB (NUM_TM_HM + 7) / 8  ; $14
                     rb_skip
DEF BASE_DATA_SIZE EQU _RS                   ; $1C

; party_struct members (see macros/ram.asm)
RSRESET
DEF MON_SPECIES    RB              ; $00
DEF MON_HP         RW              ; $01
DEF MON_BOX_LEVEL  RB              ; $03
DEF MON_STATUS     RB              ; $04
DEF MON_TYPE       RW              ; $05
RSSET MON_TYPE
DEF MON_TYPE1      RB              ; $05
DEF MON_TYPE2      RB              ; $06
DEF MON_CATCH_RATE RB              ; $07
DEF MON_MOVES      RB NUM_MOVES    ; $08
DEF MON_OTID       RW              ; $0c
DEF MON_EXP        RB 3            ; $0e
DEF MON_HP_EXP     RW              ; $11
DEF MON_ATK_EXP    RW              ; $13
DEF MON_DEF_EXP    RW              ; $15
DEF MON_SPD_EXP    RW              ; $17
DEF MON_SPC_EXP    RW              ; $19
DEF MON_DVS        RW              ; $1b
DEF MON_PP         RB NUM_MOVES    ; $1d
DEF BOXMON_STRUCT_LENGTH EQU _RS   ; $21
DEF MON_LEVEL      RB              ; $21
DEF MON_STATS      RW NUM_STATS    ; $22
RSSET MON_STATS
DEF MON_MAXHP      RW              ; $22
DEF MON_ATK        RW              ; $24
DEF MON_DEF        RW              ; $26
DEF MON_SPD        RW              ; $28
DEF MON_SPC        RW              ; $2A
DEF PARTYMON_STRUCT_LENGTH EQU _RS ; $2C

DEF PARTY_LENGTH EQU 6

DEF MONS_PER_BOX EQU 30
DEF NUM_BOXES    EQU 8

DEF HOF_MON           EQU $10
DEF HOF_TEAM          EQU PARTY_LENGTH * HOF_MON
DEF HOF_TEAM_CAPACITY EQU 50

; mon data locations
; Note that some values are not supported by all functions that use these values.
	const_def
	const PLAYER_PARTY_DATA ; 0
	const ENEMY_PARTY_DATA  ; 1
	const BOX_DATA          ; 2
	const DAYCARE_DATA      ; 3
	const BATTLE_MON_DATA   ; 4

; Evolution types
	const_def 1
	const EVOLVE_LEVEL ; 1
	const EVOLVE_ITEM  ; 2
	const EVOLVE_TRADE ; 3

; evolution data (see data/pokemon/evos_moves.asm)
DEF NUM_EVOS_IN_BUFFER EQU 3

; wMonHGrowthRate values
; GrowthRateTable indexes (see data/growth_rates.asm)
	const_def
	const GROWTH_MEDIUM_FAST   ; 0
	const GROWTH_SLIGHTLY_FAST ; 1
	const GROWTH_SLIGHTLY_SLOW ; 2
	const GROWTH_MEDIUM_SLOW   ; 3
	const GROWTH_FAST          ; 4
	const GROWTH_SLOW          ; 5

DEF NUM_GROWTH_RATES EQU const_value


; wild data (see data/wild/maps/*.asm)
DEF NUM_WILDMONS EQU 10
DEF WILDDATA_LENGTH EQU 1 + NUM_WILDMONS * 2

; PP in box_struct (see macros/ram.asm)
DEF PP_UP_MASK EQU %11000000 ; number of PP Up used
DEF PP_MASK    EQU %00111111 ; currently remaining PP
