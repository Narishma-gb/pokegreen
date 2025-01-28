ViridianNicknameHouse_Script:
	jp EnableAutoTextBoxDrawing

ViridianNicknameHouse_TextPointers:
	def_text_pointers
	dw_const ViridianNicknameHouseBaldingGuyText, TEXT_VIRIDIANNICKNAMEHOUSE_BALDING_GUY
	dw_const ViridianNicknameHouseLittleGirlText, TEXT_VIRIDIANNICKNAMEHOUSE_LITTLE_GIRL
	dw_const ViridianNicknameHouseSpearowText,    TEXT_VIRIDIANNICKNAMEHOUSE_SPEAROW
	dw_const ViridianNicknameHouseSpearySignText, TEXT_VIRIDIANNICKNAMEHOUSE_SPEARY_SIGN

ViridianNicknameHouseBaldingGuyText:
	text "ニックネームを　かんがえることは"
	line "たのしい<⋯>が　むずかしい！"

	para "こった　ニックネームも　いいが"
	line "おぼえやすいのが　いちばん　やな！"
	done

ViridianNicknameHouseLittleGirlText:
	text "うちの　とうちゃんも"
	line "#　だいすきなのよ！"
	done

ViridianNicknameHouseSpearowText:
	text_asm
	ld hl, .Text
	call PrintText
	ld a, SPEAROW
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

.Text:
	text "オニチャン『チュ　チュン！"
	done

ViridianNicknameHouseSpearySignText:
	text "オニスズメ"
	line "めいめい　「オニチャン」"
	done
