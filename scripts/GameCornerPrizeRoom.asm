GameCornerPrizeRoom_Script:
	jp EnableAutoTextBoxDrawing

GameCornerPrizeRoom_TextPointers:
	def_text_pointers
	dw_const GameCornerPrizeRoomBaldingGuyText,  TEXT_GAMECORNERPRIZEROOM_BALDING_GUY
	dw_const GameCornerPrizeRoomGamblerText,     TEXT_GAMECORNERPRIZEROOM_GAMBLER
	dw_const GameCornerPRizeRoomPrizeVendorText, TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_1
	dw_const GameCornerPRizeRoomPrizeVendorText, TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_2
	dw_const GameCornerPRizeRoomPrizeVendorText, TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_3
	EXPORT TEXT_GAMECORNERPRIZEROOM_PRIZE_VENDOR_1 ; used by engine/events/prize_menu.asm

GameCornerPrizeRoomBaldingGuyText:
	text "うーん<⋯>！　どうにか　して"
	line "あの　ポリゴンが　ほしいなあ！"

	para "しかし　スロット　ゲームで"
	line "かつ　のは　たいへんだ！"
	done

GameCornerPrizeRoomGamblerText:
	text "がはは！　もうけた　もうけた<⋯>！"
	line "まいにち　こんな　だと　いいわい"
	done

GameCornerPRizeRoomPrizeVendorText:
	script_prize_vendor
