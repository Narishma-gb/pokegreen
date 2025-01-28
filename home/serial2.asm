; This is used to exchange the button press and selected menu item on the link menu.
; The data is sent thrice and read twice to increase reliability.
Serial_ExchangeLinkMenuSelection::
	ld hl, wLinkMenuSelectionSendBuffer
	ld de, wLinkMenuSelectionReceiveBuffer
	ld c, 2 ; number of bytes to save
	ld a, 1
	ldh [hSerialIgnoringInitialData], a
.loop
	call DelayFrame
	ld a, [hl]
	ldh [hSerialSendData], a
	call Serial_ExchangeByte
	ld b, a
	inc hl
	ldh a, [hSerialIgnoringInitialData]
	and a
	ld a, 0
	ldh [hSerialIgnoringInitialData], a
	jr nz, .loop
	ld a, b
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

Serial_PrintWaitingTextAndSyncAndExchangeNybble::
	call SaveScreenTilesToBuffer1
	callfar PrintWaitingText
	call Serial_SyncAndExchangeNybble
	jp LoadScreenTilesFromBuffer1

Serial_SyncAndExchangeNybble::
	ld a, $ff
	ld [wSerialExchangeNybbleReceiveData], a
.loop1
	call Serial_ExchangeNybble
	call DelayFrame
	call IsUnknownCounterZero
	jr z, .next1
	push hl
	ld hl, wUnknownSerialCounter + 1
	dec [hl]
	jr nz, .next2
	dec hl
	dec [hl]
	jr nz, .next2
	pop hl
	xor a
	jp SetUnknownCounterToFFFF
.next2
	pop hl
.next1
	ld a, [wSerialExchangeNybbleReceiveData]
	inc a
	jr z, .loop1
	ld b, 10
.loop2
	call DelayFrame
	call Serial_ExchangeNybble
	dec b
	jr nz, .loop2
	ld b, 10
.loop3
	call DelayFrame
	call Serial_SendZeroByte
	dec b
	jr nz, .loop3
	ld a, [wSerialExchangeNybbleReceiveData]
	ld [wSerialSyncAndExchangeNybbleReceiveData], a
	ret
