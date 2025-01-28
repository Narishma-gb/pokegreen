SafariZoneWestRestHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

SafariZoneWestRestHouse_TextPointers:
	def_text_pointers
	dw_const SafariZoneWestRestHouseScientistText,    TEXT_SAFARIZONEWESTRESTHOUSE_SCIENTIST
	dw_const SafariZoneWestRestHouseCooltrainerMText, TEXT_SAFARIZONEWESTRESTHOUSE_COOLTRAINER_M
	dw_const SafariZoneWestRestHouseSilphWorkerFText, TEXT_SAFARIZONEWESTRESTHOUSE_SILPH_WORKER_F

SafariZoneWestRestHouseScientistText:
	text "いしころ　あてると"
	line "にげる　かも　しれないが"
	cont "つかまえ　やすくは　なるよ！"
	done

SafariZoneWestRestHouseCooltrainerMText:
	text "エサだまを　なげると"
	line "エサに　むちゅうで　いる　あいだ"
	cont "ポケモンは　あまり　にげない！"
	done

SafariZoneWestRestHouseSilphWorkerFText:
	text "たくさん　あるいた　けど"
	line "とりたい　ポケモンが"
	cont "なかなか　とびだして　こないの"
	done
