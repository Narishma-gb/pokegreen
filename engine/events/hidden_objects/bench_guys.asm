PrintBenchGuyText:
	call EnableAutoTextBoxDrawing
	ld hl, BenchGuyTextPointers
	ld a, [wCurMap]
	ld b, a
.loop
	ld a, [hli]
	cp -1
	ret z
	cp b
	jr z, .match
	inc hl
	inc hl
	jr .loop
.match
	ld a, [hli]
	ld b, a
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp b

	; bug: an 'inc hl' instruction is needed before looping back. When trying to
	; talk to a bench guy from above, this Sprite Facing test will fail, and the
	; next loop iteration will be misaligned within BenchGuyTextPointers table.
	; As a result, the routine will miss the terminator byte, and continue to
	; process data beyond the table boundary.
	; It seems that it will only return after starting to read data from VRAM
	; (According to Pan Docs, during PPU mode 3, reads return garbage value,
	; usually $FF).
	jr nz, .loop ; player isn't facing the bench guy
	ld a, [hl]
	jp PrintPredefTextID

INCLUDE "data/events/bench_guys.asm"

ViridianCityPokecenterBenchGuyText::
	text "#センターに　あずけると"
	line "つかれて　うごけない"
	cont "#も　げんきに　なるよ！"
	done

PewterCityPokecenterBenchGuyText::
	text "ほぁーひゃ<⋯>！"

	para "プリンの　うたごえを　きくと<⋯>"
	line "たいていの　#は　ねむくなる"

	para "<⋯>そして"
	line "ぼくも<⋯>ぐー<⋯>"
	done

CeruleanCityPokecenterBenchGuyText::
	text "マサキ　にいちゃん"
	line "#　いっぱい　もってるよ！"

	para "めずらしい　#も"
	line "あつめてるって"
	done

LavenderCityPokecenterBenchGuyText::
	text "カラカラの　しゅぞくは"
	line "ほねを　かぶってる　だろ？"

	para "あれが　たかく　うれるんだって"
	done

MtMoonPokecenterBenchGuyText::
	text "#を　たくさん　つかまえて"
	line "もちきれない　ときは"

	para "<PC>　つうしんで"
	line "あずけると　いいよ"
	done

RockTunnelPokecenterBenchGuyText::
	text "シオン　タウンで"
	line "ゆうれい　#が　でるって"
	cont "みんな　さわいでるよ"
	done

SafariZoneWestRestHouseStoolText::
	text "ぼくも　#とり　したいなー"
	done

SafariZoneEastRestHouseStoolText::
	text "はしゃぎすぎて　つかれちゃった<⋯>"
	done

SafariZoneNorthRestHouseStoolText::
	text "シルフのチーフが　サファリゾーンの"
	line "どこかに　かくれてるんだって！"
	done

VermilionCityPokecenterBenchGuyText::
	text "たしかに　レベルの　たかい"
	line "#は　つよい　けど<⋯>"

	para "#の　タイプに　よって"
	line "にがてな　あいてが　ある　みたい"

	para "ぜったいに　つよい　#は"
	line "なかなか　いない　みたいだ"
	done

CeladonCityPokecenterBenchGuyText::
	text "ぼくも　じてんしゃ　もってたら"
	line "サイクリング　ロード　いきたーい！"
	done

FuchsiaCityPokecenterBenchGuyText::
	text "にいちゃん"
	line "#　ずかん　つくってる　なら"
	cont "サファリ　ゾーン　いくと　いいよ"

	para "めずらしい　#が"
	line "たくさん　はんしょく　してるって"
	done

CinnabarIslandPokecenterBenchGuyText::
	text "しんかキャンセル　した　あとも"
	line "#は　わざを　おぼえるよ"

	para "わざを　おぼえさせて　いってから"
	line "しんか　させるのも　コツさ"
	done

SaffronCityPokecenterBenchGuyText::
	text_asm
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ld hl, SaffronCityPokecenterBenchGuyText2
	jr nz, .printText
	ld hl, SaffronCityPokecenterBenchGuyText1
.printText
	call PrintText
	jp TextScriptEnd

SaffronCityPokecenterBenchGuyText1:
	text "あーあ<⋯>"
	line "#　してんのうが　きて"
	cont "<ROCKET>を　やっつけて"
	cont "くれると　いいな"
	done

SaffronCityPokecenterBenchGuyText2:
	text "<ROCKET>　にげてったね！"
	line "これからは　そと　あるいても"
	cont "ちっとも　こわくない！"
	cont "よかったね！"
	done

CeladonCityHotelText::
	text "わーい！　りょこう　だぞー！"
	line "おねえちゃん　だいすき！"
	done
