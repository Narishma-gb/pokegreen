	object_const_def
	const_export REDSHOUSE2F_ROCKET1

RedsHouse2F_Object:
	db $a ; border block

	def_warp_events
	warp_event  7,  1, REDS_HOUSE_1F, 3

	def_bg_events

	def_object_events
	object_event  3, 1, SPRITE_ROCKET, STAY, DOWN, TEXT_REDSHOUSE2F_ROCKET1

	def_warps_to REDS_HOUSE_2F
