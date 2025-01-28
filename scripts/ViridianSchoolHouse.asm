ViridianSchoolHouse_Script:
	jp EnableAutoTextBoxDrawing

ViridianSchoolHouse_TextPointers:
	def_text_pointers
	dw_const ViridianSchoolHouseBrunetteGirlText, TEXT_VIRIDIANSCHOOLHOUSE_BRUNETTE_GIRL
	dw_const ViridianSchoolHouseCooltrainerFText, TEXT_VIRIDIANSCHOOLHOUSE_COOLTRAINER_F

ViridianSchoolHouseBrunetteGirlText:
	text "ふー"
	line "ノートの　なかの　こと"
	cont "わたし　ぜんぶ　おぼえるの"
	done

ViridianSchoolHouseCooltrainerFText:
	text "はい！"

	para "こくばんに　かかれてる　こと"
	line "ちゃんと　みて！"
	done
