DisplayOakLabEmailText:
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ret nz
	call EnableAutoTextBoxDrawing
	tx_pre_jump OakLabEmailText

OakLabEmailText::
	text "<PC>を　みると"
	line "なんと　でんしメールが　きていた！"

	para "<⋯>　<⋯>　<⋯>"

	para "#を　つよく　そだてて"
	line "たたかう　#　<TRAINER>！"
	cont "ここに　さいきょうの"
	cont "<TRAINER>が　あつまり　ました"

	para "ばしょは　セキエイ　こうげんの"
	line "#　リーグ　ほんぶ　です！"
	cont "オーキドはかせも"
	cont "いちど　ごらん　ください"
	cont "<⋯>　#　リーグ　より"
	cont "<⋯>　<⋯>　<⋯>"
	done
