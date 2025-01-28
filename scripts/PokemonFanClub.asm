PokemonFanClub_Script:
	jp EnableAutoTextBoxDrawing

PokemonFanClub_CheckBikeInBag:
; check if any bike paraphernalia in bag
	CheckEvent EVENT_GOT_BIKE_VOUCHER
	ret nz
	ld b, BICYCLE
	call IsItemInBag
	ret nz
	ld b, BIKE_VOUCHER
	jp IsItemInBag

PokemonFanClub_TextPointers:
	def_text_pointers
	dw_const PokemonFanClubPikachuFanText,   TEXT_POKEMONFANCLUB_PIKACHU_FAN
	dw_const PokemonFanClubSeelFanText,      TEXT_POKEMONFANCLUB_SEEL_FAN
	dw_const PokemonFanClubPikachuText,      TEXT_POKEMONFANCLUB_PIKACHU
	dw_const PokemonFanClubSeelText,         TEXT_POKEMONFANCLUB_SEEL
	dw_const PokemonFanClubChairmanText,     TEXT_POKEMONFANCLUB_CHAIRMAN
	dw_const PokemonFanClubReceptionistText, TEXT_POKEMONFANCLUB_RECEPTIONIST
	dw_const PokemonFanClubSign1Text,        TEXT_POKEMONFANCLUB_SIGN_1
	dw_const PokemonFanClubSign2Text,        TEXT_POKEMONFANCLUB_SIGN_2

PokemonFanClubPikachuFanText:
	text_asm
	CheckEvent EVENT_PIKACHU_FAN_BOAST
	jr nz, .mineisbetter
	ld hl, .NormalText
	call PrintText
	SetEvent EVENT_SEEL_FAN_BOAST
	jr .done
.mineisbetter
	ld hl, .BetterText
	call PrintText
	ResetEvent EVENT_PIKACHU_FAN_BOAST
.done
	jp TextScriptEnd

.NormalText:
	text "みてよ！　うちの　ピカチュウ"
	line "なんて　かわいい　しっぽ！"
	done

.BetterText:
	text "なにを！"
	
	para "うちの　ピカチュウの　ほうが"
	line "その　ばいは　かわいい　わい！"
	done

PokemonFanClubSeelFanText:
	text_asm
	CheckEvent EVENT_SEEL_FAN_BOAST
	jr nz, .mineisbetter
	ld hl, .NormalText
	call PrintText
	SetEvent EVENT_PIKACHU_FAN_BOAST
	jr .done
.mineisbetter
	ld hl, .BetterText
	call PrintText
	ResetEvent EVENT_SEEL_FAN_BOAST
.done
	jp TextScriptEnd

.NormalText:
	text "あたしの　いとしい　パウワウ！"

	para "だきしめると"
	line "きゅー！　って　なくのよ！"
	done

.BetterText:
	text "おほほ！"

	para "あたしの　パウワウの　ほうが"
	line "その　ばいは　かわいいわよ！"
	done

PokemonFanClubPikachuText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, PIKACHU
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

.Text
	text "ピカチュウ『ちゅー　ぴかちゅ"
	done

PokemonFanClubSeelText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, SEEL
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

.Text:
	text "パウワウ『きゅー"
	done

PokemonFanClubChairmanText:
	text_asm
	call PokemonFanClub_CheckBikeInBag
	jr nz, .nothingleft

	ld hl, .IntroText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .nothanks

	; tell the story
	ld hl, .StoryText
	call PrintText
	lb bc, BIKE_VOUCHER, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .BikeVoucherText
	call PrintText
	SetEvent EVENT_GOT_BIKE_VOUCHER
	jr .done
.bag_full
	ld hl, .BagFullText
	call PrintText
	jr .done
.nothanks
	ld hl, .NoStoryText
	call PrintText
	jr .done
.nothingleft
	ld hl, .FinalText
	call PrintText
.done
	jp TextScriptEnd

.IntroText:
	text "#　だいすき　クラブの"
	line "かいちょうは　わし　じゃ！"

	para "かってる　#は"
	line "１００ぴきを　こえとる！"

	para "#に　かんしては"
	line "ホント　うるさい！　ですぞ！"

	para "で<⋯>"

	para "きみは　わしの　#　じまんを"
	line "ききに　きたの　かね？"
	done

.StoryText:
	text "そうか！"
	line "では　さっそく　はじめるか！"

	para "あのな<⋯>　わしの　おきにいりの"
	line "ギャロップがな<⋯>　<⋯>"

	para "<⋯>　でな<⋯>　が<⋯>"
	cont "<⋯>　<⋯>　かわいくてな<⋯>"
	cont "たまらん<⋯>　くう<⋯>"
	cont "<⋯>　さらに<⋯>　もう<⋯>"
	cont "すごすぎ<⋯>　<⋯>　で<⋯>"
	cont "<⋯>　そう　おもうか<⋯>"
	cont "どうして<⋯>　<⋯>　すき<⋯>"
	cont "<⋯>　はー！"

	para "<⋯>　<⋯>　だきしめて<⋯>"
	cont "ねるときも<⋯>"
	cont "<⋯>　じゃろ<⋯>　<⋯>"
	cont "<⋯>　<⋯>　すばらし<⋯>！"
	cont "<⋯>　うつくし<⋯>"
	cont "<⋯>　<⋯>　ありゃ！"
	cont "もう　こんな　じかんか！"
	cont "ちょっと　しゃべり　すぎたわい"

	para "わしの　#　じまんを"
	line "おとなしく　きいてた　おれいに"
	cont "<⋯>これは　きもち　じゃ！"
	prompt

.BikeVoucherText:
	text "<PLAYER>は　かいちょうから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_key_item
	text_start

	para "その　ひきかえけんで"
	line "タダで　じてんしゃが　もらえる！"

	para "なに　わしには　おきにいりの"
	line "とり#　オニドリルが　おる"
	cont "いきたい　ところへ　ひとっとびじゃ"

	para "だから　じてんしゃ　など　いらん！"

	para "じてんしゃは　きみが"
	line "すきに　のったら　ええ！"
	done

.NoStoryText:
	text "なんじゃ<⋯>　つまらん"
	line "きく　きに　なったら　きてくれい！"
	done

.FinalText:
	text "やー　やー　<PLAYER>くん！"

	para "また　わしの　#　じまんを"
	line "ききに　きたの　かね！"

	para "<⋯>　え　ちがう？"
	line "なんじゃ<⋯>　つまらん"
	done

.BagFullText:
	text "にもつが　いっぱい　じゃ！"
	done

PokemonFanClubReceptionistText:
	text "うちの　かいちょうは"
	line "ホント　#に　うるさいの！"
	done

PokemonFanClubSign1Text:
	text "かいぬしの　じまん　ばなしには"
	line "しずかに　みみを　かたむけよう！"
	done

PokemonFanClubSign2Text:
	text "ひとの　じまん　ばなしは"
	line "１０ばい　にして　かえそう！"
	done
