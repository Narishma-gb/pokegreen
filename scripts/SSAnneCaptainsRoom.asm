SSAnneCaptainsRoom_Script:
	call SSAnneCaptainsRoomEventScript
	jp EnableAutoTextBoxDrawing

SSAnneCaptainsRoomEventScript:
	CheckEvent EVENT_RUBBED_CAPTAINS_BACK
	ret nz
	ld hl, wStatusFlags3
	set BIT_NO_NPC_FACE_PLAYER, [hl]
	ret

SSAnneCaptainsRoom_TextPointers:
	def_text_pointers
	dw_const SSAnneCaptainsRoomCaptainText,     TEXT_SSANNECAPTAINSROOM_CAPTAIN
	dw_const SSAnneCaptainsRoomTrashText,       TEXT_SSANNECAPTAINSROOM_TRASH
	dw_const SSAnneCaptainsRoomSeasickBookText, TEXT_SSANNECAPTAINSROOM_SEASICK_BOOK

SSAnneCaptainsRoomCaptainText:
	text_asm
	CheckEvent EVENT_GOT_HM01
	jr nz, .got_item
	ld hl, SSAnneCaptainsRoomRubCaptainsBackText
	call PrintText
	ld hl, SSAnneCaptainsRoomCaptainIFeelMuchBetterText
	call PrintText
	lb bc, HM_CUT, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, SSAnneCaptainsRoomCaptainReceivedHM01Text
	call PrintText
	SetEvent EVENT_GOT_HM01
	jr .done
.bag_full
	ld hl, SSAnneCaptainsRoomCaptainHM01NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, SSAnneCaptainsRoomCaptainNotSickAnymoreText
	call PrintText
.done
	jp TextScriptEnd

SSAnneCaptainsRoomRubCaptainsBackText:
	text "せんちょう『おえー<⋯>！"
	line "ふなよいで<⋯>　すっかり　ダウンだ"
	cont "くるしい<⋯>　<⋯>　うえ！"

	para "<PLAYER>は　せんちょうの"
	line "せなかを　さすって　あげた！"

	para "すりすり<⋯>　すりすり<⋯>"
	line "すりすり<⋯>　すりすり<⋯>@"
	text_asm
	ld a, [wAudioROMBank]
	cp BANK("Audio Engine 3")
	ld [wAudioSavedROMBank], a
	jr nz, .not_audio_engine_3
	ld a, SFX_STOP_ALL_MUSIC
	ld [wNewSoundID], a
	call PlaySound
	ld a, BANK(Music_PkmnHealed)
	ld [wAudioROMBank], a
.not_audio_engine_3
	ld a, MUSIC_PKMN_HEALED
	ld [wNewSoundID], a
	call PlaySound
.loop
	ld a, [wChannelSoundIDs]
	cp MUSIC_PKMN_HEALED
	jr z, .loop
	call PlayDefaultMusic
	SetEvent EVENT_RUBBED_CAPTAINS_BACK
	ld hl, wStatusFlags3
	res BIT_NO_NPC_FACE_PLAYER, [hl]
	jp TextScriptEnd

SSAnneCaptainsRoomCaptainIFeelMuchBetterText:
	text "せんちょう『ふう<⋯>　ありがとう"
	line "だいぶ　ラクに　なった　みたいだ"

	para "<⋯>なになに　なんだ"
	line "ひでんの　わざを　みに　きたのか"

	para "げんきな　ときなら　じまんの"
	line "いあいぎりを　みせるんだがなあ<⋯>"

	para "そうだ！"
	line "かわりに　これを　あげよう！"

	para "これを　きみの　"
	line "#に　おしえれば"
	cont "いつでも　いあいぎりが　みれる！"
	prompt

SSAnneCaptainsRoomCaptainReceivedHM01Text:
	text "<PLAYER>は　せんちょう　から"
	line "@"
	text_ram wStringBuffer
	text "を　もらった！@"
	sound_get_key_item
	text_end

SSAnneCaptainsRoomCaptainNotSickAnymoreText:
	text "せんちょう『<⋯>ふう！"

	para "らくに　なったし<⋯>"
	line "そろそろ　じかんだ！"

	para "もうすぐ　サント·アンヌは"
	line "しゅっぱつ　するよ！"

	para "また　クチバに　くる　ときまで"
	line "ごきげんよう！"
	done

SSAnneCaptainsRoomCaptainHM01NoRoomText:
	text "なんとー！"
	line "にもつが　いっぱいだ！"
	done

SSAnneCaptainsRoomTrashText:
	text "あんまり　みないほうが"
	line "いい　みたいだ<⋯>"
	done

SSAnneCaptainsRoomSeasickBookText:
	text "ふなよい　しない"
	line "ふなのり　にゅうもん<⋯>"
	cont "<⋯>これは"
	cont "せんちょうが　よんでいる　ほんだ！"
	done
