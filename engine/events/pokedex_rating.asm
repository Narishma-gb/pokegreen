DisplayDexRating:
	ld hl, wPokedexSeen
	ld b, wPokedexSeenEnd - wPokedexSeen
	call CountSetBits
	ld a, [wNumSetBits]
	ldh [hDexRatingNumMonsSeen], a
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	ldh [hDexRatingNumMonsOwned], a
	ld hl, DexRatingsTable
.findRating
	ld a, [hli]
	ld b, a
	ldh a, [hDexRatingNumMonsOwned]
	cp b
	jr c, .foundRating
	inc hl
	inc hl
	jr .findRating
.foundRating
	ld a, [hli]
	ld h, [hl]
	ld l, a ; load text pointer into hl
	CheckAndResetEventA EVENT_HALL_OF_FAME_DEX_RATING
	jr nz, .hallOfFame
	push hl
	ld hl, DexCompletionText
	call PrintText
	pop hl
	call PrintText
	farcall PlayPokedexRatingSfx
	jp WaitForTextScrollButtonPress
.hallOfFame
	ld de, wDexRatingNumMonsSeen
	ldh a, [hDexRatingNumMonsSeen]
	ld [de], a
	inc de
	ldh a, [hDexRatingNumMonsOwned]
	ld [de], a
	inc de
.copyRatingTextLoop
	ld a, [hli]
	cp "<DONE>"
	jr z, .doneCopying
	ld [de], a
	inc de
	jr .copyRatingTextLoop
.doneCopying
	ld [de], a
	ret

DexCompletionText:
	text "<⋯>　<⋯>　#ずかんの"
	line "げんざいの　かんせいど　は<⋯>"

	para "みつけた　#　@"
	text_decimal hDexRatingNumMonsSeen, 1, 3
	text "！"
	line "つかまえた　#　@"
	text_decimal hDexRatingNumMonsOwned, 1, 3
	text "！"

	para "オーキドはかせの　ひょうか<⋯>"
	prompt

DexRatingsTable:
	dbw 10, DexRatingText_Own0To9
	dbw 20, DexRatingText_Own10To19
	dbw 30, DexRatingText_Own20To29
	dbw 40, DexRatingText_Own30To39
	dbw 50, DexRatingText_Own40To49
	dbw 60, DexRatingText_Own50To59
	dbw 70, DexRatingText_Own60To69
	dbw 80, DexRatingText_Own70To79
	dbw 90, DexRatingText_Own80To89
	dbw 100, DexRatingText_Own90To99
	dbw 110, DexRatingText_Own100To109
	dbw 120, DexRatingText_Own110To119
	dbw 130, DexRatingText_Own120To129
	dbw 140, DexRatingText_Own130To139
	dbw 150, DexRatingText_Own140To149
	dbw NUM_POKEMON + 1, DexRatingText_Own150To151

DexRatingText_Own0To9:
	text "まだまだ<⋯>　これからだ"
	line "あちこちの　くさむらに　はいって"
	cont "#を　つかまえるのじゃ！"
	done

DexRatingText_Own10To19:
	text "どうにか　ちょうしが　でてきたな！"
	line "じょしゅに　フラッシュを"
	cont "もたせたぞ！　もらって　くれい！"
	done

DexRatingText_Own20To29:
	text "#ずかんに　しては　まだ"
	line "ボリュームが　たりん！　いろいろな"
	cont "しゅるいの　#を　とるのじゃ！"
	done

DexRatingText_Own30To39:
	text "ふむ<⋯>　がんばってるな！"
	line "じょしゅに　ダウジングマシンを"
	cont "もたせたぞ！　もらって　くれい！"
	done

DexRatingText_Own40To49:
	text "いい　できばえ　じゃないか！"
	line "じょしゅに　がくしゅうそうちを"
	cont "もたせたぞ！　もらって　くれい！"
	done

DexRatingText_Own50To59:
	text "ついに　５０しゅるいを　こえたか！"
	line "<⋯>　この　ちょうし　じゃ！"
	done

DexRatingText_Own60To69:
	text "ほっほう！　<⋯>　こりゃ　いい"
	line "#ずかんに　なって　きとる！"
	done

DexRatingText_Own70To79:
	text "ぜっこうちょう！　うみで　#"
	line "つれば　もっと　あつまり　そうじゃ！"
	done

DexRatingText_Own80To89:
	text "ワンダフル！　もしかして　きみは"
	line "ものを　あつめるの　すきなのか<⋯>？"
	done

DexRatingText_Own90To99:
	text "いやはや<⋯>　こりゃ　すごい！"
	line "あつめるのは　たいへん　だったろ！"
	done

DexRatingText_Own100To109:
	text "とうとう　１００しゅるい　こえたか！"
	line "<⋯>　しんじられない　うでまえじゃ！"
	done

DexRatingText_Own110To119:
	text "#の　しんか　けいたいも"
	line "はいって　きとる<⋯>　すばらしい！"
	done

DexRatingText_Own120To129:
	text "エクセレント！　ともだちと　こうかん"
	line "すると　もっと　あつまる　かもしれん"
	done

DexRatingText_Own130To139:
	text "ここまで　ずかんが　できたら"
	line "もはや　プロフェッショナル　じゃ！"
	done

DexRatingText_Own140To149:
	text "わしゃ　もう　いうことは　ない！"
	line "きみが　#はかせ　じゃ！"
	done

DexRatingText_Own150To151:
	text "ついに　パーフェクトな　ずかんの"
	line "かんせいじゃ！　<⋯>　おめでとう！"
	done
