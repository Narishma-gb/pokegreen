CeladonPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

CeladonPokecenter_TextPointers:
	def_text_pointers
	dw_const CeladonPokecenterNurseText,            TEXT_CELADONPOKECENTER_NURSE
	dw_const CeladonPokecenterGentlemanText,        TEXT_CELADONPOKECENTER_GENTLEMAN
	dw_const CeladonPokecenterBeautyText,           TEXT_CELADONPOKECENTER_BEAUTY
	dw_const CeladonPokecenterLinkReceptionistText, TEXT_CELADONPOKECENTER_LINK_RECEPTIONIST

CeladonPokecenterLinkReceptionistText:
	script_cable_club_receptionist

CeladonPokecenterNurseText:
	script_pokecenter_nurse

CeladonPokecenterGentlemanText:
	text "#のふえで　ねてる　#が"
	line "とび　おきるのは"

	para "ひとには　きこえない"
	line "とくべつな　おとも　でてる　からだよ"
	done

CeladonPokecenterBeautyText:
	text "セキチク　シティから　きたんだけど"
	line "サイクリング　ロード"
	cont "のぼりざか　だから　つかれちゃった！"
	done
