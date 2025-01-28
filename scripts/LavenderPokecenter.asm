LavenderPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

LavenderPokecenter_TextPointers:
	def_text_pointers
	dw_const LavenderPokecenterNurseText,            TEXT_LAVENDERPOKECENTER_NURSE
	dw_const LavenderPokecenterGentlemanText,        TEXT_LAVENDERPOKECENTER_GENTLEMAN
	dw_const LavenderPokecenterLittleGirlText,       TEXT_LAVENDERPOKECENTER_LITTLE_GIRL
	dw_const LavenderPokecenterLinkReceptionistText, TEXT_LAVENDERPOKECENTER_LINK_RECEPTIONIST

LavenderPokecenterLinkReceptionistText:
	script_cable_club_receptionist

LavenderPokecenterNurseText:
	script_pokecenter_nurse

LavenderPokecenterGentlemanText:
	text "<ROCKET>の　れんちゅう<⋯>"
	line "おかね　もうけの　ためなら"
	cont "どんな　わるい　ことでも　やるのさ"
	done

LavenderPokecenterLittleGirlText:
	text "カラカラの　おかあさんが"
	line "<ROCKET>から　にげる　ところ"
	cont "わたしも　みたわ<⋯>"

	para "にげる　とちゅうで　ころされたわ"
	done
