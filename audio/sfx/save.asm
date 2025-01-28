	audio_eng_channel SFX_Save, 5

	duty_cycle 2
IF DEF(_RED)
	square_note 2, 15, 4, 1792
	square_note 2, 14, 4, 1536
	square_note 2, 14, 4, 1664
	square_note 2, 14, 4, 1728
ENDC
IF DEF(_GREEN)
	square_note 4, 15, 4, 1792
	square_note 2, 14, 4, 1664
ENDC
	square_note 2, 14, 4, 1792
	square_note 2, 14, 4, 1984
	square_note 15, 15, 2, 2016
	sound_ret


	audio_eng_channel SFX_Save, 6

	duty_cycle 2
	square_note 2, 0, 8, 0
IF DEF(_RED)
	square_note 2, 13, 4, 1793
	square_note 2, 12, 4, 1537
	square_note 2, 12, 4, 1665
	square_note 2, 12, 4, 1729
ENDC
IF DEF(_GREEN)
	square_note 4, 13, 4, 1793
	square_note 2, 12, 4, 1665
ENDC
	square_note 2, 12, 4, 1793
	square_note 2, 12, 4, 1985
	square_note 15, 13, 2, 2017
	sound_ret
