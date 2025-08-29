CeladonMart3F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMart3F_TextPointers:
	def_text_pointers
	dw_const CeladonMart3FClerkText,            TEXT_CELADONMART3F_CLERK
	dw_const CeladonMart3FGameBoyKid1Text,      TEXT_CELADONMART3F_GAMEBOY_KID1
	dw_const CeladonMart3FGameBoyKid2Text,      TEXT_CELADONMART3F_GAMEBOY_KID2
	dw_const CeladonMart3FGameBoyKid3Text,      TEXT_CELADONMART3F_GAMEBOY_KID3
	dw_const CeladonMart3FLittleBoyText,        TEXT_CELADONMART3F_LITTLE_BOY
	dw_const CeladonMart3FSNESText,             TEXT_CELADONMART3F_SNES1
	dw_const CeladonMart3FRPGText,              TEXT_CELADONMART3F_RPG
	dw_const CeladonMart3FSNESText,             TEXT_CELADONMART3F_SNES2
	dw_const CeladonMart3FSportsGameText,       TEXT_CELADONMART3F_SPORTS_GAME
	dw_const CeladonMart3FSNESText,             TEXT_CELADONMART3F_SNES3
	dw_const CeladonMart3FPuzzleGameText,       TEXT_CELADONMART3F_PUZZLE_GAME
	dw_const CeladonMart3FSNESText,             TEXT_CELADONMART3F_SNES4
	dw_const CeladonMart3FFightingGameText,     TEXT_CELADONMART3F_FIGHTING_GAME
	dw_const CeladonMart3FCurrentFloorSignText, TEXT_CELADONMART3F_CURRENT_FLOOR_SIGN
	dw_const CeladonMart3FPokemonPosterText,    TEXT_CELADONMART3F_POKEMON_POSTER1
	dw_const CeladonMart3FPokemonPosterText,    TEXT_CELADONMART3F_POKEMON_POSTER2
	dw_const CeladonMart3FPokemonPosterText,    TEXT_CELADONMART3F_POKEMON_POSTER3

CeladonMart3FClerkText:
	text_asm
	CheckEvent EVENT_GOT_TM18
	jr nz, .got_item
	ld hl, .TM18PreReceiveText
	call PrintText
	lb bc, TM_COUNTER, 1
	call GiveItem
	jr nc, .bag_full
	SetEvent EVENT_GOT_TM18
	ld hl, .ReceivedTM18Text
	jr .done
.bag_full
	ld hl, .TM18NoRoomText
	jr .done
.got_item
	ld hl, .TM18ExplanationText
.done
	call PrintText
	jp TextScriptEnd

.TM18PreReceiveText:
	text "いらっしゃい！"
	line "いやあー！"
	cont "#　やっと　おわったよ！"

	para "きみは　まだ　なの？"
	line "それじゃあ"
	cont "いい　もの　あげよう"
	prompt

.ReceivedTM18Text:
	text "<PLAYER>は　てんいん　から"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_item_1
	text_end

.TM18ExplanationText:
	text "てんいんの　プレゼント　だけに"
	line "<TM>１８の　わざは"
	cont "<⋯>　カウンター！　だよ！"
	cont "それじゃ　がんばってね！"
	done

.TM18NoRoomText:
	text "にもつが　いっぱいだ！"
	done

CeladonMart3FGameBoyKid1Text:
	text "とった　ひとの　なまえと"
	line "アイディが　#　ごとに"
	cont "きろく　されてるよ"
	done

CeladonMart3FGameBoyKid2Text:
	text "やったー！"

	para "となりのこが　ゴーストと　ガルーラ"
	line "こうかん　してくれるって！"
	done

CeladonMart3FGameBoyKid3Text:
	text "はやく　きて！"
	line "ゴースト　ちゃーん！"

	para "ぼくは"
	line "ゴースト　マニア　なのね！"

	para "<⋯>　あー？"

	para "てんそう　されて　きた　ゴーストが"
	line "べつの　#に！？"
	done

CeladonMart3FLittleBoyText:
	text "ひとから　もらった　#は"
	line "アイディが　ちがうから　わかるよ"
	done

CeladonMart3FSNESText:
	text "スーパー　ファミコン　だ！"
	done

CeladonMart3FRPGText:
	text "ロールプレイング　ゲームだ！"
	line "<⋯>　あそんでく　ひまが　ない"
	done

CeladonMart3FSportsGameText:
	text "これは　スポーツ　ゲームだ！"
	line "<⋯>　おとうさんが　すきそう！"
	done

CeladonMart3FPuzzleGameText:
	text "パズル　ゲームだ<⋯>！"
	line "<⋯>　はじめたら　やめられない"
	done

CeladonMart3FFightingGameText:
	text "たいせん　アクションゲームだ！"
	line "<⋯>　ちょっと　むずかしそう！"
	done

CeladonMart3FCurrentFloorSignText:
	text "３かい<⋯>テレビ　ゲーム　ショップ"
	done

CeladonMart3FPokemonPosterText:
	text "あかと　みどり！"
	line "どっちも　ポケット　モンスター！"
	done
