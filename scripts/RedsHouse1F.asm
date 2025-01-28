RedsHouse1F_Script:
	jp EnableAutoTextBoxDrawing

RedsHouse1F_TextPointers:
	def_text_pointers
	dw_const RedsHouse1FMomText, TEXT_REDSHOUSE1F_MOM
	dw_const RedsHouse1FTVText,  TEXT_REDSHOUSE1F_TV
	
RedsHouse1FMomText:
	text_asm
	ld a, [wStatusFlags4]
	bit BIT_GOT_STARTER, a
	jr nz, .heal
	ld hl, .WakeUpText
	call PrintText
	jr .done
.heal
	call RedsHouse1FMomHealScript
.done
	jp TextScriptEnd

.WakeUpText:
	text "おかあさん『<⋯>　そうね"
	line "おとこのこは　いつか"
	cont "たびに　でるもの　なのよ"
	cont "うん<⋯>　テレビの　はなしよ！"
	
	para "そういえば"
	line "となりの　オーキドはかせが"
	cont "あなたを　よんでたわよ"
	done

RedsHouse1FMomHealScript:
	ld hl, RedsHouse1FMomYouShouldRestText
	call PrintText
	call GBFadeOutToWhite
	call ReloadMapData
	predef HealParty
	ld a, MUSIC_PKMN_HEALED
	ld [wNewSoundID], a
	call PlaySound
.next
	ld a, [wChannelSoundIDs]
	cp MUSIC_PKMN_HEALED
	jr z, .next
	ld a, [wMapMusicSoundID]
	ld [wNewSoundID], a
	call PlaySound
	call GBFadeInFromWhite
	ld hl, RedsHouse1FMomLookingGreatText
	jp PrintText

RedsHouse1FMomYouShouldRestText:
	text "おかあさん『<PLAYER><⋯>！"
	line "すこし　やすんで　いったら"
	cont "どうかしら<⋯>？"
	cont "<⋯>　<⋯>　<⋯>"
	prompt

RedsHouse1FMomLookingGreatText:
	text "おかあさん『あらあら！"
	line "あなたも　#も"
	cont "げんき　いっぱいね！"
	cont "それじゃ　きを　つけて！"
	cont "いってらっしゃい！"
	done

RedsHouse1FTVText:
	text_asm
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ld hl, .WrongSideText
	jr nz, .got_text
	ld hl, .StandByMeMovieText
.got_text
	call PrintText
	jp TextScriptEnd

.StandByMeMovieText:
	text "テレビで　えいがを　やってる！"
	line "おとこのこが　４にん"
	cont "せんろのうえを　あるいてる<⋯>"
	
	para "<⋯>　ぼくも　もう　いかなきゃ！"
	done

.WrongSideText:
	text "みえない<⋯>"
	done