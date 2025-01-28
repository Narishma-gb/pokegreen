CinnabarPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

CinnabarPokecenter_TextPointers:
	def_text_pointers
	dw_const CinnabarPokecenterNurseText,            TEXT_CINNABARPOKECENTER_NURSE
	dw_const CinnabarPokecenterCooltrainerFText,     TEXT_CINNABARPOKECENTER_COOLTRAINER_F
	dw_const CinnabarPokecenterGentlemanText,        TEXT_CINNABARPOKECENTER_GENTLEMAN
	dw_const CinnabarPokecenterLinkReceptionistText, TEXT_CINNABARPOKECENTER_LINK_RECEPTIONIST

CinnabarPokecenterNurseText:
	script_pokecenter_nurse

CinnabarPokecenterCooltrainerFText:
	text "しんか　キャンセル　つかってる？"

	para "しんか　しようと　するのを"
	line "とちゅうで　やめさせて"
	cont "そのままの　かたちで"
	cont "そだてる　テクニックよ"
	done

CinnabarPokecenterGentlemanText:
	text "きみには　ともだちは　いるかな？"

	para "ともだちと　こうかんして"
	line "もらった　#は"
	cont "とても　はやく　そだつと　いう"

	para "ためして　みる　かちは"
	line "あると　おもうがね"
	done

CinnabarPokecenterLinkReceptionistText:
	script_cable_club_receptionist
