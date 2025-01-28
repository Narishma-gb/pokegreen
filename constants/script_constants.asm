; EmotionBubblesPointerTable indexes (see engine/overworld/emotion_bubbles.asm)
	const_def
	const EXCLAMATION_BUBBLE ; 0
	const QUESTION_BUBBLE    ; 1
	const SMILE_BUBBLE       ; 2

; slot symbols
DEF SLOTS7      EQU $0200
DEF SLOTSBAR    EQU $0604
DEF SLOTSCHERRY EQU $0A08
DEF SLOTSFISH   EQU $0E0C
DEF SLOTSBIRD   EQU $1210
DEF SLOTSMOUSE  EQU $1614

; StartSlotMachine dialogs
DEF SLOTS_OUTOFORDER   EQU $fd
DEF SLOTS_OUTTOLUNCH   EQU $fe
DEF SLOTS_SOMEONESKEYS EQU $ff

; in game trades
; TradeMons indexes (see data/events/trades.asm)
	const_def
	const TRADE_FOR_TERRY      ; 0
	const TRADE_FOR_MARCEL     ; 1
	const TRADE_FOR_CHIKUCHIKU ; 2 (unused)
	const TRADE_FOR_SAILOR     ; 3
	const TRADE_FOR_DUX        ; 4
	const TRADE_FOR_MARC       ; 5
	const TRADE_FOR_LOLA       ; 6
	const TRADE_FOR_DORIS      ; 7
	const TRADE_FOR_CRINKLES   ; 8
	const TRADE_FOR_SPOT       ; 9
DEF NUM_NPC_TRADES EQU const_value

; in game trade dialog sets
; InGameTradeTextPointers indexes (see engine/events/in_game_trades.asm)
	const_def
	const TRADE_DIALOGSET_CASUAL
	const TRADE_DIALOGSET_POLITE
	const TRADE_DIALOGSET_HAPPY

; in game trade text pointers
; TradeTextPointersX indexes (see engine/events/in_game_trades.asm)
	const_def
	const TEXT_WANNA_TRADE ; 0
	const TEXT_NO_TRADE    ; 1
	const TEXT_WRONG_MON   ; 2
	const TEXT_THANKS      ; 3
	const TEXT_AFTER_TRADE ; 4

; OaksAideScript results
DEF OAKS_AIDE_BAG_FULL        EQU $00
DEF OAKS_AIDE_GOT_ITEM        EQU $01
DEF OAKS_AIDE_NOT_ENOUGH_MONS EQU $80
DEF OAKS_AIDE_REFUSED         EQU $ff
