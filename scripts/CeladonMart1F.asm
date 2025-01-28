CeladonMart1F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMart1F_TextPointers:
	def_text_pointers
	dw_const CeladonMart1FReceptionistText,     TEXT_CELADONMART1F_RECEPTIONIST
	dw_const CeladonMart1FDirectorySignText,    TEXT_CELADONMART1F_DIRECTORY_SIGN
	dw_const CeladonMart1FCurrentFloorSignText, TEXT_CELADONMART1F_CURRENT_FLOOR_SIGN

CeladonMart1FReceptionistText:
	text "いらっしゃいませ！"
	line "タマムシ　デパートに　ようこそ！"

	para "かく　フロアの　あんないは"
	line "みぎの　ボードを　ごらん　ください"
	done

CeladonMart1FDirectorySignText:
	text "１かい<⋯>サービス·カウンター"

	para "２かい<⋯><TRAINER>ズ·マーケット"

	para "３かい<⋯>テレビ　ゲーム　ショップ"

	para "４かい<⋯>ワイズマン·ギフト"

	para "５かい<⋯>ドラッグ　ストア"

	para "おくじょう<⋯>じどう　はんばいき"
	done

CeladonMart1FCurrentFloorSignText:
	text "１かい<⋯>サービス·カウンター"
	done
