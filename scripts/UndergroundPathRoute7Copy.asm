UndergroundPathRoute7Copy_Script:
	ld a, ROUTE_7
	ld [wLastMap], a
	ret

UndergroundPathRoute7Copy_TextPointers:
	def_text_pointers
	dw_const UndergroundPathRoute7CopyUnusedGirlText,          TEXT_UNDERGROUNDPATHROUTE7COPY_UNUSED_GIRL
	dw_const UndergroundPathRoute7CopyUnusedMiddleAgedManText, TEXT_UNDERGROUNDPATHROUTE7COPY_UNUSED_MIDDLE_AGED_MAN

UndergroundPathRoute7CopyUnusedGirlText:
	text "「たまむし」シティの　デパートへ"
	next "かいものに　いきたいんだけど<⋯>"

	para "あのまちには　ガラのわるい　ひとが"
	line "おおくて　なんだか　こわいのよね"
	done

UndergroundPathRoute7CopyUnusedTeamRocketHadAHideoutText:
	text "「たまむし」シティに"
	next "「<ROCKET>」のアジトが"
	cont "あったんですって？"
	done

UndergroundPathRoute7CopyUnusedMiddleAgedManText:
	text "おまえも　「たまむし」シティに"
	next "かいものに　きたんだな"

	para "ドアから　でて"
	line "すぐ　にしがわのまちが　そうだよ"
	done

UndergroundPathRoute7CopyUnusedGoesUnderSaffronText:
	text "かいだんの　したにある　つうろは"
	next "「やまぶき」の　したを　とおって"
	cont "「しおん」へ　つながっているんだ"

	para "「はなだ」へ　いきたいんなら"

	para "みちを　はさんで　むかいがわに"
	line "たってる　たてものに　いきなよ"
	done
