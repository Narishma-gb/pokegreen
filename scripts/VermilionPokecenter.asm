VermilionPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

VermilionPokecenter_TextPointers:
	def_text_pointers
	dw_const VermilionPokecenterNurseText,            TEXT_VERMILIONPOKECENTER_NURSE
	dw_const VermilionPokecenterFishingGuruText,      TEXT_VERMILIONPOKECENTER_FISHING_GURU
	dw_const VermilionPokecenterSailorText,           TEXT_VERMILIONPOKECENTER_SAILOR
	dw_const VermilionPokecenterLinkReceptionistText, TEXT_VERMILIONPOKECENTER_LINK_RECEPTIONIST

VermilionPokecenterNurseText:
	script_pokecenter_nurse

VermilionPokecenterFishingGuruText:
	text "おなじ　レベルの　#でも"
	line "つよさは　まちまち　らしい"

	para "それに　ひとが　そだてた"
	line "#の　ほうが"
	cont "やせい　より　つよい　らしい"
	done

VermilionPokecenterSailorText:
	text "おれの　#"
	line "どく　くらったまま　あるいてたら"
	cont "ちから　つき　おったで！"
	done

VermilionPokecenterLinkReceptionistText:
	script_cable_club_receptionist
