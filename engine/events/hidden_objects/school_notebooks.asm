PrintNotebookText:
	call EnableAutoTextBoxDrawing
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, [wHiddenObjectFunctionArgument]
	jp PrintPredefTextID

TMNotebook::
	text "<TM>の　パンフレットだ！"
	line "<⋯>　<⋯>"

	para "<TM>は"
	line "ぜんぶで　５０しゅるい！"

	para "ひでんマシンは"
	line "つかっても　なくならない　タイプ"
	cont "ぜんぶで　５しゅるい　あります"

	para "<⋯>　シルフ　カンパニー@"
	text_waitbutton
	text_end

ViridianSchoolNotebook::
	text_asm
	ld hl, ViridianSchoolNotebookText1
	call PrintText
	call TurnPageSchoolNotebook
	jr nz, .doneReading
	ld hl, ViridianSchoolNotebookText2
	call PrintText
	call TurnPageSchoolNotebook
	jr nz, .doneReading
	ld hl, ViridianSchoolNotebookText3
	call PrintText
	call TurnPageSchoolNotebook
	jr nz, .doneReading
	ld hl, ViridianSchoolNotebookText4
	call PrintText
	ld hl, ViridianSchoolNotebookText5
	call PrintText
.doneReading
	jp TextScriptEnd

TurnPageSchoolNotebook:
	ld hl, TurnPageText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ret

TurnPageText:
	text "つぎのページ　あけちゃおうか？"
	done

ViridianSchoolNotebookText5:
	text "おんなのこ『あー！"
	line "ノート　みちゃ　だめ！@"
	text_waitbutton
	text_end

ViridianSchoolNotebookText1:
	text "ノートを　のぞいた！"

	para "１ページめ　<⋯>"

	para "#は"
	line "モンスターボールで　つかまえて"
	cont "６つまで　もち　あるける"

	para "#を　そだてて　たたかわせる"
	line "ひとを　#　<TRAINER>という"
	prompt

ViridianSchoolNotebookText2:
	text "２ページめ　<⋯>"

	para "#を　つかまえる　ときは"
	line "まず　よわらせてから！"
	cont "どくや　やけどで"

	para "よわらせても　いいよ！"
	line "げんきだと　うまく　とれないかも"
	prompt

ViridianSchoolNotebookText3:
	text "３ページめ　<⋯>"

	para "#どうしを　たたかわせ"
	line "かつことは　<TRAINER>に　とって"
	cont "さいこうの　よろこび　である！"

	para "かくちの　#　ジムでは"
	line "いつも　はげしい"
	cont "たたかいが　くりひろげられてる！"
	prompt

ViridianSchoolNotebookText4:
	text "４ページめ　<⋯>"

	para "#<TRAINER>の　もくひょうは"
	line "かくちの　ジムに　いる"

	para "つよい　<TRAINER>"
	line "８にんしゅうを　たおすこと！"

	para "さらに　#リーグ　ほんぶには"
	line "<⋯>　もうれつに　つよい！"

	para "してんのうが　くんりん　してる！"
	prompt
