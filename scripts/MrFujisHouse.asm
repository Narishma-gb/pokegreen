MrFujisHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

MrFujisHouse_TextPointers:
	def_text_pointers
	dw_const MrFujisHouseSuperNerdText,     TEXT_MRFUJISHOUSE_SUPER_NERD
	dw_const MrFujisHouseLittleGirlText,    TEXT_MRFUJISHOUSE_LITTLE_GIRL
	dw_const MrFujisHousePsyduckText,       TEXT_MRFUJISHOUSE_PSYDUCK
	dw_const MrFujisHouseNidorinoText,      TEXT_MRFUJISHOUSE_NIDORINO
	dw_const MrFujisHouseMrFujiText,        TEXT_MRFUJISHOUSE_MR_FUJI
	dw_const MrFujisHouseMrFujiPokedexText, TEXT_MRFUJISHOUSE_POKEDEX

MrFujisHouseSuperNerdText:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .rescued_mr_fuji
	ld hl, .MrFujiIsntHereText
	call PrintText
	jr .done
.rescued_mr_fuji
	ld hl, .MrFujiHadBeenPrayingText
	call PrintText
.done
	jp TextScriptEnd

.MrFujiIsntHereText:
	text "おっかしいなー！"
	line "フジ　ろうじんが　いないぞ！"
	cont "どこに　いったのかな？"
	done

.MrFujiHadBeenPrayingText:
	text "フジ　ろうじん　カラカラの　れいを"
	line "なぐさめに　いってたんだね"
	done

MrFujisHouseLittleGirlText:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .rescued_mr_fuji
	ld hl, .ThisIsMrFujisHouseText
	call PrintText
	jr .done
.rescued_mr_fuji
	ld hl, .PokemonAreNiceToHugText
	call PrintText
.done
	jp TextScriptEnd

.ThisIsMrFujisHouseText:
	text "ここは　もともと"
	line "フジ　じいちゃんの　おうち　なの"

	para "じいちゃん　やさしいのよ！"

	para "すてられたり　かえなくなった"
	line "#を　あずかって"
	cont "せわ　してるの"
	done

.PokemonAreNiceToHugText:
	text "はあ　あったかい<⋯>！"
	line "#って　だっこ　すると"
	cont "あったかいんだよねー！"
	done

MrFujisHousePsyduckText:
	text "コダック『ぐわっぱ！@"
	text_asm
	ld a, PSYDUCK
	call PlayCry
	jp TextScriptEnd

MrFujisHouseNidorinoText:
	text "ニドリーノ『がぉーっ！@"
	text_asm
	ld a, NIDORINO
	call PlayCry
	jp TextScriptEnd

MrFujisHouseMrFujiText:
	text_asm
	CheckEvent EVENT_GOT_POKE_FLUTE
	jr nz, .got_item
	ld hl, .IThinkThisMayHelpYourQuestText
	call PrintText
	lb bc, POKE_FLUTE, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedPokeFluteText
	call PrintText
	SetEvent EVENT_GOT_POKE_FLUTE
	jr .done
.bag_full
	ld hl, .PokeFluteNoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, .HasMyFluteHelpedYouText
	call PrintText
.done
	jp TextScriptEnd

.IThinkThisMayHelpYourQuestText:
	text "フジ『さて　<PLAYER>くん<⋯>"

	para "#ずかん　づくりは"
	line "#に　たいして"
	cont "ふかい　あいじょうが　ないと"
	cont "かんせいは　たいへん　むずかしい"

	para "その　たすけに　なるか　わからんが"
	line "これを　あなたに　さしあげよう！"
	prompt

.ReceivedPokeFluteText:
	text "<PLAYER>は　フジ　ろうじんから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_key_item
	text_start

	para "#のふえを　ふくと"
	line "グーグー　ねむってる　#でも"
	cont "げんきが　わいて　とびおきる！"

	para "#が　いねむり　して"
	line "こまったら　つかって　みなさい"
	done

.PokeFluteNoRoomText:
	text "にもつが　いっぱいだな"
	done

.HasMyFluteHelpedYouText:
	text "フジ『このあいだ　さしあげた"
	line "ふえは　やくに　たってるかな？"
	done

MrFujisHouseMrFujiPokedexText:
	text "ごうか　しょうひんが　あたる！"
	line "げっかん　#の　とも"
	cont "ビッグ·プレゼント！"

	para "<⋯>おうぼ　ほうほうは"

	para "<⋯>あら　きりとって　ある！"
	done
