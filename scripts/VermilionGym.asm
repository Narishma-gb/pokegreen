VermilionGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit BIT_CUR_MAP_LOADED_1, [hl]
	res BIT_CUR_MAP_LOADED_1, [hl]
	push hl
	call nz, .LoadNames
	pop hl
	bit BIT_CUR_MAP_LOADED_2, [hl]
	res BIT_CUR_MAP_LOADED_2, [hl]
	call nz, VermilionGymSetDoorTile
	call EnableAutoTextBoxDrawing
	ld hl, VermilionGym_TrainerHeaders
	ld de, VermilionGym_ScriptPointers
	ld a, [wVermilionGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wVermilionGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "クチバ@"

.LeaderName:
	db "マチス@"

VermilionGymSetDoorTile:
	CheckEvent EVENT_2ND_LOCK_OPENED
	jr nz, .doorsOpen
	ld a, $24 ; double door tile ID
	jr .replaceTile
.doorsOpen
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, $5 ; clear floor tile ID
.replaceTile
	ld [wNewTileBlockID], a
	lb bc, 2, 2
	predef_jump ReplaceTileBlock

VermilionGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wVermilionGymCurScript], a
	ld [wCurMapScript], a
	ret

VermilionGym_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_VERMILIONGYM_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_VERMILIONGYM_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_VERMILIONGYM_END_BATTLE
	dw_const VermilionGymLTSurgeAfterBattleScript,  SCRIPT_VERMILIONGYM_LT_SURGE_AFTER_BATTLE

VermilionGymLTSurgeAfterBattleScript:
	ld a, [wIsInBattle]
	cp $ff ; did we lose?
	jp z, VermilionGymResetScripts
	ld a, PAD_CTRL_PAD
	ld [wJoyIgnore], a

