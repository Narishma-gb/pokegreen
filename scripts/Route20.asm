Route20_Script:
	CheckAndResetEvent EVENT_IN_SEAFOAM_ISLANDS
	call nz, Route20BoulderScript
	call EnableAutoTextBoxDrawing
	ld hl, Route20_TrainerHeaders
	ld de, Route20_ScriptPointers
	ld a, [wRoute20CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute20CurScript], a
	ret

Route20BoulderScript:
	CheckBothEventsSet EVENT_SEAFOAM3_BOULDER1_DOWN_HOLE, EVENT_SEAFOAM3_BOULDER2_DOWN_HOLE
	jr z, .next_boulder_check
	ld a, HS_SEAFOAM_ISLANDS_1F_BOULDER_1
	call Route20ShowObjectScript
	ld a, HS_SEAFOAM_ISLANDS_1F_BOULDER_2
	call Route20ShowObjectScript
	ld hl, .MissableObjectIDs
.hide_missable_objects
	ld a, [hli]
	cp $ff
	jr z, .next_boulder_check
	push hl
	call Route20HideObjectScript
	pop hl
	jr .hide_missable_objects

.MissableObjectIDs:
	db HS_SEAFOAM_ISLANDS_B1F_BOULDER_1
	db HS_SEAFOAM_ISLANDS_B1F_BOULDER_2
	db HS_SEAFOAM_ISLANDS_B2F_BOULDER_1
	db HS_SEAFOAM_ISLANDS_B2F_BOULDER_2
	db HS_SEAFOAM_ISLANDS_B3F_BOULDER_3
	db HS_SEAFOAM_ISLANDS_B3F_BOULDER_4
	db -1 ; end

.next_boulder_check
	CheckBothEventsSet EVENT_SEAFOAM4_BOULDER1_DOWN_HOLE, EVENT_SEAFOAM4_BOULDER2_DOWN_HOLE
	ret z
	ld a, HS_SEAFOAM_ISLANDS_B3F_BOULDER_1
	call Route20ShowObjectScript
	ld a, HS_SEAFOAM_ISLANDS_B3F_BOULDER_2
	call Route20ShowObjectScript
	ld a, HS_SEAFOAM_ISLANDS_B4F_BOULDER_1
	call Route20HideObjectScript
	ld a, HS_SEAFOAM_ISLANDS_B4F_BOULDER_2
	call Route20HideObjectScript
	ret

Route20ShowObjectScript:
	ld [wMissableObjectIndex], a
	predef_jump ShowObject

Route20HideObjectScript:
	ld [wMissableObjectIndex], a
	predef_jump HideObject

Route20_ScriptPointers:
	def_script_pointers
	dw_const CheckFightingMapTrainers,              SCRIPT_ROUTE20_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_ROUTE20_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_ROUTE20_END_BATTLE

Route20_TextPointers:
	def_text_pointers
	dw_const Route20Swimmer1Text,           TEXT_ROUTE20_SWIMMER1
	dw_const Route20Swimmer2Text,           TEXT_ROUTE20_SWIMMER2
	dw_const Route20Swimmer3Text,           TEXT_ROUTE20_SWIMMER3
	dw_const Route20Swimmer4Text,           TEXT_ROUTE20_SWIMMER4
	dw_const Route20Swimmer5Text,           TEXT_ROUTE20_SWIMMER5
	dw_const Route20Swimmer6Text,           TEXT_ROUTE20_SWIMMER6
	dw_const Route20CooltrainerMText,       TEXT_ROUTE20_COOLTRAINER_M
	dw_const Route20Swimmer7Text,           TEXT_ROUTE20_SWIMMER7
	dw_const Route20Swimmer8Text,           TEXT_ROUTE20_SWIMMER8
	dw_const Route20Swimmer9Text,           TEXT_ROUTE20_SWIMMER9
	dw_const Route20SeafoamIslandsSignText, TEXT_ROUTE20_SEAFOAM_ISLANDS_WEST_SIGN
	dw_const Route20SeafoamIslandsSignText, TEXT_ROUTE20_SEAFOAM_ISLANDS_EAST_SIGN

	def_trainers Route20
	trainer EVENT_BEAT_ROUTE_20_TRAINER_0, 4, Swimmer1
	trainer EVENT_BEAT_ROUTE_20_TRAINER_1, 4, Swimmer2
	trainer EVENT_BEAT_ROUTE_20_TRAINER_2, 2, Swimmer3
	trainer EVENT_BEAT_ROUTE_20_TRAINER_3, 4, Swimmer4
	trainer EVENT_BEAT_ROUTE_20_TRAINER_4, 3, Swimmer5
	trainer EVENT_BEAT_ROUTE_20_TRAINER_5, 4, Swimmer6
	trainer EVENT_BEAT_ROUTE_20_TRAINER_6, 2, CooltrainerM
	trainer EVENT_BEAT_ROUTE_20_TRAINER_7, 4, Swimmer7
	trainer EVENT_BEAT_ROUTE_20_TRAINER_8, 3, Swimmer8
	trainer EVENT_BEAT_ROUTE_20_TRAINER_9, 4, Swimmer9
	db -1 ; end

