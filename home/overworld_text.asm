TextScriptEndingText::
	text_end

TextScriptEnd::
	ld hl, TextScriptEndingText
	ret

ExclamationText::
	text "！"
	done

GroundRoseText::
	text "どこかで　じめんがもりあがった！"
	done

BoulderText::
	text "「かいりき」　で　うごかせるかも<⋯>"
	done

MartSignText::
	text "#　グッズが　いっぱい！"
	line "フレンドリィショップ"
	done

PokeCenterSignText::
	text "#の　たいりょく　かいふく！"
	line "#センター"
	done

PickUpItemText::
	text_asm
	predef PickUpItem
	jp TextScriptEnd
