DisplayOakLabLeftPoster:
	call EnableAutoTextBoxDrawing
	tx_pre_jump PushStartText

PushStartText::
	text "スタート　ボタンを　プシュ！"
	line "おすと　メニューが　ひらくなり"
	done

DisplayOakLabRightPoster:
	call EnableAutoTextBoxDrawing
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	cp 2
	tx_pre_id SaveOptionText
	jr c, .ownLessThanTwo
	; own two or more mon
	tx_pre_id StrengthsAndWeaknessesText
.ownLessThanTwo
	jp PrintPredefTextID

SaveOptionText::
	text "セーブするには　#　レポート"
	line "こまめに　かくと　いいなり"
	done

StrengthsAndWeaknessesText::
	text "#は　タイプに　よって"
	line "とくいな　タイプ"
	cont "にがてな　タイプが　いるなり"
	done
