RockTunnelPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

RockTunnelPokecenter_TextPointers:
	def_text_pointers
	dw_const RockTunnelPokecenterNurseText,            TEXT_ROCKTUNNELPOKECENTER_NURSE
	dw_const RockTunnelPokecenterGentlemanText,        TEXT_ROCKTUNNELPOKECENTER_GENTLEMAN
	dw_const RockTunnelPokecenterFisherText,           TEXT_ROCKTUNNELPOKECENTER_FISHER
	dw_const RockTunnelPokecenterLinkReceptionistText, TEXT_ROCKTUNNELPOKECENTER_LINK_RECEPTIONIST

RockTunnelPokecenterNurseText:
	script_pokecenter_nurse

RockTunnelPokecenterGentlemanText:
	text "#は　タイプに　よって"
	line "ゆうりに　たたかえる　あいてと"
	cont "にがてな　あいてが　いるのだ"
	done

RockTunnelPokecenterFisherText:
	text "つかいみち　ないから　きんのたまを"
	line "うったら　５０００円で　うれた！"
	done

RockTunnelPokecenterLinkReceptionistText:
	script_cable_club_receptionist
