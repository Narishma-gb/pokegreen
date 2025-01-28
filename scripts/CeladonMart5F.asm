CeladonMart5F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMart5F_TextPointers:
	def_text_pointers
	dw_const CeladonMart5FGentlemanText,        TEXT_CELADONMART5F_GENTLEMAN
	dw_const CeladonMart5FSailorText,           TEXT_CELADONMART5F_SAILOR
	dw_const CeladonMart5FClerk1Text,           TEXT_CELADONMART5F_CLERK1
	dw_const CeladonMart5FClerk2Text,           TEXT_CELADONMART5F_CLERK2
	dw_const CeladonMart5FCurrentFloorSignText, TEXT_CELADONMART5F_CURRENT_FLOOR_SIGN

CeladonMart5FGentlemanText:
	text "#の　のうりょくを　あげる"
	line "アイテムは　ここでしか　かえない"

	para "リゾチウムは"
	line "とくしゅ　のうりょくを　アップ"

	para "インドメタシンは"
	line "すばやさを　アップ　させるのだ"
	done

CeladonMart5FSailorText:
	text "#の　のうりょくを　あげる"
	line "アイテムを　かいに　きたんだ！"

	para "タウリンは"
	line "こうげき　りょく　アップ！"

	para "ブロムヘキシンは"
	line "ぼうぎょ　りょく　アップ　だぜ！"
	done

CeladonMart5FCurrentFloorSignText:
	text "５かい<⋯>ドラッグ　ストア"
	done
