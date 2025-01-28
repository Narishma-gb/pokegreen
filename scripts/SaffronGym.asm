SaffronGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_2, [hl]
	res BIT_CUR_MAP_LOADED_2, [hl]
	jr nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, SaffronGym_TrainerHeaders
	ld de, SaffronGym_ScriptPointers
	ld a, [wSaffronGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSaffronGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "ヤマブキ@"

.LeaderName:
	db "ナツメ@"

SaffronGymResetScripts:
	xor a ; SCRIPT_SAFFRONGYM_DEFAULT
	ld [wJoyIgnore], a
	ld [wSaffronGymCurScript], a
	ld [wCurMapScript], a
	ret

SaffronGym_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_SAFFRONGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_SAFFRONGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_SAFFRONGYM_END_BATTLE
	dw_const SaffronGymSabrinaPostBattle,           SCRIPT_SAFFRONGYM_SABRINA_POST_BATTLE

SaffronGymSabrinaPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SaffronGymResetScripts
	ld a, D_RIGHT | D_LEFT | D_UP | D_DOWN
	ld [wJoyIgnore], a

SaffronGymSabrinaReceiveTM46Script:
	ld a, TEXT_SAFFRONGYM_SABRINA_MARSH_BADGE_INFO
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_SABRINA
	lb bc, TM_PSYWAVE, 1
	call GiveItem
	jr nc, .BagFull
	ld a, TEXT_SAFFRONGYM_SABRINA_RECEIVED_TM46
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM46
	jr .gymVictory
.BagFull
	ld a, TEXT_SAFFRONGYM_SABRINA_TM46_NO_ROOM
	ldh [hTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_MARSHBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_MARSHBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_SAFFRON_GYM_TRAINER_0, EVENT_BEAT_SAFFRON_GYM_TRAINER_6

	jp SaffronGymResetScripts

SaffronGym_TextPointers:
	def_text_pointers
	dw_const SaffronGymSabrinaText,               TEXT_SAFFRONGYM_SABRINA
	dw_const SaffronGymChanneler1Text,            TEXT_SAFFRONGYM_CHANNELER1
	dw_const SaffronGymYoungster1Text,            TEXT_SAFFRONGYM_YOUNGSTER1
	dw_const SaffronGymChanneler2Text,            TEXT_SAFFRONGYM_CHANNELER2
	dw_const SaffronGymYoungster2Text,            TEXT_SAFFRONGYM_YOUNGSTER2
	dw_const SaffronGymChanneler3Text,            TEXT_SAFFRONGYM_CHANNELER3
	dw_const SaffronGymYoungster3Text,            TEXT_SAFFRONGYM_YOUNGSTER3
	dw_const SaffronGymYoungster4Text,            TEXT_SAFFRONGYM_YOUNGSTER4
	dw_const SaffronGymGymGuideText,              TEXT_SAFFRONGYM_GYM_GUIDE
	dw_const SaffronGymSabrinaMarshBadgeInfoText, TEXT_SAFFRONGYM_SABRINA_MARSH_BADGE_INFO
	dw_const SaffronGymSabrinaReceivedTM46Text,   TEXT_SAFFRONGYM_SABRINA_RECEIVED_TM46
	dw_const SaffronGymSabrinaTM46NoRoomText,     TEXT_SAFFRONGYM_SABRINA_TM46_NO_ROOM

	def_trainers SaffronGym, 2
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_0, 3, Channeler1
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_1, 3, Youngster1
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_2, 3, Channeler2
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_3, 3, Youngster2
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_4, 3, Channeler3
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_5, 3, Youngster3
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_6, 3, Youngster4
	db -1 ; end

SaffronGymSabrinaText:
	text_asm
	CheckEvent EVENT_BEAT_SABRINA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM46
	jr nz, .afterBeat
	call z, SaffronGymSabrinaReceiveTM46Script
	call DisableWaitingAfterTextDisplay
	jr .done
.afterBeat
	ld hl, .PostBattleAdviceText
	call PrintText
	jr .done
.beforeBeat
	ld hl, .Text
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, .ReceivedMarshBadgeText
	ld de, .ReceivedMarshBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $6
	ld [wGymLeaderNo], a
	ld a, SCRIPT_SAFFRONGYM_SABRINA_POST_BATTLE
	ld [wSaffronGymCurScript], a
.done
	jp TextScriptEnd

.Text:
	text "<⋯>　やっぱり　きたわ！"
	line "よかんが　したのよ！"

	para "なにげに　スプーンを　なげたら"
	line "まがって　いらい<⋯>　わたし"
	cont "エスパー　しょうじょ　なの"

	para "たたかうの　すき　じゃない　けど"
	line "あなたが　のぞむ　なら"
	cont "わたしの　ちから"
	cont "みせて　あげる！"
	done

.ReceivedMarshBadgeText:
	text "まける　なんて<⋯>！"
	line "とても　ショック！"
	cont "でも　まけは　まけ<⋯>！"

	para "わたしの　しょうぶの　あまさを"
	line "いさぎよく　みとめるわ！"

	para "かった　あかしに"
	line "ゴールド　バッジを"
	cont "あなたに　さしあげ　ましょう@"
	sound_get_key_item ; actually plays the second channel of SFX_BALL_POOF due to the wrong music bank being loaded
	text_promptbutton
	text_end

.PostBattleAdviceText:
	text "ちょうのうりょくは　かぎられた"
	line "ひとの　ちから　では　ないわ！"
	cont "だれでも　もってるのよ！"
	cont "ただ　それに　きが　つかない　だけ"
	done

SaffronGymSabrinaMarshBadgeInfoText:
	text "ゴールド　バッジで"
	line "レベル７０　までの　#が"
	cont "いうことを　ききます！"

	para "それ　いじょう"
	line "つよい　#は"
	cont "ソッポ　むいたり　ふてね　したり"
	cont "あつかいが　たいへん　です！"

	para "だけど　そだて　すぎなきゃ"
	line "そういう　しんぱいは　むようよ！"

	para "それから<⋯>！"
	line "<TM>を　もって　いって"
	done

SaffronGymSabrinaReceivedTM46Text:
	text "<PLAYER>は　ナツメから"
	line "<TM>４６を　もらった！@"
	sound_get_item_1
	text_start

	para "<TM>４６は　サイコウェーブ！"
	line "きょうりょくな　ねんぱが"
	cont "おおきな　ダメージを　あたえるわ！"
	done

SaffronGymSabrinaTM46NoRoomText:
	text "あ　にもつが　いっぱいよ"
	done

SaffronGymChanneler1Text:
	text_asm
	ld hl, SaffronGym_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymChanneler1BattleText:
	text "ナツメは<⋯>　わたし　より"
	line "だいぶ　としした　だが！"
	cont "かのじょを　そんけい　している！"
	done

SaffronGymChanneler1EndBattleText:
	text "およばなかったか！"
	prompt

SaffronGymChanneler1AfterBattleText:
	text "しょうぶが　ごかくの　ときは"
	line "きもちが　つよい　ほうが　かつ！"

	para "ナツメに　かちたい　なら"
	line "きみも　かちたいッ！　と"
	cont "つよく　ねんじた　ほうが　いい"
	done

SaffronGymYoungster1Text:
	text_asm
	ld hl, SaffronGym_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymYoungster1BattleText:
	text "みえない　ちからを　つかう"
	line "エスパーを　こわいと　おもうか！"
	done

SaffronGymYoungster1EndBattleText:
	text "こういう　ことも"
	line "あるのか<⋯>"
	prompt

SaffronGymYoungster1AfterBattleText:
	text "エスパーに　ゆうりな　もの？"
	line "<⋯>　はははーッ！"
	cont "ゆうれい　や　むし　くらい　だぜ！"
	done

SaffronGymChanneler2Text:
	text_asm
	ld hl, SaffronGym_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymChanneler2BattleText:
	text "#は"
	line "かいぬしに　にるって　しってるか？"

	para "という　ことは<⋯>"
	line "おまえの　#は　つよいかな？"
	done

SaffronGymChanneler2EndBattleText:
	text "わかった！"
	prompt

SaffronGymChanneler2AfterBattleText:
	text "わたしも　まだ　まだ　だ<⋯>"
	line "サイコキネシス　マスター　して"
	cont "#に　おしえて　なくては！"
	done

SaffronGymYoungster2Text:
	text_asm
	ld hl, SaffronGym_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymYoungster2BattleText:
	text "きみは　わかってる　だろ？"
	line "#は　パワー　だけ"
	cont "あったって　かて　ない　ことを！"
	done

SaffronGymYoungster2EndBattleText:
	text "<⋯>　おれが"
	line "まける　なんて　ばかな！"
	prompt

SaffronGymYoungster2AfterBattleText:
	text "となりの　カラテ　だいおう　だって"
	line "うちの　ナツメさんに"
	cont "コテンパンに　やられたんだぜ"
	done

SaffronGymChanneler3Text:
	text_asm
	ld hl, SaffronGym_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymChanneler3BattleText:
	text "きみは　わたしと"
	line "#を　たたかわせる<⋯>！"
	done

SaffronGymChanneler3EndBattleText:
	text "くっ<⋯>！"
	line "やはり　わたしが　やぶれたか"
	prompt

SaffronGymChanneler3AfterBattleText:
	text "こういう　けっかは　わかってた<⋯>"
	line "<⋯>　そう！"
	cont "これが　よち　のうりょく　だ"
	done

SaffronGymYoungster3Text:
	text_asm
	ld hl, SaffronGym_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymYoungster3BattleText:
	text "ナツメさんは　わかく　して"
	line "この　#　ジムを　しきる"
	cont "じつりょくしゃ！"

	para "かんたん　には　あわせ　ないぜ！"
	done

SaffronGymYoungster3EndBattleText:
	text "まけて　しまった！"
	prompt

SaffronGymYoungster3AfterBattleText:
	text "おしえて　やろう<⋯>"
	line "かつて　ヤマブキ　には"
	cont "ふたつの　#　ジムが　あった"

	para "とういつ　しあいに　まけた　のが"
	line "となりの　かくとう　どうじょうだ！"
	done

SaffronGymYoungster4Text:
	text_asm
	ld hl, SaffronGym_TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymYoungster4BattleText:
	text "ヤマブキ　ジム！"
	cont "またの　なを"
	cont "エスパー　ようせい　じょ"
	cont "おまえ<⋯>"

	para "<⋯>　ナツメに　あおうと　してるな？"
	line "そうだろ！"
	cont "わかってるんだ！"
	done

SaffronGymYoungster4EndBattleText:
	text "ぐわああ<⋯>！"
	prompt

SaffronGymYoungster4AfterBattleText:
	text "<⋯>　そうだ！"
	line "ひとの　こころを　よむ"
	cont "のうりょくを　テレパス　という！"
	done

SaffronGymGymGuideText:
	text_asm
	CheckEvent EVENT_BEAT_SABRINA
	jr nz, .afterBeat
	ld hl, .ChampInMakingText
	call PrintText
	jr .done
.afterBeat
	ld hl, .BeatSabrinaText
	call PrintText
.done
	jp TextScriptEnd

.ChampInMakingText:
	text "おーす！"
	line "みらいの　チャンピオン！"

	para "ナツメの　#は"
	line "ちょうのうりょくを　つかって"
	cont "おまえの　#を　まどわすぜ！"

	para "とくに<⋯>！　かくとう　#は"
	line "あいしょうが　わるい！"

	para "パワーを　はっきする　まえに"
	line "エジキに　なっちまう　からな！"
	done

.BeatSabrinaText:
	text "ちょうのうりょく<⋯>　か！"

	para "おれに　そんな　ものが　あったら"
	line "スロットで　あてほうだい　だぜ！"
	done
