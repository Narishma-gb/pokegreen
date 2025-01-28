FuchsiaMeetingRoom_Script:
	call EnableAutoTextBoxDrawing
	ret

FuchsiaMeetingRoom_TextPointers:
	def_text_pointers
	dw_const FuchsiaMeetingRoomSafariZoneWorker1, TEXT_FUCHSIAMEETINGROOM_SAFARI_ZONE_WORKER1
	dw_const FuchsiaMeetingRoomSafariZoneWorker2, TEXT_FUCHSIAMEETINGROOM_SAFARI_ZONE_WORKER2
	dw_const FuchsiaMeetingRoomSafariZoneWorker3, TEXT_FUCHSIAMEETINGROOM_SAFARI_ZONE_WORKER3

FuchsiaMeetingRoomSafariZoneWorker1:
	text "ウチの　えんちょう"
	line "あだな　ヤドンって　いうんです"

	para "ほら！　#の　ヤドンって"
	line "とぼけた　かんじ　でしょ！"
	done

FuchsiaMeetingRoomSafariZoneWorker2:
	text "ヤドンさんって"
	line "すごい　#　くわしいんだ！"

	para "みた　ことも　ない"
	line "#の　カセキとか　もってるし"
	done

FuchsiaMeetingRoomSafariZoneWorker3:
	text "ウチの　ヤドン　なにやら"
	line "ふにゃふにゃ　いってたな<⋯>"

	para "ボケた　のか？"
	done
