SafariZoneNorthRestHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

SafariZoneNorthRestHouse_TextPointers:
	def_text_pointers
	dw_const SafariZoneNorthRestHouseScientistText,        TEXT_SAFARIZONENORTHRESTHOUSE_SCIENTIST
	dw_const SafariZoneNorthRestHouseSafariZoneWorkerText, TEXT_SAFARIZONENORTHRESTHOUSE_SAFARI_ZONE_WORKER
	dw_const SafariZoneNorthRestHouseGentlemanText,        TEXT_SAFARIZONENORTHRESTHOUSE_GENTLEMAN

SafariZoneNorthRestHouseScientistText:
	text "サファリ　ゾーン　ないに"
	line "おちてる　アイテムは"
	cont "もって　いって　いいんだよ！"

	para "でも　ぜんぶ　ひろって　たら"
	line "じかん　なくなっちゃう！"
	done

SafariZoneNorthRestHouseSafariZoneWorkerText:
	text "いま　キャンペーン　ちゅう　だろ"
	line "ゾーン　いちばん　おくの　こやで"
	cont "しょうひんを　くれるってさ！"
	done

SafariZoneNorthRestHouseGentlemanText:
	text "わたしの　イーブイ"
	line "ブースターに　しんか　しよった！"

	para "でも　ともだち　のは　シャワーズに"
	line "なったんだ！　なんでだろう？"
	done
