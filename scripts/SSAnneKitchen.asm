SSAnneKitchen_Script:
	call EnableAutoTextBoxDrawing
	ret

SSAnneKitchen_TextPointers:
	def_text_pointers
	dw_const SSAnneKitchenCook1Text, TEXT_SSANNEKITCHEN_COOK1
	dw_const SSAnneKitchenCook2Text, TEXT_SSANNEKITCHEN_COOK2
	dw_const SSAnneKitchenCook3Text, TEXT_SSANNEKITCHEN_COOK3
	dw_const SSAnneKitchenCook4Text, TEXT_SSANNEKITCHEN_COOK4
	dw_const SSAnneKitchenCook5Text, TEXT_SSANNEKITCHEN_COOK5
	dw_const SSAnneKitchenCook6Text, TEXT_SSANNEKITCHEN_COOK6
	dw_const SSAnneKitchenCook7Text, TEXT_SSANNEKITCHEN_COOK7

SSAnneKitchenCook1Text:
	text "ほら！"
	line "そこの　きみ　じゃまだよ！"
	cont "どいた　どいた！"
	done

SSAnneKitchenCook2Text:
	text "ゴミばこに　へんなボールが"
	line "すてて　あったけど　なんだろう？"
	done

SSAnneKitchenCook3Text:
	text "いそがしくって　めが　まわる！"
	line "たのむ　から　あっち　いってくれ！"
	done

SSAnneKitchenCook4Text:
	text "せっせ　せっせ<⋯>"

	para "おれは　まいにち"
	line "イモの　かわむきだ！"
	cont "せっせ　せっせ<⋯>"
	done

SSAnneKitchenCook5Text:
	text "そういえば　くいしんぼうの"
	line "カビゴン　しってる？"

	para "あんなに　よく　たべて　よく　ねる"
	line "#は　ほかに　いないよ！"
	done

SSAnneKitchenCook6Text:
	text "しくしく　しくしく<⋯>"

	para "おれは　まいにち"
	line "タマネギの　かわむきだー"
	cont "しくしく　しくしく<⋯>"
	done

SSAnneKitchenCook7Text:
	text_asm
	ld hl, .MainCourseIsText
	call PrintText
	ldh a, [hRandomAdd]
	bit 7, a
	jr z, .not_dialog_1
	ld hl, .SalmonDuSaladText
	jr .done
.not_dialog_1
	bit 4, a
	jr z, .not_dialog_2
	ld hl, .EelsAuBarbecueText
	jr .done
.not_dialog_2
	ld hl, .PrimeBeefSteakText
.done
	call PrintText
	jp TextScriptEnd

.MainCourseIsText:
	text "おっほん！"
	line "わたしが　ここの　シェフです！"

	para "きょうの　メイン　ディッシュは"
	prompt

.SalmonDuSaladText:
	text "したびらめの　ムニエル！"

	para "しかし　おきゃくさんに"
	line "また　さかな？　と　いわれそうだ"
	done

.EelsAuBarbecueText:
	text "さんまの　しおやき！"

	para "<⋯>じゃ　おきゃく　さんに"
	line "おこられるか？"
	done

.PrimeBeefSteakText:
	text "ぎゅう　フィレの　ステーキ！"

	para "でも　ざいりょう"
	line "にんずう　ぶん　あったかな？"
	done
