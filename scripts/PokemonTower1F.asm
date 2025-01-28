PokemonTower1F_Script:
	jp EnableAutoTextBoxDrawing

PokemonTower1F_TextPointers:
	def_text_pointers
	dw_const PokemonTower1FReceptionistText,    TEXT_POKEMONTOWER1F_RECEPTIONIST
	dw_const PokemonTower1FMiddleAgedWomanText, TEXT_POKEMONTOWER1F_MIDDLE_AGED_WOMAN
	dw_const PokemonTower1FBaldingGuyText,      TEXT_POKEMONTOWER1F_BALDING_GUY
	dw_const PokemonTower1FGirlText,            TEXT_POKEMONTOWER1F_GIRL
	dw_const PokemonTower1FChannelerText,       TEXT_POKEMONTOWER1F_CHANNELER

PokemonTower1FReceptionistText:
	text "#　タワーは"
	line "しんだ　#を　なぐさめるため"
	cont "たてられた　とう　です"
	done

PokemonTower1FMiddleAgedWomanText:
	text "あなたも"
	line "おはか　まいりに　きたの？"
	cont "#　おもいの　おとこのこ　ね"
	done

PokemonTower1FBaldingGuyText:
	text "しんだ　ピッピの　コトが"
	line "わすれられん<⋯>！"

	para "<⋯>イカン！"
	line "なみだが　でて　きおった<⋯>"
	done

PokemonTower1FGirlText:
	text "ああ　わたしの　ガーディ<⋯>"
	line "どうして　しんで　しまったの<⋯>"
	done

PokemonTower1FChannelerText:
	text "わたしは　きとうし！"
	line "どうも　うえの　かいに"
	cont "まよえる　たましいを　かんじる"
	done
