FuchsiaGoodRodHouse_Script:
	jp EnableAutoTextBoxDrawing

FuchsiaGoodRodHouse_TextPointers:
	def_text_pointers
	dw_const FuchsiaGoodRodHouseFishingGuruText, TEXT_FUCHSIAGOODRODHOUSE_FISHING_GURU

FuchsiaGoodRodHouseFishingGuruText:
	text_asm
	ld a, [wStatusFlags1]
	bit BIT_GOT_GOOD_ROD, a
	jr nz, .got_item
	ld hl, .Text
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
	lb bc, GOOD_ROD, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, wStatusFlags1
	set BIT_GOT_GOOD_ROD, [hl]
	ld hl, .ReceivedGoodRodText
	jr .done
.bag_full
	ld hl, .NoRoomText
	jr .done
.refused
	ld hl, .ThatsSoDisappointingText
	jr .done
.got_item
	ld hl, .HowAreTheFishText
.done
	call PrintText
	jp TextScriptEnd

.Text:
	text "わしは　つりおやじの　あに　じゃ！"

	para "もう　しぬほど"
	line "つりが　すき　なんだが"

	para "きみは　つり　すき　かな？"
	done

.ReceivedGoodRodText:
	text "そうか！"
	line "きみとは　きが　あいそうだ！"

	para "これ　あげるから"
	line "きみも　つり　まくりなさいよ！"

	para "<PLAYER>は　つりおやじから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_item_1
	text_end

.UnusedText:
	para "つり　こそ"
	line "おとこの　ロマン　だ！"

	para "へぼいつりざおは"
	line "コイキングしか　つれ　なんだが"
	line "この　いいつりざおなら"
	line "もっと　いいもんが　つれるんじゃ！"
	done

.ThatsSoDisappointingText:
	text "なんじゃ<⋯>　がっかりだ"
	done

.HowAreTheFishText:
	text "やー　<PLAYER>くん！"

	para "つり　まくっとる　かね！"
	done

.NoRoomText:
	text "ありゃー！"

	para "いいもの　あげようと　したのに"
	line "にもつが　いっぱいじゃ！"
	done
