SaffronPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

SaffronPokecenter_TextPointers:
	def_text_pointers
	dw_const SaffronPokecenterNurseText,            TEXT_SAFFRONPOKECENTER_NURSE
	dw_const SaffronPokecenterBeautyText,           TEXT_SAFFRONPOKECENTER_BEAUTY
	dw_const SaffronPokecenterGentlemanText,        TEXT_SAFFRONPOKECENTER_GENTLEMAN
	dw_const SaffronPokecenterLinkReceptionistText, TEXT_SAFFRONPOKECENTER_LINK_RECEPTIONIST

SaffronPokecenterNurseText:
	script_pokecenter_nurse

SaffronPokecenterBeautyText:
	text "#は　しゅるいに　よって"
	line "せいちょうする　テンポが"
	cont "ちがう　らしいわ"
	done

SaffronPokecenterGentlemanText:
	text "だれもが　みんな　しってる"
	line "シルフ　カンパニー　だが"
	cont "ゆうめい　だと　それだけ"
	cont "ねらわれる　きけんも　あるのだ"
	done

SaffronPokecenterLinkReceptionistText:
	script_cable_club_receptionist
