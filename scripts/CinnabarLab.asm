CinnabarLab_Script:
	call EnableAutoTextBoxDrawing
	ret

CinnabarLab_TextPointers:
	def_text_pointers
	dw_const CinnabarLabFishingGuruText,     TEXT_CINNABARLAB_FISHING_GURU
	dw_const CinnabarLabPhotoText,           TEXT_CINNABARLAB_PHOTO
	dw_const CinnabarLabMeetingRoomSignText, TEXT_CINNABARLAB_MEETING_ROOM_SIGN
	dw_const CinnabarLabRAndDSignText,       TEXT_CINNABARLAB_R_AND_D_SIGN
	dw_const CinnabarLabTestingRoomSignText, TEXT_CINNABARLAB_TESTING_ROOM_SIGN

CinnabarLabFishingGuruText:
	text "ここでは　まいにち"
	line "#の　けんきゅうを　してます"

	para "あと　めずらしい　#などを"
	line "もちこんでくる　おきゃくさんも"
	cont "いらっしゃい　ますね"
	done

CinnabarLabPhotoText:
	text "グレン　ラボラトリーの　そうせつしゃ"
	line "フジはかせの　しゃしんだ！"
	done

CinnabarLabMeetingRoomSignText:
	text "#　ラボ　おうせつしつ"
	done

CinnabarLabRAndDSignText:
	text "#　ラボ　けんきゅうしつ"
	done

CinnabarLabTestingRoomSignText:
	text "#　ラボ　じっけんしつ"
	done
