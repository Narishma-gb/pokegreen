	audio_eng_channel SFX_Turn_On_PC, 5

	duty_cycle 2
	square_note 15, 15, 2, 1984
	square_note 15, 0, 0, 0

IF audio_engine == 1
	square_note 3, 10, 1, 1920
	square_note 3, 10, 1, 1792
	square_note 3, 10, 1, 1856
	square_note 3, 10, 1, 1792
	square_note 3, 10, 1, 1920
	square_note 3, 10, 1, 1792
	square_note 3, 10, 1, 1984
	square_note 8, 10, 1, 1792
ENDC

IF audio_engine == 3
	square_note 15, 0, 0, 0
	square_note 3, 8, 1, 1920
	square_note 3, 8, 1, 1792
	square_note 3, 8, 1, 1856
	square_note 3, 8, 1, 1792
	square_note 3, 8, 1, 1920
	square_note 3, 8, 1, 1792
	square_note 3, 8, 1, 1984
	square_note 3, 8, 1, 1792
ENDC

	sound_ret
