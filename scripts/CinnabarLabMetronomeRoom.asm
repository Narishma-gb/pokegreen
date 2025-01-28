CinnabarLabMetronomeRoom_Script:
	jp EnableAutoTextBoxDrawing

CinnabarLabMetronomeRoom_TextPointers:
	def_text_pointers
	dw_const CinnabarLabMetronomeRoomScientist1Text, TEXT_CINNABARLABMETRONOMEROOM_SCIENTIST1
	dw_const CinnabarLabMetronomeRoomScientist2Text, TEXT_CINNABARLABMETRONOMEROOM_SCIENTIST2
	dw_const CinnabarLabMetronomeRoomPCText,         TEXT_CINNABARLABMETRONOMEROOM_PC_KEYBOARD
	dw_const CinnabarLabMetronomeRoomPCText,         TEXT_CINNABARLABMETRONOMEROOM_PC_MONITOR
	dw_const CinnabarLabMetronomeRoomAmberPipeText,  TEXT_CINNABARLABMETRONOMEROOM_AMBER_PIPE

CinnabarLabMetronomeRoomScientist1Text:
	text_asm
	CheckEvent EVENT_GOT_TM35
	jr nz, .got_item
	ld hl, .Text
	call PrintText
	lb bc, TM_METRONOME, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedTM35Text
	call PrintText
	SetEvent EVENT_GOT_TM35
	jr .done
.bag_full
	ld hl, .TM35NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, .TM35ExplanationText
	call PrintText
.done
	jp TextScriptEnd

.Text:
	text "ちッちッ　ちッ！"
	line "いい　<TM>を　つくったぜ！"

	para "#に　こいつを　おしえりゃ"
	line "たのしく　なるぜ！"
	prompt

.ReceivedTM35Text:
	text "<PLAYER>は　けんきゅうしゃから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_item_1
	text_end

.TM35ExplanationText:
	text "ちッ　ちッちッ！"
	line "これは　ゆびをふる　おと　だぜ！"

	para "ゆびをふると　#は"
	line "のうみそが　しげき　されて"
	cont "ふだん　やらないような　わざを"
	cont "いろいろ　くりだすぜ！"
	done

.TM35NoRoomText:
	text "にもつが　おおくて　もてないぞ"
	done

CinnabarLabMetronomeRoomScientist2Text:
	text "そう！　イーブイは"
	line "３しゅるいの　#に"
	cont "しんか　する　かのうせいが　ある！"
	done

CinnabarLabMetronomeRoomPCText:
	text "<PC>に"
	line "でんしメールが　とどいてる！"

	para "<⋯>　<⋯>　<⋯>"

	para "でんせつの　とり#は"
	line "３しゅるい<⋯>　ファイヤー"
	cont "サンダー　フリーザー<⋯>"
	cont "しかし　どこに　いるのか"
	cont "まだ　わかって　ません"

	para "こんど　ハナダ　どうくつに"
	line "ちょうさに　いきます"
	cont "<⋯>　まずは　ほうこく　まで"
	cont "#　ちょうさ　たい"

	para "<⋯>　<⋯>　<⋯>"
	done

CinnabarLabMetronomeRoomAmberPipeText:
	text "コハクの　パイプが　ある！"
	done
