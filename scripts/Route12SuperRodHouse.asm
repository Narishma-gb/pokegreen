Route12SuperRodHouse_Script:
	jp EnableAutoTextBoxDrawing

Route12SuperRodHouse_TextPointers:
	def_text_pointers
	dw_const Route12SuperRodHouseFishingGuruText, TEXT_ROUTE12SUPERRODHOUSE_FISHING_GURU

Route12SuperRodHouseFishingGuruText:
	text_asm
	ld a, [wStatusFlags1]
	bit BIT_GOT_SUPER_ROD, a
	jr nz, .got_item
	ld hl, .DoYouLikeToFishText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
	lb bc, SUPER_ROD, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, wStatusFlags1
	set BIT_GOT_SUPER_ROD, [hl]
	ld hl, .ReceivedSuperRodText
	jr .done
.bag_full
	ld hl, .NoRoomText
	jr .done
.refused
	ld hl, .ThatsDisappointingText
	jr .done
.got_item
	ld hl, .TryFishingText
.done
	call PrintText
	jp TextScriptEnd

.DoYouLikeToFishText:
	text "わしは"
	line "つりおやじの　おとうと　じゃ！"

	para "もう　たまらん　ほど"
	line "つりが　すき　なんだが"

	para "きみは　つり　すき　かな？"
	done

.ReceivedSuperRodText:
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

.ThatsDisappointingText:
	text "なんじゃ<⋯>　がっかりだ"
	done

.TryFishingText:
	text "やー　<PLAYER>くん！"

	para "すごいつりざおは"
	line "ばしょを　かえると"
	cont "つれる　#も　かわる！"

	para "あっちこっちで"
	line "つり　まくって　くれい！"
	done

.NoRoomText:
	text "ありゃー！"

	para "いいもの　あげようと　したのに"
	line "にもつが　いっぱいじゃ！"
	done