VermilionGymLTSurgeReceiveTM24Script:
	ld a, TEXT_VERMILIONGYM_LT_SURGE_THUNDER_BADGE_INFO
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_LT_SURGE
	lb bc, TM_THUNDERBOLT, 1
	call GiveItem
	jr nc, .bag_full
	ld a, TEXT_VERMILIONGYM_LT_SURGE_RECEIVED_TM24
	ldh [hTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM24
	jr .gym_victory
.bag_full
	ld a, TEXT_VERMILIONGYM_LT_SURGE_TM24_NO_ROOM
	ldh [hTextID], a
	call DisplayTextID
.gym_victory
	ld hl, wObtainedBadges
	set BIT_THUNDERBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_THUNDERBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_VERMILION_GYM_TRAINER_0, EVENT_BEAT_VERMILION_GYM_TRAINER_2

	jp VermilionGymResetScripts

VermilionGym_TextPointers:
	def_text_pointers
	dw_const VermilionGymLTSurgeText,                 TEXT_VERMILIONGYM_LT_SURGE
	dw_const VermilionGymGentlemanText,               TEXT_VERMILIONGYM_GENTLEMAN
	dw_const VermilionGymSuperNerdText,               TEXT_VERMILIONGYM_SUPER_NERD
	dw_const VermilionGymSailorText,                  TEXT_VERMILIONGYM_SAILOR
	dw_const VermilionGymGymGuideText,                TEXT_VERMILIONGYM_GYM_GUIDE
	dw_const VermilionGymLTSurgeThunderBadgeInfoText, TEXT_VERMILIONGYM_LT_SURGE_THUNDER_BADGE_INFO
	dw_const VermilionGymLTSurgeReceivedTM24Text,     TEXT_VERMILIONGYM_LT_SURGE_RECEIVED_TM24
	dw_const VermilionGymLTSurgeTM24NoRoomText,       TEXT_VERMILIONGYM_LT_SURGE_TM24_NO_ROOM

	def_trainers VermilionGym, 2
	trainer EVENT_BEAT_VERMILION_GYM_TRAINER_0, 3, Gentleman
	trainer EVENT_BEAT_VERMILION_GYM_TRAINER_1, 2, SuperNerd
	trainer EVENT_BEAT_VERMILION_GYM_TRAINER_2, 3, Sailor
	db -1 ; end

VermilionGymLTSurgeText:
	text_asm
	CheckEvent EVENT_BEAT_LT_SURGE
	jr z, .before_beat
	CheckEventReuseA EVENT_GOT_TM24
	jr nz, .got_tm24_already
	call z, VermilionGymLTSurgeReceiveTM24Script
	call DisableWaitingAfterTextDisplay
	jr .text_script_end
.got_tm24_already
	ld hl, .PostBattleAdviceText
	call PrintText
	jr .text_script_end
.before_beat
	ld hl, .PreBattleText
	call PrintText
	ld hl, wStatusFlags3
	set BIT_TALKED_TO_TRAINER, [hl]
	set BIT_PRINT_END_BATTLE_TEXT, [hl]
	ld hl, VermilionGymLTSurgeReceivedThunderBadgeText
	ld de, VermilionGymLTSurgeReceivedThunderBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $3
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	ld a, SCRIPT_VERMILIONGYM_LT_SURGE_AFTER_BATTLE
	ld [wVermilionGymCurScript], a
	ld [wCurMapScript], a
.text_script_end
	jp TextScriptEnd

.PreBattleText:
	text "ヘーイ！"
	line "プア　リトル　ボーイ！"

	para "ユーの　ハンパな　パワーでは"
	line "せんじょうじゃ　いき　のこれないネ"

	para "ミーは　せんそうで"
	line "エレクトリック　#　つかって"
	cont "いき　のびたネ！"

	para "みんな　ビリビリ　シビレて"
	line "うごけナーイ！"

	para "ユーも　おなじ　みち　たどる"
	line "ちがい　ナーイ！"
	done

.PostBattleAdviceText:
	text "ヘイ！"
	line "それから　ユーに　アドバイス！"

	para "エレクトリック　パワー"
	line "ビリビリ　つよいネー！"

	para "でも　じめん　タイプには"
	line "パワー　すいとられて　しまって"
	cont "ぜんぜん　きかないヨー！"
	done

VermilionGymLTSurgeThunderBadgeInfoText:
	text "オレンジ　バッジ　もってる　だけで"
	line "ユーの　#　スピード　アップ"

	para "アーンド！　そらをとぶ　わざは"
	line "ファイト　ない　ときも"
	cont "つかえる　ように　なるヨ！"

	para "ユーは　スペシャル！"
	line "これは　ミーの　きもちネ！"
	done

VermilionGymLTSurgeReceivedTM24Text:
	text "<PLAYER>は　マチスから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_key_item
	text_start

	para "<TM>２４は"
	line "でんき　ビリビリ　１０まんボルト"

	para "エレクトリック　#に"
	line "おしえて　くだサーイ！"
	done

VermilionGymLTSurgeTM24NoRoomText:
	text "フル　オブ　ユア　リュック！"
	line "あなた　もてませーん！"
	done

VermilionGymLTSurgeReceivedThunderBadgeText:
	text "オー　ノー！"

	para "ユーの　つよさ　トゥルース！"
	line "つまり　ほんもの　ネー！"

	para "オッケー！"
	line "オレンジ　バッジ　やるヨ！"
	prompt

VermilionGymGentlemanText:
	text_asm
	ld hl, VermilionGym_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

VermilionGymGentlemanBattleText:
	text "ぐんたいに　いた　ころは"
	line "マチス　しょうさに"
	cont "ビシ！ビシ！　きたえられたぜ！"
	done

VermilionGymGentlemanEndBattleText:
	text "うむ！"
	line "なかなかの　うでまえだ"
	prompt

VermilionGymGentlemanAfterBattleText:
	text "へやが　あかないのか？"

	para "マチス　の　ようじん　ぶかさは"
	line "ぐんたいでも　ゆうめい　だったぜ！"
	done

VermilionGymSuperNerdText:
	text_asm
	ld hl, VermilionGym_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

VermilionGymSuperNerdBattleText:
	text "おれは　たいりょく　ないけど"
	line "でんきの　あつかいを　かわれて"
	cont "ここに　きたのだ！"
	done

VermilionGymSuperNerdEndBattleText:
	text "ひゅー！　しびれた！"
	prompt

VermilionGymSuperNerdAfterBattleText:
	text "わかった　いうよー！"

	para "マチスは　へやの　スイッチを"
	line "なにかの<⋯>"
	cont "そこに　かくしたと　いってたな"
	done

VermilionGymSailorText:
	text_asm
	ld hl, VermilionGym_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

VermilionGymSailorBattleText:
	text "いくら　#　うまい　からって"
	line "ここは　こどもが"
	cont "くる　ところ　じゃないぜ！"
	done

VermilionGymSailorEndBattleText:
	text "ほー　おどろきだ！"
	prompt

VermilionGymSailorAfterBattleText:
	text "マチス　しょうさは"
	line "へやを　２じゅう　ロック　してるぜ"
	cont "<⋯>　ヒントを　あげよう！"

	para "だい１　ロックを　はずしたら"
	line "だい２　ロックは　すぐ　そばだ"
	cont "ふたつの　ロックは"
	cont "となりあわせに　あるぜ"
	done

VermilionGymGymGuideText:
	text_asm
	ld a, [wBeatGymFlags]
	bit BIT_THUNDERBADGE, a
	jr nz, .got_thunderbadge
	ld hl, .ChampInMakingText
	call PrintText
	jr .text_script_end
.got_thunderbadge
	ld hl, .BeatLTSurgeText
	call PrintText
.text_script_end
	jp TextScriptEnd

.ChampInMakingText:
	text "おーす！"
	line "みらいの　チャンピオン！"

	para "マチス　しょうさの　あだなは"
	line "イナズマ　アメリカン！"

	para "でんき　#　つかわせたら"
	line "アメリカ　ナンバー１　らしいぜ！"

	para "ひこう　タイプ　みず　タイプは"
	line "あいしょうが　わるいぜ！"

	para "マヒ　させられないよう"
	line "きを　つけな！"

	para "それと　マチスは　ようじん　ぶかい！"
	line "かれの　へやは　ロック　されて"
	cont "かんたんには　はいれないぜ！"
	done

.BeatLTSurgeText:
	text "ふー　こくさい　じあいに"
	line "きんちょー　したぜ"
	done
