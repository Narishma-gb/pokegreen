SafariZoneCenterRestHouse_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneCenterRestHouse_TextPointers:
	def_text_pointers
	dw_const SafariZoneCenterRestHouseGirlText,      TEXT_SAFARIZONECENTERRESTHOUSE_GIRL
	dw_const SafariZoneCenterRestHouseScientistText, TEXT_SAFARIZONECENTERRESTHOUSE_SCIENTIST

SafariZoneCenterRestHouseGirlText:
	text "アツコ『#とりに　いこうって"
	line "いった　のに<⋯>コージ　どこなのよ！"
	done

SafariZoneCenterRestHouseScientistText:
	text "よーし！　#　とり　まくって"
	line "おみやげに　しようっと！"
	done
