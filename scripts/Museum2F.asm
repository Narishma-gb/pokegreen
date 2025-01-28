Museum2F_Script:
	jp EnableAutoTextBoxDrawing

Museum2F_TextPointers:
	def_text_pointers
	dw_const Museum2FYoungsterText,        TEXT_MUSEUM2F_YOUNGSTER
	dw_const Museum2FGrampsText,           TEXT_MUSEUM2F_GRAMPS
	dw_const Museum2FScientistText,        TEXT_MUSEUM2F_SCIENTIST
	dw_const Museum2FBrunetteGirlText,     TEXT_MUSEUM2F_BRUNETTE_GIRL
	dw_const Museum2FHikerText,            TEXT_MUSEUM2F_HIKER
	dw_const Museum2FSpaceShuttleSignText, TEXT_MUSEUM2F_SPACE_SHUTTLE_SIGN
	dw_const Museum2FMoonStoneSignText,    TEXT_MUSEUM2F_MOON_STONE_SIGN

Museum2FYoungsterText:
	text "つきの　いしね<⋯>"

	para "そこらへんの　いしころと"
	line "どこが　ちがうんだろう？"
	done

Museum2FGrampsText:
	text "１９６９ねん　７がつ　２０か！"

	para "じんるい"
	line "はじめて　つきに　たつ！"

	para "わしは　あの　ニュースが　みたくて"
	line "カラーテレビを　かったんじゃ！"
	done

Museum2FScientistText:
	text "こんげつは"
	line "うちゅう　はくらんかいを　やってます"
	done

Museum2FBrunetteGirlText:
	text "わたしね　わたしね"
	line "かわいいから　ピカチュウ　ほしい！"

	para "おとうさんに　とってきてね　って"
	line "おねがい　してるの"
	done

Museum2FHikerText:
	text "はい　はい！"
	line "ピカチュウだな！　こんどな！"
	done

Museum2FSpaceShuttleSignText:
	text "スペース　シャトル　コロンビアごう"
	done

Museum2FMoonStoneSignText:
	text "オツキミやまに　らっかした　ぶったい"
	line "たぶん<⋯>　つきの　いし"
	done
