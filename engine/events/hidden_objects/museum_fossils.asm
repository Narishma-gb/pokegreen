AerodactylFossil:
	ld a, FOSSIL_AERODACTYL
	ld [wCurPartySpecies], a
	call DisplayMonFrontSpriteInBox
	call EnableAutoTextBoxDrawing
	tx_pre AerodactylFossilText
	ret

AerodactylFossilText::
	text "めずらしい　こだい　#"
	line "プテラの　カセキ"
	done

KabutopsFossil:
	ld a, FOSSIL_KABUTOPS
	ld [wCurPartySpecies], a
	call DisplayMonFrontSpriteInBox
	call EnableAutoTextBoxDrawing
	tx_pre KabutopsFossilText
	ret

KabutopsFossilText::
	text "めずらしい　こだい　#"
	line "カブトプスの　カセキ"
	done

DisplayMonFrontSpriteInBox:
; Displays a pokemon's front sprite in a pop-up window.
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	xor a
	ldh [hWY], a
	call SaveScreenTilesToBuffer1
	ld a, MON_SPRITE_POPUP
	ld [wTextBoxID], a
	call DisplayTextBoxID
	call UpdateSprites
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetMonHeader
	ld de, vChars1 tile $31
	call LoadMonFrontSprite
	ld a, $80
	ldh [hStartTileID], a
	hlcoord 10, 11
	predef AnimateSendingOutMon
	call WaitForTextScrollButtonPress
	call LoadScreenTilesFromBuffer1
	call Delay3
	ld a, $90
	ldh [hWY], a
	ret
