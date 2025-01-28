TrainerAIPointers:
	table_width 3
	; one entry per trainer class
	; first byte, number of times (per Pokémon) it can occur
	; next two bytes, pointer to AI subroutine for trainer class
	; subroutines are defined in engine/battle/trainer_ai.asm
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, JugglerAI ; unused_juggler
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, JugglerAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 2, BlackbeltAI
	dbw 3, GenericAI ; rival1
	dbw 3, GenericAI ; prof_oak
	dbw 1, GenericAI ; chief
	dbw 3, GenericAI
	dbw 1, GiovanniAI
	dbw 3, GenericAI
	dbw 2, CooltrainerMAI
	dbw 1, CooltrainerFAI
	dbw 2, BrunoAI
	dbw 5, BrockAI
	dbw 1, MistyAI
	dbw 1, LtSurgeAI
	dbw 1, ErikaAI
	dbw 2, KogaAI
	dbw 2, BlaineAI
	dbw 1, SabrinaAI
	dbw 3, GenericAI
	dbw 1, Rival2AI
	dbw 1, Rival3AI
	dbw 2, LoreleiAI
	dbw 3, GenericAI
	dbw 2, AgathaAI
	dbw 1, LanceAI
	assert_table_length NUM_TRAINERS
