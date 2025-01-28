FuchsiaCity_Script:
	jp EnableAutoTextBoxDrawing

FuchsiaCity_TextPointers:
	def_text_pointers
	dw_const FuchsiaCityYoungster1Text,      TEXT_FUCHSIACITY_YOUNGSTER1
	dw_const FuchsiaCityGamblerText,         TEXT_FUCHSIACITY_GAMBLER
	dw_const FuchsiaCityErikText,            TEXT_FUCHSIACITY_ERIK
	dw_const FuchsiaCityYoungster2Text,      TEXT_FUCHSIACITY_YOUNGSTER2
	dw_const FuchsiaCityPokemonText,         TEXT_FUCHSIACITY_CHANSEY
	dw_const FuchsiaCityPokemonText,         TEXT_FUCHSIACITY_VOLTORB
	dw_const FuchsiaCityPokemonText,         TEXT_FUCHSIACITY_KANGASKHAN
	dw_const FuchsiaCityPokemonText,         TEXT_FUCHSIACITY_SLOWPOKE
	dw_const FuchsiaCityPokemonText,         TEXT_FUCHSIACITY_LAPRAS
	dw_const FuchsiaCityPokemonText,         TEXT_FUCHSIACITY_FOSSIL
	dw_const FuchsiaCitySignText,            TEXT_FUCHSIACITY_SIGN1
	dw_const FuchsiaCitySignText,            TEXT_FUCHSIACITY_SIGN2
	dw_const FuchsiaCitySafariGameSignText,  TEXT_FUCHSIACITY_SAFARI_GAME_SIGN
	dw_const MartSignText,                   TEXT_FUCHSIACITY_MART_SIGN
	dw_const PokeCenterSignText,             TEXT_FUCHSIACITY_POKECENTER_SIGN
	dw_const FuchsiaCityWardensHomeSignText, TEXT_FUCHSIACITY_WARDENS_HOME_SIGN
	dw_const FuchsiaCitySafariZoneSignText,  TEXT_FUCHSIACITY_SAFARI_ZONE_SIGN
	dw_const FuchsiaCityGymSignText,         TEXT_FUCHSIACITY_GYM_SIGN
	dw_const FuchsiaCityChanseySignText,     TEXT_FUCHSIACITY_CHANSEY_SIGN
	dw_const FuchsiaCityVoltorbSignText,     TEXT_FUCHSIACITY_VOLTORB_SIGN
	dw_const FuchsiaCityKangaskhanSignText,  TEXT_FUCHSIACITY_KANGASKHAN_SIGN
	dw_const FuchsiaCitySlowpokeSignText,    TEXT_FUCHSIACITY_SLOWPOKE_SIGN
	dw_const FuchsiaCityLaprasSignText,      TEXT_FUCHSIACITY_LAPRAS_SIGN
	dw_const FuchsiaCityFossilSignText,      TEXT_FUCHSIACITY_FOSSIL_SIGN

FuchsiaCityYoungster1Text:
	text "サファリ　ゲーム　もう　やった？"
	line "あそこでしか　とれない"
	cont "めずらしい　#も　いるよ！"
	done

FuchsiaCityGamblerText:
	text "サファリ　ゾーンは"
	line "いりぐち　ふきんは　どうぶつえんで"

	para "おくに　いくと　#が"
	line "とりほうだいの　サファリ　ゲームじゃ"
	done

FuchsiaCityErikText:
	text "コージ『おかしいな？　アツコと"
	line "#とりで　まちあわせって<⋯>"
	cont "とり#が　みつからない！"
	done

FuchsiaCityYoungster2Text:
	text "あの　アイテム　ボール"
	line "ほしいって　おもった？"
	cont "<⋯>　<⋯>　<⋯>　ぼくもさ！"
	cont "<⋯>　え　あれ　いきものなの？"
	done

FuchsiaCityPokemonText:
	text "！"
	done

FuchsiaCitySignText:
	text "ここは　セキチク　シティ"
	line "セキチクは　ピンク　はなやかな　いろ"
	done

FuchsiaCitySafariGameSignText:
	text "めいぶつ！　サファリ　ゲーム！"
	line "<⋯>　<⋯>　#　とりほうだい！"
	done

FuchsiaCityWardensHomeSignText:
	text "サファリ　ゾーン"
	line "えんちょうの　いえ"
	done

FuchsiaCitySafariZoneSignText:
	text "いろんな　#　いっぱい！"
	line "サファリ　ゾーンに　ようこそ！"
	done

FuchsiaCityGymSignText:
	text "セキチク　シティ　#　ジム"
	line "リーダー　キョウ"
	cont "どくの　ことなら　なんでも　ござれ"
	done

FuchsiaCityChanseySignText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, CHANSEY
	call DisplayPokedex
	jp TextScriptEnd

.Text:
	text "なまえ　ラッキー"
	line "つかまえたら　スーパー　ラッキー！"
	prompt

FuchsiaCityVoltorbSignText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, VOLTORB
	call DisplayPokedex
	jp TextScriptEnd

.Text:
	text "なまえ　ビリリダマ"
	line "モンスター　ボールに　そっくり！"
	prompt

FuchsiaCityKangaskhanSignText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, KANGASKHAN
	call DisplayPokedex
	jp TextScriptEnd

.Text:
	text "なまえ　ガルーラ"
	line "なかの　よい　おやこ　#！"

	para "おなかに　こどもを　いれて"
	line "そだてて　います！"
	prompt

FuchsiaCitySlowpokeSignText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, SLOWPOKE
	call DisplayPokedex
	jp TextScriptEnd

.Text:
	text "なまえ　ヤドン"
	line "ひとなつこい　せいかくが　にんき！"
	cont "うごきが　のろい　#！"
	prompt

FuchsiaCityLaprasSignText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, LAPRAS
	call DisplayPokedex
	jp TextScriptEnd

.Text:
	text "なまえ　ラプラス"
	line "シー　ドラゴン　とも　よばれる"
	cont "うみの　おうじゃ　です！"
	prompt

FuchsiaCityFossilSignText:
	text_asm
	CheckEvent EVENT_GOT_DOME_FOSSIL
	jr nz, .got_dome_fossil
	CheckEventReuseA EVENT_GOT_HELIX_FOSSIL
	jr nz, .got_helix_fossil
	ld hl, .UndeterminedText
	call PrintText
	jr .done
.got_dome_fossil
	ld hl, .OmanyteText
	call PrintText
	ld a, OMANYTE
	jr .display
.got_helix_fossil
	ld hl, .KabutoText
	call PrintText
	ld a, KABUTO
.display
	call DisplayPokedex
.done
	jp TextScriptEnd

.OmanyteText:
	text "なまえ　オムナイト"
	line "カセキ　から　いき　かえった"
	cont "めずらしい　#！"
	prompt

.KabutoText:
	text "なまえ　カブト"
	line "カセキ　から　いき　かえった"
	cont "めずらしい　#！"
	prompt

.UndeterminedText:
	text "<⋯>"
	done
