SaffronCity_Script:
	jp EnableAutoTextBoxDrawing

SaffronCity_TextPointers:
	def_text_pointers
	dw_const SaffronCityRocket1Text,                  TEXT_SAFFRONCITY_ROCKET1
	dw_const SaffronCityRocket2Text,                  TEXT_SAFFRONCITY_ROCKET2
	dw_const SaffronCityRocket3Text,                  TEXT_SAFFRONCITY_ROCKET3
	dw_const SaffronCityRocket4Text,                  TEXT_SAFFRONCITY_ROCKET4
	dw_const SaffronCityRocket5Text,                  TEXT_SAFFRONCITY_ROCKET5
	dw_const SaffronCityRocket6Text,                  TEXT_SAFFRONCITY_ROCKET6
	dw_const SaffronCityRocket7Text,                  TEXT_SAFFRONCITY_ROCKET7
	dw_const SaffronCityScientistText,                TEXT_SAFFRONCITY_SCIENTIST
	dw_const SaffronCitySilphWorkerMText,             TEXT_SAFFRONCITY_SILPH_WORKER_M
	dw_const SaffronCitySilphWorkerFText,             TEXT_SAFFRONCITY_SILPH_WORKER_F
	dw_const SaffronCityGentlemanText,                TEXT_SAFFRONCITY_GENTLEMAN
	dw_const SaffronCityPidgeotText,                  TEXT_SAFFRONCITY_PIDGEOT
	dw_const SaffronCityRockerText,                   TEXT_SAFFRONCITY_ROCKER
	dw_const SaffronCityRocket8Text,                  TEXT_SAFFRONCITY_ROCKET8
	dw_const SaffronCityRocket9Text,                  TEXT_SAFFRONCITY_ROCKET9
	dw_const SaffronCitySignText,                     TEXT_SAFFRONCITY_SIGN
	dw_const SaffronCityFightingDojoSignText,         TEXT_SAFFRONCITY_FIGHTING_DOJO_SIGN
	dw_const SaffronCityGymSignText,                  TEXT_SAFFRONCITY_GYM_SIGN
	dw_const MartSignText,                            TEXT_SAFFRONCITY_MART_SIGN
	dw_const SaffronCityTrainerTips1Text,             TEXT_SAFFRONCITY_TRAINER_TIPS1
	dw_const SaffronCityTrainerTips2Text,             TEXT_SAFFRONCITY_TRAINER_TIPS2
	dw_const SaffronCitySilphCoSignText,              TEXT_SAFFRONCITY_SILPH_CO_SIGN
	dw_const PokeCenterSignText,                      TEXT_SAFFRONCITY_POKECENTER_SIGN
	dw_const SaffronCityMrPsychicsHouseSignText,      TEXT_SAFFRONCITY_MR_PSYCHICS_HOUSE_SIGN
	dw_const SaffronCitySilphCoLatestProductSignText, TEXT_SAFFRONCITY_SILPH_CO_LATEST_PRODUCT_SIGN

SaffronCityRocket1Text:
	text "なんだァ！"
	line "ぼうず！　あっち　いけ！"
	done

SaffronCityRocket2Text:
	text "ボスは　この　まちを"
	line "<ROCKET>の　ものに　するってよォ"
	done

SaffronCityRocket3Text:
	text "こらァ　おれたちに　さからうと"
	line "いたい　めに　あうぞ！"
	done

SaffronCityRocket4Text:
	text "ヤマブキ　シティ　ごと"
	line "<ROCKET>が　のっとったぜ！"
	done

SaffronCityRocket5Text:
	text "わるい　こと　やりまくると"
	line "スカッと　するぜ！"
	done

SaffronCityRocket6Text:
	text "いてッ！　この　やろ！"
	line "どこ　みて　あるいてんだよ！"
	done

SaffronCityRocket7Text:
	text "シルフ　カンパニー　のっとったら"
	line "せかい　じゅうに　#　うって"
	cont "ガバガバ　おお　もうけ　だぜ！"
	done

SaffronCityScientistText:
	text "<ROCKET>　やっつけたの"
	line "たった　ひとり　だって<⋯>　すごいな"
	done

SaffronCitySilphWorkerMText:
	text "ばんざーい！"
	line "<ROCKET>が　いなくなった！"
	cont "ビビらないで　そと　あるけるんだ！"
	done

SaffronCitySilphWorkerFText:
	text "ヤマブキ　シティも　いちじは"
	line "ひとが　にげて　へっちゃった　けど"
	cont "にぎやかな　まちに　もどるわ！"
	done

SaffronCityGentlemanText:
	text "<ROCKET>が　シルフ　おそって"
	line "だいじけんって　きいて！"
	cont "ピジョットで　とんで　きたッス"

	para "かいけつ　した<⋯>？"
	line "すんません！"
	cont "ねっからの　ヤジウマ　で！"
	done

SaffronCityPidgeotText:
	text "ピジョット『ビビーッ！@"
	sound_cry_pidgeot
	text_end

SaffronCityRockerText:
	text "おれ　みたぜ！　シルフの　ビル　から"
	line "ロケットの　ボスが　にげて　いくの！"
	done

SaffronCityRocket8Text:
	text "わたしは　けいびいんだが"
	line "あやしい　こどもは"

	para "とおせんぼ　することに　してるのだ"
	done

SaffronCityRocket9Text:
	text "<⋯>　<⋯>　<⋯>"
	line "<⋯>こっくり　こっくり"

	para "しめしめ！　いねむり　しているぞ"
	done

SaffronCitySignText:
	text "ここは　ヤマブキ　シティ"
	line "ヤマブキ　きんいろ　かがやきのいろ"
	done

SaffronCityFightingDojoSignText:
	text "かくとう　どうじょう！"
	done

SaffronCityGymSignText:
	text "ヤマブキ　シティ　#　ジム"
	line "リーダー　ナツメ"
	cont "エスパー　しょうじょ！"
	done

SaffronCityTrainerTips1Text:
	text "<⋯>　おとくな　けいじばん！"

	para "なんでも　なおしは"
	line "ねむり　どく　やけど　こおり<⋯>"
	cont "なんでも　なおします！"

	para "すこし　たかい　けど"
	line "ねむけざまし　どくけし　などを"
	cont "バラバラに　かうより　らくちん！"
	done

SaffronCityTrainerTips2Text:
	text "<⋯>　おとくな　けいじばん！"

	para "しんせいひん　スーパーボールは"
	line "モンスターボール　より　かくじつに"
	cont "#を　つかまえます！"

	para "なかなか　つかまえ　られない"
	line "#には　こちらを　ためそう！"
	done

SaffronCitySilphCoSignText:
	text "シルフ　カンパニー　ほんしゃ　ビル"
	done

SaffronCityMrPsychicsHouseSignText:
	text "エスパー　おやじの　いえ"
	done

SaffronCitySilphCoLatestProductSignText:
	text "シルフ　うわさの　しんせいひん！"
	line "<⋯>　はつばいび　みてい"
	done
