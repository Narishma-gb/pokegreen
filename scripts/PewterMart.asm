PewterMart_Script:
	call EnableAutoTextBoxDrawing
	ld a, 1 << BIT_NO_AUTO_TEXT_BOX
	ld [wAutoTextBoxDrawingControl], a
	ret

PewterMart_TextPointers:
	def_text_pointers
	dw_const PewterMartClerkText,     TEXT_PEWTERMART_CLERK
	dw_const PewterMartYoungsterText, TEXT_PEWTERMART_YOUNGSTER
	dw_const PewterMartSuperNerdText, TEXT_PEWTERMART_SUPER_NERD

PewterMartYoungsterText:
	text_asm
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text "インチキ　くさい　おじさんから"
	line "なんだか　ヘンな　#を"
	cont "かっちゃったよ！"

	para "すっげー　よわいの！"
	line "５００円も　したのに<⋯>"
	done

PewterMartSuperNerdText:
	text_asm
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text:
	text "よわい　#でも"
	line "いっしょうけんめい　そだてれば"
	cont "いいこと　あるさ！"
	done
