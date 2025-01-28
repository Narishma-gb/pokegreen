PewterNidoranHouse_Script:
	jp EnableAutoTextBoxDrawing

PewterNidoranHouse_TextPointers:
	def_text_pointers
	dw_const PewterNidoranHouseNidoranText,       TEXT_PEWTERNIDORANHOUSE_NIDORAN
	dw_const PewterNidoranHouseLittleBoyText,     TEXT_PEWTERNIDORANHOUSE_LITTLE_BOY
	dw_const PewterNidoranHouseMiddleAgedManText, TEXT_PEWTERNIDORANHOUSE_MIDDLE_AGED_MAN

PewterNidoranHouseNidoranText:
	text "ニドラン『バウバウ！@"
	text_asm
IF DEF(_RED)
	ld a, NIDORAN_M
ENDC
IF DEF(_GREEN)
	ld a, NIDORAN_F
ENDC
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

PewterNidoranHouseLittleBoyText:
	text "ニドラン　おすわり！"
	done

PewterNidoranHouseMiddleAgedManText:
	text "うちの　#　よそもの"
	line "だから　き　むずかしいよ"

	para "よそもの　ってのは　ひとと"
	line "こうかん　した　#だよ"

	para "そだつのは　はやいが"
	line "ちからのない　<TRAINER>の"
	cont "いうことは　きかん！"

	para "バッジさえ　あれば<⋯>"
	done
