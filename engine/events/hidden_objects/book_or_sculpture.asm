BookOrSculptureText::
	text_asm
	ld hl, PokemonBooksText
	ld a, [wCurMapTileset]
	cp MANSION ; Celadon Mansion tileset
	jr nz, .ok
	lda_coord 8, 6
	cp $38
	jr nz, .ok
	ld hl, DiglettSculptureText
.ok
	call PrintText
	jp TextScriptEnd

PokemonBooksText:
	text "#の　ほんが　いっぱい！"
	done

DiglettSculptureText:
	text "ぶつだん　だ<⋯>"
	done
