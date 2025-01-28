SaffronPidgeyHouse_Script:
	jp EnableAutoTextBoxDrawing

SaffronPidgeyHouse_TextPointers:
	def_text_pointers
	dw_const SaffronPidgeyHouseBrunetteGirlText, TEXT_SAFFRONPIDGEYHOUSE_BRUNETTE_GIRL
	dw_const SaffronPidgeyHousePidgeyText,       TEXT_SAFFRONPIDGEYHOUSE_PIDGEY
	dw_const SaffronPidgeyHouseYoungsterText,    TEXT_SAFFRONPIDGEYHOUSE_YOUNGSTER
	dw_const SaffronPidgeyHousePaperText,        TEXT_SAFFRONPIDGEYHOUSE_PAPER

SaffronPidgeyHouseBrunetteGirlText:
	text "<⋯>　おてがみ　ありがとう！"
	line "はやく　あなたに　あいたいな<⋯>"

	para "いやーん！"
	line "てがみ　かいてんだから　みないで！"
	done

SaffronPidgeyHousePidgeyText:
	text "ポッポ『クルックー@"
	text_asm
	ld a, PIDGEY
	call PlayCry
	jp TextScriptEnd

SaffronPidgeyHouseYoungsterText:
	text "ものまね　むすめって　かわいい！"
	line "かのじょに　ピッピにんぎょう"
	cont "プレゼント　するんだ！"
	done

SaffronPidgeyHousePaperText:
	text "<⋯>　この　あいだ"
	line "ポイント　アップ　もらったの"

	para "すごく　つよい　わざって"
	line "パワー　ポイント　すくないけど"
	cont "これで　ふやせば　いいのね<⋯>？"
	done