Route20Swimmer1Text:
	text_asm
	ld hl, Route20_TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route20Swimmer1BattleText:
	text "とおあさに　なってる　から"
	line "およいでる　ひとも　おおいよ！"
	done

Route20Swimmer1EndBattleText:
	text "うーみーッ！"
	prompt

Route20Swimmer1AfterBattleText:
	text "きみは　#に　のってて"
	line "つかれ　ないから　いいなあ"
	done

Route20Swimmer2Text:
	text_asm
	ld hl, Route20_TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route20Swimmer2BattleText:
	text "ふたごじまに"
	line "リゾートに　きてるの　わたし"
	done

Route20Swimmer2EndBattleText:
	text "ちょっと　やめてよ"
	prompt

Route20Swimmer2AfterBattleText:
	text "ふたごじまの　ちかに"
	line "しょうにゅうどうが　あるんだって"
	done

Route20Swimmer3Text:
	text_asm
	ld hl, Route20_TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route20Swimmer3BattleText:
	text "なみまに　ぷかぷか　うかぶ"
	line "<⋯>　あたしは　おさかな"
	done

Route20Swimmer3EndBattleText:
	text "うー　まんぼう！"
	prompt

Route20Swimmer3AfterBattleText:
	text "あなた　いっしょに"
	line "<⋯>　ぷかぷか　しない？"
	done

Route20Swimmer4Text:
	text_asm
	ld hl, Route20_TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route20Swimmer4BattleText:
	text "きみも　リゾートに　きてるの？"
	done

Route20Swimmer4EndBattleText:
	text "てかげん　なしね"
	prompt

Route20Swimmer4AfterBattleText:
	text "ふたごじまは　むかしは"
	line "ふたつの　しま　だった　らしいね"
	done

Route20Swimmer5Text:
	text_asm
	ld hl, Route20_TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route20Swimmer5BattleText:
	text "みよーッ！"
	line "きたえ　あげた　この　からだ！"
	done

Route20Swimmer5EndBattleText:
	text "ふにゃふにゃだ"
	prompt

Route20Swimmer5AfterBattleText:
	text "じぶんの　からだ　より"
	line "#を　きたえる　べきだった"
	done

Route20Swimmer6Text:
	text_asm
	ld hl, Route20_TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route20Swimmer6BattleText:
	text "#に　のってる　なんて"
	line "もしかして　およげない　とか？"
	done

Route20Swimmer6EndBattleText:
	text "うー　ぶくぶく"
	prompt

Route20Swimmer6AfterBattleText:
	text "#に　のって　いくのも"
	line "たのしそうだなあ"
	done

Route20CooltrainerMText:
	text_asm
	ld hl, Route20_TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route20CooltrainerMBattleText:
	text "とり　#に　つかまって"
	line "ここまで　きたよ"
	done

Route20CooltrainerMEndBattleText:
	text "あ！　こまったな"
	prompt

Route20CooltrainerMAfterBattleText:
	text "とりが　へばちゃって　もどれないぞ"
	line "<⋯>　どうしよう"
	done

Route20Swimmer7Text:
	text_asm
	ld hl, Route20_TrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

Route20Swimmer7BattleText:
	text "かれに"
	line "おっきな　しんじゅ　もらったわ！"
	done

Route20Swimmer7EndBattleText:
	text "やーん！"
	line "しんじゅ　いり　なのに<⋯>"
	prompt

Route20Swimmer7AfterBattleText:
	text "パルシェン　もっと　そだてたら"
	line "しんじゅも　おっきく　なるかしら"
	done

Route20Swimmer8Text:
	text_asm
	ld hl, Route20_TrainerHeader8
	call TalkToTrainer
	jp TextScriptEnd

Route20Swimmer8BattleText:
	text "グレン　じま　から"
	line "およいで　きたけど<⋯>　きついわ！"
	done

Route20Swimmer8EndBattleText:
	text "がっかり"
	prompt

Route20Swimmer8AfterBattleText:
	text "グレン　じまの"
	line "だれも　すんでない　おやしき"
	cont "いつからか　#が　すみついて"
	cont "#　やしきと　よばれてる"
	done

Route20Swimmer9Text:
	text_asm
	ld hl, Route20_TrainerHeader9
	call TalkToTrainer
	jp TextScriptEnd

Route20Swimmer9BattleText:
	text "にしに　ある　グレン　じまは"
	line "#　けんきゅうの　しま！"
	cont "あそこで　パパも　はたらいてるわ"
	done

Route20Swimmer9EndBattleText:
	text "まってよ　もう！"
	prompt

Route20Swimmer9AfterBattleText:
	text "グレンは　かざんの　ふんかで"
	line "もりあがって　できたって　きいたわ"
	done

Route20SeafoamIslandsSignText:
	text "ふたごじま"
	done
