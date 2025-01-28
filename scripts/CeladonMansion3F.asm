CeladonMansion3F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMansion3F_TextPointers:
	def_text_pointers
	dw_const CeladonMansion3FProgrammerText,     TEXT_CELADONMANSION3F_PROGRAMMER
	dw_const CeladonMansion3FGraphicArtistText,  TEXT_CELADONMANSION3F_GRAPHIC_ARTIST
	dw_const CeladonMansion3FWriterText,         TEXT_CELADONMANSION3F_WRITER
	dw_const CeladonMansion3FGameDesignerText,   TEXT_CELADONMANSION3F_GAME_DESIGNER
	dw_const CeladonMansion3FGameProgramPCText,  TEXT_CELADONMANSION3F_GAME_PROGRAM_PC
	dw_const CeladonMansion3FPlayingGamePCText,  TEXT_CELADONMANSION3F_PLAYING_GAME_PC
	dw_const CeladonMansion3FGameScriptPCText,   TEXT_CELADONMANSION3F_GAME_SCRIPT_PC
	dw_const CeladonMansion3FDevRoomSignText,    TEXT_CELADONMANSION3F_DEV_ROOM_SIGN

CeladonMansion3FProgrammerText:
	text "おれ？　プログラマー　だよ！"
	done

CeladonMansion3FGraphicArtistText:
	text "おれ　グラフィッカー！"
	line "おまえを　かいたの　おれさ！"
	done

CeladonMansion3FWriterText:
	text "ぼく　シナリオ　かいた！"
	line "あの<⋯>　エリカ　かわいい　でしょ"

	para "カスミも　いいよね！"

	para "ナツメも　いいよね！"
	done

CeladonMansion3FGameDesignerText:
	text_asm
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	cp NUM_POKEMON - 1 ; discount Mew
	jr nc, .completed_dex
	ld hl, .Text
	jr .done
.completed_dex
	ld hl, .CompletedDexText
.done
	call PrintText
	jp TextScriptEnd

.Text:
	text "そーですかー！"

	para "ぼくは　ゲーム　デザイナー"

	para "#ずかん　ぜんぶ　あつめるの"
	line "たいへん　だけど　がんばって！"
	cont "もし　ぜんぶ　あつめたら"

	para "おしえてね！"
	done

.CompletedDexText:
	text "わあ　すごい！"
	line "#ずかん　ぜんぶの　ページ"
	cont "とうとう　あつめたんだね！"
	cont "おめでとう！"
	cont "<⋯><⋯>@"
	text_promptbutton
	text_asm
	callfar DisplayDiploma
	ld a, TRUE
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	jp TextScriptEnd

CeladonMansion3FGameProgramPCText:
	text "ゲームの　プログラムだ！"
	line "これ　かえたら　バグる　かも"
	done

CeladonMansion3FPlayingGamePCText:
	text "<PC>で　しごと　ちゅう<⋯>"
	line "と　おもったら　ゲーム　だった！"
	done

CeladonMansion3FGameScriptPCText:
	text "<⋯>　ポケモンの　シナリオだ！"
	line "これは　エンディングだ！"
	cont "いまは　みないで　おこう<⋯>！"
	done

CeladonMansion3FDevRoomSignText:
	text "ゲームフリーク　かいはつ　しつ"
	done
