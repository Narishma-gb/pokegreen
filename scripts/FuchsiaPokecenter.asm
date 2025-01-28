FuchsiaPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

FuchsiaPokecenter_TextPointers:
	def_text_pointers
	dw_const FuchsiaPokecenterNurseText,            TEXT_FUCHSIAPOKECENTER_NURSE
	dw_const FuchsiaPokecenterRockerText,           TEXT_FUCHSIAPOKECENTER_ROCKER
	dw_const FuchsiaPokecenterCooltrainerFText,     TEXT_FUCHSIAPOKECENTER_COOLTRAINER_F
	dw_const FuchsiaPokecenterLinkReceptionistText, TEXT_FUCHSIAPOKECENTER_LINK_RECEPTIONIST

FuchsiaPokecenterNurseText:
	script_pokecenter_nurse

FuchsiaPokecenterRockerText:
	text "１ぴきだけ　そだてても"
	line "つよい　<TRAINER>に　なれない"

	para "おおくの　#を　"
	line "バランス　よく　そだてるのも"
	cont "たいへん　だけどな"
	done

FuchsiaPokecenterCooltrainerFText:
	text "トキワの　にしに"
	line "ほそい　みちが　ある　でしょう"

	para "その　おくに　たってるのが"
	line "すべての　#　<TRAINER>を"
	cont "まとめる　そしき　#　リーグよ"
	done

FuchsiaPokecenterLinkReceptionistText:
	script_cable_club_receptionist
