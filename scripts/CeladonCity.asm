CeladonCity_Script:
	call EnableAutoTextBoxDrawing
	ResetEvents EVENT_1B8, EVENT_1BF
	ResetEvent EVENT_67F
	ret

CeladonCity_TextPointers:
	def_text_pointers
	dw_const CeladonCityLittleGirlText,        TEXT_CELADONCITY_LITTLE_GIRL
	dw_const CeladonCityGramps1Text,           TEXT_CELADONCITY_GRAMPS1
	dw_const CeladonCityGirlText,              TEXT_CELADONCITY_GIRL
	dw_const CeladonCityGramps2Text,           TEXT_CELADONCITY_GRAMPS2
	dw_const CeladonCityGramps3Text,           TEXT_CELADONCITY_GRAMPS3
	dw_const CeladonCityFisherText,            TEXT_CELADONCITY_FISHER
	dw_const CeladonCityPoliwrathText,         TEXT_CELADONCITY_POLIWRATH
	dw_const CeladonCityRocket1Text,           TEXT_CELADONCITY_ROCKET1
	dw_const CeladonCityRocket2Text,           TEXT_CELADONCITY_ROCKET2
	dw_const CeladonCityTrainerTips1Text,      TEXT_CELADONCITY_TRAINER_TIPS1
	dw_const CeladonCitySignText,              TEXT_CELADONCITY_SIGN
	dw_const PokeCenterSignText,               TEXT_CELADONCITY_POKECENTER_SIGN
	dw_const CeladonCityGymSignText,           TEXT_CELADONCITY_GYM_SIGN
	dw_const CeladonCityMansionSignText,       TEXT_CELADONCITY_MANSION_SIGN
	dw_const CeladonCityDeptStoreSignText,     TEXT_CELADONCITY_DEPTSTORE_SIGN
	dw_const CeladonCityTrainerTips2Text,      TEXT_CELADONCITY_TRAINER_TIPS2
	dw_const CeladonCityPrizeExchangeSignText, TEXT_CELADONCITY_PRIZEEXCHANGE_SIGN
	dw_const CeladonCityGameCornerSignText,    TEXT_CELADONCITY_GAMECORNER_SIGN

CeladonCityLittleGirlText:
	text "わたしの　ドガース！"
	line "グレンじま　で　つかまえたの！"
	cont "おこると　どくガス　はくけど<⋯>"

	para "ふだんは　いいこ　なのよ"
	done

CeladonCityGramps1Text:
	text "にひひ！　この　ジムは　ええ！"
	line "おんなのこ　ばっかし　じゃ！"
	done

CeladonCityGirlText:
	text "きれいな　まちづくりが　じまんの"
	line "タマムシに　ゲーム　コーナーが"
	cont "できちゃって！　こまった　ものよ！"
	done

CeladonCityGramps2Text:
	text "トホホ<⋯>！"
	line "スロットで　また　まけた！"

	para "コインが　たまったら"
	line "けいひんに　した　ほうが　ええと"
	cont "わかって　おったのに<⋯>！"
	done

CeladonCityGramps3Text:
	text_asm
	CheckEvent EVENT_GOT_TM41
	jr nz, .gotTM41
	ld hl, .Text
	call PrintText
	lb bc, TM_SOFTBOILED, 1
	call GiveItem
	jr c, .Success
	ld hl, .TM41NoRoomText
	call PrintText
	jr .Done
.Success
	ld hl, .ReceivedTM41Text
	call PrintText
	SetEvent EVENT_GOT_TM41
	jr .Done
.gotTM41
	ld hl, .TM41ExplanationText
	call PrintText
.Done
	jp TextScriptEnd

.Text:
	text "やあ　やあ！"

	para "わたしは　いつも　きみが"
	line "そこを　とおるのを　みてたが"
	cont "やっと　あう　ことが　できた！"

	para "それでは　とっておきの"
	line "これを！　きみに　あげよう！"
	prompt

.ReceivedTM41Text:
	text "<PLAYER>は　おじさんから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_item_1
	text_end

.TM41ExplanationText:
	text "<TM>４１の　なかは"
	line "タマゴうみ　である！"

	para "これを　つかえる　#は"
	line "１しゅるい　だけ　である！"

	para "そういう　#は"
	line "ラッキー　である！"
	done

.TM41NoRoomText:
	text "にもつが　いっぱいだ"
	done

CeladonCityFisherText:
	text "こいつ　おれの　あいかた！"
	line "ニョロボン！"

	para "みずのいしを　あてたら"
	line "ニョロゾ　が　しんか　したよ"
	done

CeladonCityPoliwrathText:
	text "ニョロボン『ゲロゲーロ！@"
	text_asm
	ld a, POLIWRATH
	call PlayCry
	jp TextScriptEnd

CeladonCityRocket1Text:
	text "なんだ　ジロジロ　みやがって！"
	line "あっち　いかねえと　ぶんなぐるぞ！"
	done

CeladonCityRocket2Text:
	text "めの　まえを　チョロチョロうるせえ！"
	line "ロケットだんを　なめるなよ！"
	done

CeladonCityTrainerTips1Text:
	text "<⋯>　おとくな　けいじばん！"

	para "ヨクアタールは　わざの"
	line "めいちゅう　りつ　を　あげる！"

	para "クリティカッターは　わざが"
	line "きゅうしょに　あたり　やすくなる"

	para "アイテムの　おかいもとめは"
	line "タマムシ　デパートで　どうぞ！"
	done

CeladonCitySignText:
	text "ここは　タマムシ　シティ"
	line "タマムシ　にじいろ　ゆめの　いろ"
	done

CeladonCityGymSignText:
	text "タマムシ　シティ　#　ジム"
	line "リーダー　エリカ"
	cont "しぜんを　あいする　おじょうさま！"
	done

CeladonCityMansionSignText:
	text "タマムシ　マンション"
	done

CeladonCityDeptStoreSignText:
	text "ほしいもの　きっと　みつかる！"
	line "タマムシ　デパート"
	done

CeladonCityTrainerTips2Text:
	text "<⋯>　おとくな　けいじばん！"

	para "エフェクトガードは"
	line "ほのお　や　みず　でんき　など"

	para "とくしゅな　こうげき　から"
	line "#を　まもって　くれる！"

	para "アイテムの　おかいもとめは"
	line "タマムシ　デパートで　どうぞ！"
	done

CeladonCityPrizeExchangeSignText:
	text "コインを　ビッグな　けいひんに！"
	line "<⋯>　けいひん　こうかんじょ"
	done

CeladonCityGameCornerSignText:
	text "おとなの　あそびば！"
	line "<⋯>　ロケット·　ゲーム　コーナー"
	done
