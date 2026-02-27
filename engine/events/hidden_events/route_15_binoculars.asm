Route15GateLeftBinoculars:
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ret nz
	call EnableAutoTextBoxDrawing
	tx_pre Route15UpstairsBinocularsText
	ld a, ARTICUNO
	ld [wCurPartySpecies], a
	call PlayCry
	jp DisplayMonFrontSpriteInBox

Route15UpstairsBinocularsText::
	text "ぼうえんきょうを　のぞいた<⋯>"

	para "おおきな　とりが"
	line "キラキラ　ひかりながら"
	cont "うみの　ほうへ　とんでいく<⋯>"
	done
