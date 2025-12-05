BluesHouse_Script:
	call EnableAutoTextBoxDrawing
	ld hl, BluesHouse_ScriptPointers
	ld a, [wBluesHouseCurScript]
	jp CallFunctionInTable

BluesHouse_ScriptPointers:
	def_script_pointers
	dw_const BluesHouseDefaultScript, SCRIPT_BLUESHOUSE_DEFAULT
	dw_const BluesHouseNoopScript,    SCRIPT_BLUESHOUSE_NOOP

BluesHouseDefaultScript:
	SetEvent EVENT_ENTERED_BLUES_HOUSE
	ld a, SCRIPT_BLUESHOUSE_NOOP
	ld [wBluesHouseCurScript], a
	ret

BluesHouseNoopScript:
	ret

BluesHouse_TextPointers:
	def_text_pointers
	dw_const BluesHouseDaisySittingText, TEXT_BLUESHOUSE_DAISY_SITTING
	dw_const BluesHouseDaisyWalkingText, TEXT_BLUESHOUSE_DAISY_WALKING
	dw_const BluesHouseTownMapText,      TEXT_BLUESHOUSE_TOWN_MAP

BluesHouseDaisySittingText:
	text_asm
	CheckEvent EVENT_GOT_TOWN_MAP
	jr nz, .got_town_map
	CheckEvent EVENT_GOT_POKEDEX
	jr nz, .give_town_map
	ld hl, BluesHouseDaisyRivalAtLabText
	call PrintText
	jr .done

.give_town_map
	ld hl, BluesHouseDaisyOfferMapText
	call PrintText
	ld a, HS_TOWN_MAP
	ld [wMissableObjectIndex], a
	predef HideObject
	; bug: the Town Map is hidden before checking the result of GiveItem
	lb bc, TOWN_MAP, 1
	call GiveItem
	jr nc, .bag_full

	ld hl, GotMapText
	call PrintText
	SetEvent EVENT_GOT_TOWN_MAP
	jr .done

.got_town_map
	ld hl, BluesHouseDaisyUseMapText
	call PrintText
	jr .done

.bag_full
	ld hl, BluesHouseDaisyBagFullText
	call PrintText
.done
	jp TextScriptEnd

BluesHouseDaisyRivalAtLabText:
	text "こんにちは　<PLAYER>くん！"
	line "おとうとの　<RIVAL>なら"
	cont "おじいちゃんの　けんきゅうじょよ"
	done

BluesHouseDaisyOfferMapText:
	text "オーキドの　おじいちゃん"
	line "おしごと　たのんだんだって？"
	cont "たいへんねー"
	cont "これ　あげるから　つかって！"
	prompt

GotMapText:
	text "<PLAYER>は　おねえさんから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_key_item
	text_end

BluesHouseDaisyBagFullText:
	text "にもつ　いっぱいよ"
	done

BluesHouseDaisyUseMapText:
	text "じぶんの　いる　ばしょや"
	line "まちの　なまえが　しりたいとき"
	cont "タウンマップ　つかうと　いいわよ"
	done

BluesHouseDaisyWalkingText:
	text "にんげんと　おなじように"
	line "#も　いきてるの！"
	cont "たいりょくが　ないときは"
	cont "やすませて　あげて！"
	done

BluesHouseTownMapText:
	text "カントー　ちほうの　ちずだ！"
	line "<⋯>　もらえたら　うれしい？"
	done
