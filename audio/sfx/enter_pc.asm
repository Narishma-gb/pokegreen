	audio_eng_channel SFX_Enter_PC, 5

	duty_cycle 2

IF audio_engine == 1
	square_note 6, 15, 0, 1792
	square_note 4, 0, 0, 0
	square_note 6, 15, 0, 1792
ENDC

IF audio_engine == 3
	square_note 4, 15, 0, 1792
	square_note 4, 0, 0, 0
	square_note 4, 15, 0, 1792
ENDC

	square_note 1, 0, 0, 0
	sound_ret
