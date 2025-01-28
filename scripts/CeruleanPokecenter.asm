CeruleanPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

CeruleanPokecenter_TextPointers:
	def_text_pointers
	dw_const CeruleanPokecenterNurseText,            TEXT_CERULEANPOKECENTER_NURSE
	dw_const CeruleanPokecenterSuperNerdText,        TEXT_CERULEANPOKECENTER_SUPER_NERD
	dw_const CeruleanPokecenterGentlemanText,        TEXT_CERULEANPOKECENTER_GENTLEMAN
	dw_const CeruleanPokecenterLinkReceptionistText, TEXT_CERULEANPOKECENTER_LINK_RECEPTIONIST

CeruleanPokecenterLinkReceptionistText:
	script_cable_club_receptionist

CeruleanPokecenterNurseText:
	script_pokecenter_nurse

CeruleanPokecenterSuperNerdText:
	text "マサキの　ヤツ！"

	para "めずらしい　#を"
	line "てに　いれる　ためには<⋯>"

	para "あんな　ことも　こんな　ことも"
	line "へいきで　するって　きいたよ！"
	done

CeruleanPokecenterGentlemanText:
	text "きみも"
	line "マサキの　うわさ　きいてるか？"

	para "みんなが　あいつを"
	line "#　マニアと　よんでるよ！"

	para "でも　ものを　あつめたり"
	line "じまん　したい　きもちは"
	cont "だれでも　ある！"

	para "みんなも　うらやましいんだな！"
	done
