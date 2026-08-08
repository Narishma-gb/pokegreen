BlkPacket_WholeScreen:
	ATTR_BLK 1
	ATTR_BLK_DATA %011, 0,0,0, 00,00, 19,17
	ds 8, 0

BlkPacket_Battle:
	ATTR_BLK 5
	ATTR_BLK_DATA %111, 2,2,0, 00,12, 19,17 ; message box: pal 2
	ATTR_BLK_DATA %011, 1,1,0, 01,00, 10,03 ; enemy HP bar: pal 1
	ATTR_BLK_DATA %011, 0,0,0, 10,08, 19,10 ; player HP bar: pal 0
	ATTR_BLK_DATA %011, 2,2,0, 00,04, 08,11 ; player mon: pal 2
	ATTR_BLK_DATA %011, 3,3,0, 11,00, 19,07 ; enemy mon : pal 3

BlkPacket_StatusScreen:
	ATTR_BLK 1
	ATTR_BLK_DATA %111, 1,1,0, 01,00, 07,06 ; mon: pal 1, HP bar: pal 0
	ds 8, 0

BlkPacket_Pokedex:
	ATTR_BLK 1
	ATTR_BLK_DATA %111, 1,1,0, 01,01, 08,08 ; mon: pal 1, everything else: pal 0
	ds 8, 0

BlkPacket_Slots:
	ATTR_BLK 5
	ATTR_BLK_DATA %011, 1,1,0, 00,00, 19,11 ; "3" rows and top of screen: pal 1
	ATTR_BLK_DATA %011, 2,2,0, 00,04, 19,09 ; "2" rows: pal 2
	ATTR_BLK_DATA %010, 3,3,0, 00,06, 19,07 ; "1" row: pal 3
	ATTR_BLK_DATA %011, 0,0,0, 04,04, 15,09 ; slot reels: pal 0
	ATTR_BLK_DATA %011, 0,0,0, 00,12, 19,17 ; message box: pal 0

BlkPacket_Titlescreen:
	ATTR_BLK 3
	ATTR_BLK_DATA %011, 0,0,0, 00,00, 19,07 ; pokemon logo: pal 0
	ATTR_BLK_DATA %010, 1,1,0, 00,08, 19,09 ; version text: pal 1
	ATTR_BLK_DATA %011, 2,2,0, 00,10, 19,17 ; player, mon, copyright text: pal 2
	ds 12, 0

BlkPacket_NidorinoIntro:
	ATTR_BLK 3
	ATTR_BLK_DATA %011, 1,1,0, 00,00, 19,03 ; upper black bar: pal 1
	ATTR_BLK_DATA %011, 0,0,0, 00,04, 19,13 ; letterbox: pal 0
	ATTR_BLK_DATA %011, 1,1,0, 00,14, 19,17 ; lower black bar: pal 1
	ds 12, 0

BlkPacket_PartyMenu:
	ATTR_BLK 7
	ATTR_BLK_DATA %110, 0,0,1, 01,00, 02,12 ; mon sprites: pal 0, everything else: pal 1
	ATTR_BLK_DATA %010, 0,0,0, 12,00, 18,01 ; HP bar 0: pal set dynamically
	ATTR_BLK_DATA %010, 0,0,0, 12,02, 18,03 ; HP bar 1: pal set dynamically
	ATTR_BLK_DATA %010, 0,0,0, 12,04, 18,05 ; HP bar 2: pal set dynamically
	ATTR_BLK_DATA %010, 0,0,0, 12,06, 18,07 ; HP bar 3: pal set dynamically
	ATTR_BLK_DATA %010, 0,0,0, 12,08, 18,09 ; HP bar 4: pal set dynamically
	ATTR_BLK_DATA %010, 0,0,0, 12,10, 18,11 ; HP bar 5: pal set dynamically
	ds 4, 0

BlkPacket_TrainerCard:
	ATTR_BLK 10
	ATTR_BLK_DATA %010, 0,0,0, 03,12, 04,13 ; Boulder Badge
	ATTR_BLK_DATA %010, 1,1,0, 07,12, 08,13 ; Cascade Badge
	ATTR_BLK_DATA %010, 3,3,0, 11,12, 12,13 ; Thunder Badge
	ATTR_BLK_DATA %010, 2,2,0, 16,11, 17,12 ; Rainbow Badge
	ATTR_BLK_DATA %010, 1,1,0, 14,13, 15,14 ; Rainbow Badge
	ATTR_BLK_DATA %010, 3,3,0, 16,13, 17,14 ; Rainbow Badge
	ATTR_BLK_DATA %010, 2,2,0, 03,15, 04,16 ; Soul Badge
	ATTR_BLK_DATA %010, 3,3,0, 07,15, 08,16 ; Marsh Badge
	ATTR_BLK_DATA %010, 2,2,0, 11,15, 12,16 ; Volcano Badge
	ATTR_BLK_DATA %010, 1,1,0, 15,15, 16,16 ; Earth Badge
	ds 2, 0

BlkPacket_GameFreakIntro:
	ATTR_BLK 3
	ATTR_BLK_DATA %111, 1,1,0, 05,11, 07,13 ; falling stars (left): pal 1, GameFreak logo: pal 0
	ATTR_BLK_DATA %010, 2,2,0, 08,11, 09,13 ; falling stars (middle): pal 2
	ATTR_BLK_DATA %011, 3,3,0, 12,11, 14,13 ; falling stars (right): pal 3
	ds 12, 0


PalPacket_Empty:          PAL_SET 0, 0, 0, 0
PalPacket_PartyMenu:      PAL_SET PAL_MEWMON, PAL_GREENBAR, PAL_YELLOWBAR, PAL_REDBAR
PalPacket_Black:          PAL_SET PAL_BLACK, PAL_BLACK, PAL_BLACK, PAL_BLACK
PalPacket_TownMap:        PAL_SET PAL_TOWNMAP, 0, 0, 0
PalPacket_Pokedex:        PAL_SET PAL_BROWNMON, 0, 0, 0
PalPacket_Slots:          PAL_SET PAL_SLOTS1, PAL_SLOTS2, PAL_SLOTS3, PAL_SLOTS4
PalPacket_Titlescreen:    PAL_SET PAL_LOGO2, PAL_LOGO1, PAL_MEWMON, PAL_PURPLEMON
PalPacket_TrainerCard:    PAL_SET PAL_MEWMON, PAL_BADGE, PAL_REDMON, PAL_YELLOWMON
PalPacket_Generic:        PAL_SET PAL_MEWMON, 0, 0, 0
PalPacket_NidorinoIntro:  PAL_SET PAL_PURPLEMON, PAL_BLACK, 0, 0
PalPacket_GameFreakIntro: PAL_SET PAL_GAMEFREAK, PAL_REDMON, PAL_VIRIDIAN, PAL_BLUEMON

PalTrnPacket:  PAL_TRN
MltReq1Packet: MLT_REQ 1
MltReq2Packet: MLT_REQ 2
ChrTrnPacket:  CHR_TRN 0, 0
PctTrnPacket:  PCT_TRN

MaskEnCancelPacket: MASK_EN 0
