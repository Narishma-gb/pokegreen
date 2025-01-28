CreditsRollPointers:
	table_width 2
	dw .MonStaff
	dw .Director
	dw .Programmers1
	dw .Programmers2
	dw .CharDesign
	dw .Music
	dw .Sfx
	dw .GameDesign
	dw .MonsterDesign1
	dw .MonsterDesign2
	dw .GameScene1
	dw .GameScene2
	dw .ParamDesign
	dw .MapDesign1
	dw .MapDesign2
	dw .Test1
	dw .Test2
	dw .SpecialThanks1
	dw .SpecialThanks2
	dw .SpecialThanks3
	dw .Producers1
	dw .Producers2
	dw .Producers3
	dw .Executive
	dw .Copyright
	dw .TheEnd
	assert_table_length NUM_CRED_SCREENS


; subsequent credits elements will be displayed on separate lines.
; CRED_TEXT, CRED_TEXT_FADE, CRED_TEXT_MON, and CRED_TEXT_FADE_MON are
; commands that are used to trigger screen transitions.
.MonStaff:
	db CRED_MON, CRED_STAFF, CRED_TEXT_FADE_MON
.Director:
	db CRED_DIRECTOR, CRED_TAJIRI, CRED_TEXT_FADE_MON
.Programmers1:
	db CRED_PROGRAMMERS, CRED_OOTA, CRED_TEXT_FADE
.Programmers2:
	db CRED_PROGRAMMERS, CRED_MORIMOTO, CRED_WATANABE, CRED_MASUDE, CRED_TEXT_MON
.CharDesign:
	db CRED_CHAR_DESIGN, CRED_SUGIMORI, CRED_NISHIDA, CRED_TEXT_FADE_MON
.Music:
	db CRED_MUSIC, CRED_MASUDE, CRED_TEXT_FADE
.Sfx:
	db CRED_SOUND_EFFECTS, CRED_MASUDE, CRED_TEXT_MON
.GameDesign:
	db CRED_GAME_DESIGN, CRED_TAJIRI, CRED_TEXT_FADE_MON
.MonsterDesign1:
	db CRED_MONSTER_DESIGN, CRED_SUGIMORI, CRED_NISHIDA, CRED_TEXT_FADE
.MonsterDesign2:
	db CRED_MONSTER_DESIGN, CRED_FUZIWARA, CRED_MORIMOTO, CRED_TEXT_MON
.GameScene1:
	db CRED_GAME_SCENE, CRED_TAJIRI, CRED_TEXT_FADE
.GameScene2:
	db CRED_GAME_SCENE, CRED_TANIGUCHI, CRED_NONOMURA, CRED_ZINNAI, CRED_TEXT_MON
.ParamDesign:
	db CRED_PARAM, CRED_NISINO, CRED_TEXT_FADE_MON
.MapDesign1:
	db CRED_MAP, CRED_TAJIRI, CRED_NISINO, CRED_TEXT_FADE
.MapDesign2:
	db CRED_MAP, CRED_MATSUSIMA, CRED_NONOMURA, CRED_TANIGUCHI, CRED_TEXT_MON
.Test1:
	db CRED_TEST, CRED_KAKEI, CRED_TSUCHIYA, CRED_TEXT_FADE
.Test2:
	db CRED_TEST, CRED_NAKAMURA, CRED_YUDA, CRED_TEXT_MON
.SpecialThanks1:
	db CRED_SPECIAL, CRED_HISHIDA, CRED_SAKAI, CRED_TEXT_FADE
.SpecialThanks2:
	db CRED_SPECIAL, CRED_YAMAGUCHI, CRED_YAMAMOTO, CRED_TEXT
.SpecialThanks3:
	db CRED_SPECIAL, CRED_TOMISAWA, CRED_KAWAMOTO, CRED_TEXT_MON
.Producers1:
	db CRED_PRODUCERS, CRED_MIYAMOTO, CRED_TEXT_FADE
.Producers2:
	db CRED_PRODUCERS, CRED_KAWAGUCHI, CRED_TEXT
.Producers3:
	db CRED_PRODUCERS, CRED_ISHIHARA, CRED_TEXT_MON
.Executive:
	db CRED_EXECUTIVE, CRED_YAMAUCHI, CRED_TEXT_FADE_MON
.Copyright:
	db CRED_COPYRIGHT, CRED_TEXT_FADE_MON
.TheEnd:
	db CRED_THE_END
