; see constants/player_constants.asm

DefaultNamesPlayerList:
	db "じぶんできめる@"
	list_start NAME_LENGTH - 1
FOR n, 1, NUM_PLAYER_NAMES + 1
	li #PLAYERNAME{d:n}
ENDR
	assert_list_length NUM_PLAYER_NAMES

DefaultNamesRivalList:
	db "じぶんできめる@"
	list_start NAME_LENGTH - 1
FOR n, 1, NUM_PLAYER_NAMES + 1
	li #RIVALNAME{d:n}
ENDR
	assert_list_length NUM_PLAYER_NAMES
