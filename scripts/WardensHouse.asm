WardensHouse_Script:
	jp EnableAutoTextBoxDrawing

WardensHouse_TextPointers:
	def_text_pointers
	dw_const WardensHouseWardenText,  TEXT_WARDENSHOUSE_WARDEN
	dw_const PickUpItemText,          TEXT_WARDENSHOUSE_RARE_CANDY
	dw_const BoulderText,             TEXT_WARDENSHOUSE_BOULDER
	dw_const WardensHouseDisplayText, TEXT_WARDENSHOUSE_DISPLAY_LEFT
	dw_const WardensHouseDisplayText, TEXT_WARDENSHOUSE_DISPLAY_RIGHT

WardensHouseWardenText:
	text_asm
	CheckEvent EVENT_GOT_HM04
	jr nz, .got_item
	ld b, GOLD_TEETH
	call IsItemInBag
	jr nz, .have_gold_teeth
	CheckEvent EVENT_GAVE_GOLD_TEETH
	jr nz, .gave_gold_teeth
	ld hl, .Gibberish1Text
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, .Gibberish3Text
	jr nz, .refused
	ld hl, .Gibberish2Text
.refused
	call PrintText
	jr .done
.have_gold_teeth
	ld hl, .GaveTheGoldTeethText
	call PrintText
	ld a, GOLD_TEETH
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_GAVE_GOLD_TEETH
.gave_gold_teeth
	ld hl, .ThanksText
	call PrintText
	lb bc, HM_STRENGTH, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, .ReceivedHM04Text
	call PrintText
	SetEvent EVENT_GOT_HM04
	jr .done
.got_item
	ld hl, .HM04ExplanationText
	call PrintText
	jr .done
.bag_full
	ld hl, .HM04NoRoomText
	call PrintText
.done
	jp TextScriptEnd

.Gibberish1Text:
	text "えんちょう『ふぁいへんひゃ"
	line "ふへほ　はんひ"

	para "ひへは　ほはへへ　ひほうはッ！"
	line "はッ　はふへへ　ふへ！"
	done

.Gibberish2Text:
	text "よほひふ　はほひまふは！"
	line "はふは　はふぁりほーんひゃ！"
	done

.Gibberish3Text:
	text "はひ？"
	line "ほは　ほうは<⋯>"
	cont "ひひ　ほはへには　はのはんはッ！"
	done

.GaveTheGoldTeethText:
	text "えんちょうは　<PLAYER>から"
	line "きんのいればを　もらった！@"
	sound_get_item_1
	text_start

	para "もらった　いればを"
	line "いそいで　くちに　はめた！"
	prompt

.ThanksText:
	text "えんちょう『すんまへん！"
	cont "ほんま　たすかったわあ！"
	cont "だれに　なに　いうても"
	cont "ぜんぜん　つうじへんし"

	para "はずかしゅうて　じむしょも"
	line "かお　だせへん　かったんや"
	cont "そや　ぼうず！"
	cont "あんがとな"
	cont "おれいに　ええもん　やるわ！"
	prompt

.ReceivedHM04Text:
	text "<PLAYER>は　えんちょうから"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_item_1
	text_end

.HM04ExplanationText:
	text "えんちょう『ひでんマシン０４の"
	line "なかみは　かいりき　やで！"

	para "#が"
	line "ちから　もちに　なってな"
	cont "たたかわん　ときは"
	cont "いわを　おすように　なるで！"

	para "そや<⋯>　それから！"
	line "サファリ　ゾーンで"
	cont "トレジャー　ハウスは　みつけたか？"
	cont "ひでんマシンが　もらえるで！"

	para "めったに　てに　はいらん"
	line "なみのり　なんやで！"
	done

.HM04NoRoomText:
	text "なんや　にもつ"
	line "いっぱいやんけ！"
	done

WardensHouseDisplayText:
	text_asm
	ldh a, [hTextID]
	cp TEXT_WARDENSHOUSE_DISPLAY_LEFT
	ld hl, .MerchandiseText
	jr nz, .print_text
	ld hl, .PhotosAndFossilsText
.print_text
	call PrintText
	jp TextScriptEnd

.PhotosAndFossilsText:
	text "#の　カセキやら"
	line "しゃしんが　かざって　ある！"
	done

.MerchandiseText:
	text "ふるい　#　グッズが"
	line "かざって　ある！"
	done
