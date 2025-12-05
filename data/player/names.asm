; see constants/player_constants.asm

DefaultNamesPlayer:
	db "じぶんできめる"
FOR n, 1, NUM_PLAYER_NAMES + 1
	next #PLAYERNAME{d:n}
ENDR
	db "@"

DefaultNamesRival:
	db "じぶんできめる"
FOR n, 1, NUM_PLAYER_NAMES + 1
	next #RIVALNAME{d:n}
ENDR
	db "@"
