IndigoPlateauStatues::
	text_asm
	ld hl, IndigoPlateauStatuesText1
	call PrintText
	ld a, [wXCoord]
	bit 0, a ; even or odd?
	ld hl, IndigoPlateauStatuesText2
	jr nz, .ok
	ld hl, IndigoPlateauStatuesText3
.ok
	call PrintText
	jp TextScriptEnd

IndigoPlateauStatuesText1:
	text "ここは　セキエイ　こうげん"
	prompt

IndigoPlateauStatuesText2:
	text "#　<TRAINER>の　ちょうてん！"
	line "#　リーグ　ほんぶ"
	done

IndigoPlateauStatuesText3:
	text "#の　さいこう　きかん"
	line "#　リーグ　ほんぶ"
	done
