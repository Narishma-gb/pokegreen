SafariZoneEastRestHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

SafariZoneEastRestHouse_TextPointers:
	def_text_pointers
	dw_const SafariZoneEastRestHouseScientistText,    TEXT_SAFARIZONEEASTRESTHOUSE_SCIENTIST
	dw_const SafariZoneEastRestHouseRockerText,       TEXT_SAFARIZONEEASTRESTHOUSE_ROCKER
	dw_const SafariZoneEastRestHouseSilphWorkerMText, TEXT_SAFARIZONEEASTRESTHOUSE_SILPH_WORKER_M

SafariZoneEastRestHouseScientistText:
	text "おたく　なんびき　つかまえた？"
	line "ぼくは　つかまえに　つかまえて"
	cont "つかれて　しまったよ"
	done

SafariZoneEastRestHouseRockerText:
	text "ラッキーを　つかまえたぜ！"

	para "これで"
	line "じゅーぶん　もとは　とった！"
	done

SafariZoneEastRestHouseSilphWorkerMText:
	text "はあ<⋯>！"
	line "はしゃぎ　すぎて　つかれちゃった"
	done
