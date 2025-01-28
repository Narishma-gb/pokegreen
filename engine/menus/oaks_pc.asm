OpenOaksPC:
	call SaveScreenTilesToBuffer2
	ld hl, AccessedOaksPCText
	call PrintText
	ld hl, GetDexRatedText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .closePC
	predef DisplayDexRating
.closePC
	ld hl, ClosedOaksPCText
	call PrintText
	jp LoadScreenTilesFromBuffer2

GetDexRatedText:
	text "げんざいの　#ずかんを"
	line "ひょうか　して　もらい　ますか？"
	done

ClosedOaksPCText:
	text "<⋯>　オーキドの　<PC>との"
	line "せつぞくを　おわった！@"
	text_waitbutton
	text_end

AccessedOaksPCText:
	text "オーキドの　<PC>と　つないだ！"

	para "#　ずかん"
	line "ひょうか　システムを　よびだした！"
	prompt
