VermilionOldRodHouse_Script:
	jp EnableAutoTextBoxDrawing

VermilionOldRodHouse_TextPointers:
	def_text_pointers
	dw_const VermilionOldRodHouseFishingGuruText, TEXT_VERMILIONOLDRODHOUSE_FISHING_GURU

VermilionOldRodHouseFishingGuruText:
	text_asm
	ld a, [wStatusFlags1]
	bit BIT_GOT_OLD_ROD, a
	jr nz, .got_old_rod
	ld hl, .DoYouLikeToFishText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
	lb bc, OLD_ROD, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, wStatusFlags1
	set BIT_GOT_OLD_ROD, [hl]
	ld hl, .TakeThisText
	jr .print_text
.bag_full
	ld hl, .NoRoomText
	jr .print_text
.refused
	ld hl, .ThatsSoDisappointingText
	jr .print_text
.got_old_rod
	ld hl, .HowAreTheFishBitingText
.print_text
	call PrintText
	jp TextScriptEnd

.DoYouLikeToFishText:
	text "わしは　つりおやじ　じゃ！"

	para "もう　しぬほど"
	line "つりが　すき　なんだが"

	para "きみは　つり　すき　かな？"
	done

.TakeThisText:
	text "そうか！"
	line "きみとは　きが　あいそうだ！"

	para "これ　あげるから"
	line "きみも　つり　まくりなさいよ！"

	para "<PLAYER>は　つりおやじから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_item_1
	text_start

	para "つり　こそ"
	line "おとこの　ロマン　だ！"

	para "うみでも　かわでも！"

	para "えんりょ　なく"
	line "つりざおを　つかって　くれい！"
	done

.ThatsSoDisappointingText:
	text "なんじゃ<⋯>　がっかりだ"
	done

.HowAreTheFishBitingText:
	text "やー　<PLAYER>くん！"

	para "つり　まくっとる　かね！"
	done

.NoRoomText:
	text "ありゃー！"

	para "いいもの　あげようと　したのに"
	line "にもつが　いっぱいじゃ！"
	done
