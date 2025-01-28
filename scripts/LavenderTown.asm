LavenderTown_Script:
	jp EnableAutoTextBoxDrawing

LavenderTown_TextPointers:
	def_text_pointers
	dw_const LavenderTownLittleGirlText,       TEXT_LAVENDERTOWN_LITTLE_GIRL
	dw_const LavenderTownCooltrainerMText,     TEXT_LAVENDERTOWN_COOLTRAINER_M
	dw_const LavenderTownSuperNerdText,        TEXT_LAVENDERTOWN_SUPER_NERD
	dw_const LavenderTownSignText,             TEXT_LAVENDERTOWN_SIGN
	dw_const LavenderTownSilphScopeSignText,   TEXT_LAVENDERTOWN_SILPH_SCOPE_SIGN
	dw_const MartSignText,                     TEXT_LAVENDERTOWN_MART_SIGN
	dw_const PokeCenterSignText,               TEXT_LAVENDERTOWN_POKECENTER_SIGN
	dw_const LavenderTownPokemonHouseSignText, TEXT_LAVENDERTOWN_POKEMON_HOUSE_SIGN
	dw_const LavenderTownPokemonTowerSignText, TEXT_LAVENDERTOWN_POKEMON_TOWER_SIGN

LavenderTownLittleGirlText:
	text_asm
	ld hl, .DoYouBelieveInGhostsText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, .HaHaGuessNotText
	jr nz, .got_text
	ld hl, .SoThereAreBelieversText
.got_text
	call PrintText
	jp TextScriptEnd

.DoYouBelieveInGhostsText:
	text "あなた"
	line "ゆうれいは　いると　おもう？"
	done

.SoThereAreBelieversText:
	text "<⋯>ふーん"
	line "しんじてる　ひとって　いるんだ"
	done

.HaHaGuessNotText:
	text "あはは　そうよね！"

	para "あなたの　みぎかたに"
	line "しろい　てが　おかれてる　なんて"
	cont "<⋯>あたしの　みまちがいよね"
	done

LavenderTownCooltrainerMText:
	text "ここは　#の　おはかで"
	line "ゆうめいな　タウンだ<⋯>"

	para "かっていた　#が　しんだとき"
	line "#　タワーに　もっていって"
	cont "めいふくを　いのるのさ<⋯>"
	done

LavenderTownSuperNerdText:
	text "さいきん　#　タワーに"
	line "ゆうれいが　でる　らしいんだ<⋯>"

	para "どうも　<ROCKET>に　ころされた"
	line "#の　ゆうれい　らしい<⋯>"
	done

LavenderTownSignText:
	text "ここは　シオン　タウン"
	line "シオンは　むらさき　とうとい　いろ"
	done

LavenderTownSilphScopeSignText:
	text "みえない　#も　よくみえる？"
	line "しん　せいひん！　シルフスコープ！"

	para "<⋯>　シルフ　カンパニー"
	done

LavenderTownPokemonHouseSignText:
	text "ここは　あいの　ボランティア"
	line "#　ハウス"
	done

LavenderTownPokemonTowerSignText:
	text "ここは　#の　れいはい　とう"
	line "#　タワー"
	done
