ViridianPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

ViridianPokecenter_TextPointers:
	def_text_pointers
	dw_const ViridianPokecenterNurseText,            TEXT_VIRIDIANPOKECENTER_NURSE
	dw_const ViridianPokecenterGentlemanText,        TEXT_VIRIDIANPOKECENTER_GENTLEMAN
	dw_const ViridianPokecenterCooltrainerMText,     TEXT_VIRIDIANPOKECENTER_COOLTRAINER_M
	dw_const ViridianPokecenterLinkReceptionistText, TEXT_VIRIDIANPOKECENTER_LINK_RECEPTIONIST

ViridianPokecenterNurseText:
	script_pokecenter_nurse

ViridianPokecenterGentlemanText:
	text "すみに　ある　<PC>は　どうぞ"
	line "ごじゆうに　おつかいください！"

	para "<⋯>と　うけつけの　ねーちゃんが"
	line "いっとった　しんせつやのう"
	done

ViridianPokecenterCooltrainerMText:
	text "#センターは　このさき"
	line "どこの　まちに　いっても　ある！"

	para "なんびき　あずけても　ただ　だし"
	line "こまめに　つかうと　いいよ！"
	done

ViridianPokecenterLinkReceptionistText:
	script_cable_club_receptionist
