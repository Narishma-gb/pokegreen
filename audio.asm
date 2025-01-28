; Audio Engine 1 (Bank $02)
	audio_def 1

SECTION "Sound Effect Headers 1", ROMX

INCLUDE "audio/headers/sfx_headers_common.asm"
INCLUDE "audio/headers/sfx_headers_1_3.asm"
INCLUDE "audio/headers/sfx_headers_1.asm"


SECTION "Music Headers 1", ROMX

INCLUDE "audio/headers/music_headers_1.asm"


SECTION "Sound Effects 1", ROMX

INCLUDE "audio/noise_wave_common.asm"

INCLUDE "audio/sfx/start_menu.asm"
INCLUDE "audio/sfx/pokeflute.asm"
INCLUDE "audio/sfx/cut.asm"
INCLUDE "audio/sfx/go_inside.asm"
INCLUDE "audio/sfx/swap.asm"
INCLUDE "audio/sfx/tink.asm"
INCLUDE "audio/sfx/59.asm"
INCLUDE "audio/sfx/purchase.asm"
INCLUDE "audio/sfx/collision.asm"
INCLUDE "audio/sfx/go_outside.asm"
INCLUDE "audio/sfx/press_ab.asm"
INCLUDE "audio/sfx/save.asm"
INCLUDE "audio/sfx/heal_hp.asm"
INCLUDE "audio/sfx/poisoned.asm"
INCLUDE "audio/sfx/heal_ailment.asm"
INCLUDE "audio/sfx/trade_machine.asm"
INCLUDE "audio/sfx/turn_on_pc.asm"
INCLUDE "audio/sfx/turn_off_pc.asm"
INCLUDE "audio/sfx/enter_pc.asm"
INCLUDE "audio/sfx/shrink.asm"
INCLUDE "audio/sfx/switch.asm"
INCLUDE "audio/sfx/healing_machine.asm"
INCLUDE "audio/sfx/teleport_exit1.asm"
INCLUDE "audio/sfx/teleport_enter1.asm"
INCLUDE "audio/sfx/teleport_exit2.asm"
INCLUDE "audio/sfx/ledge.asm"
INCLUDE "audio/sfx/teleport_enter2.asm"
INCLUDE "audio/sfx/fly.asm"
INCLUDE "audio/sfx/denied.asm"
INCLUDE "audio/sfx/arrow_tiles.asm"
INCLUDE "audio/sfx/push_boulder.asm"
INCLUDE "audio/sfx/ss_anne_horn.asm"
INCLUDE "audio/sfx/withdraw_deposit.asm"
INCLUDE "audio/sfx/safari_zone_pa.asm"

INCLUDE "audio/cry_common.asm"


SECTION "Audio Engine 1", ROMX

INCLUDE "audio/engine_1.asm"
INCLUDE "audio/alternate_tempo.asm"


SECTION "Play Battle Music (Audio Engine 1)", ROMX

INCLUDE "audio/play_battle_music.asm"


SECTION "Music 1", ROMX

INCLUDE "audio/music/pkmn_healed.asm"
INCLUDE "audio/music/routes_1.asm"
INCLUDE "audio/music/routes_2.asm"
INCLUDE "audio/music/routes_3.asm"
INCLUDE "audio/music/routes_4.asm"
INCLUDE "audio/music/indigo_plateau.asm"
INCLUDE "audio/music/pallet_town.asm"
INCLUDE "audio/music/unused_song.asm"
INCLUDE "audio/music/cities_1.asm"
INCLUDE "audio/sfx/get_item1.asm"
INCLUDE "audio/music/museum_guy.asm"
INCLUDE "audio/music/meet_prof_oak.asm"
INCLUDE "audio/music/meet_rival.asm"
INCLUDE "audio/sfx/pokedex_rating.asm"
INCLUDE "audio/sfx/get_item2.asm"
INCLUDE "audio/sfx/get_key_item.asm"
INCLUDE "audio/music/ss_anne.asm"
INCLUDE "audio/music/cities_2.asm"
INCLUDE "audio/music/celadon.asm"
INCLUDE "audio/music/cinnabar.asm"
INCLUDE "audio/music/vermilion.asm"
INCLUDE "audio/music/lavender.asm"
INCLUDE "audio/music/safari_zone.asm"
INCLUDE "audio/music/gym.asm"
INCLUDE "audio/music/pokecenter.asm"


; Audio Engine 2 (Bank $08)
	audio_def 2

SECTION "Audio Engine 2", ROMX

INCLUDE "audio/engine_2.asm"
INCLUDE "audio/poke_flute.asm"


SECTION "Low Health Alarm (Audio Engine 2)", ROMX

INCLUDE "audio/low_health_alarm.asm"


SECTION "Sound Effect Headers 2", ROMX

INCLUDE "audio/headers/sfx_headers_common.asm"
INCLUDE "audio/headers/sfx_headers_2.asm"


SECTION "Music Headers 2", ROMX

INCLUDE "audio/headers/music_headers_2.asm"


SECTION "Sound Effects 2", ROMX

INCLUDE "audio/noise_wave_common.asm"

INCLUDE "audio/sfx/press_ab.asm"
INCLUDE "audio/sfx/start_menu.asm"
INCLUDE "audio/sfx/tink.asm"
INCLUDE "audio/sfx/heal_hp.asm"
INCLUDE "audio/sfx/heal_ailment.asm"
INCLUDE "audio/sfx/silph_scope.asm"
INCLUDE "audio/sfx/ball_toss.asm"
INCLUDE "audio/sfx/ball_poof.asm"
INCLUDE "audio/sfx/faint_thud.asm"
INCLUDE "audio/sfx/run.asm"
INCLUDE "audio/sfx/dex_page_added.asm"
INCLUDE "audio/sfx/pokeflute_ch7.asm"
INCLUDE "audio/sfx/peck.asm"
INCLUDE "audio/sfx/faint_fall.asm"
INCLUDE "audio/sfx/battle_09.asm"
INCLUDE "audio/sfx/pound.asm"
INCLUDE "audio/sfx/battle_0b.asm"
INCLUDE "audio/sfx/battle_0c.asm"
INCLUDE "audio/sfx/battle_0d.asm"
INCLUDE "audio/sfx/battle_0e.asm"
INCLUDE "audio/sfx/battle_0f.asm"
INCLUDE "audio/sfx/damage.asm"
INCLUDE "audio/sfx/not_very_effective.asm"
INCLUDE "audio/sfx/battle_12.asm"
INCLUDE "audio/sfx/battle_13.asm"
INCLUDE "audio/sfx/battle_14.asm"
INCLUDE "audio/sfx/vine_whip.asm"
INCLUDE "audio/sfx/battle_16.asm"
INCLUDE "audio/sfx/battle_17.asm"
INCLUDE "audio/sfx/battle_18.asm"
INCLUDE "audio/sfx/battle_19.asm"
INCLUDE "audio/sfx/super_effective.asm"
INCLUDE "audio/sfx/battle_1b.asm"
INCLUDE "audio/sfx/battle_1c.asm"
INCLUDE "audio/sfx/doubleslap.asm"
INCLUDE "audio/sfx/battle_1e.asm"
INCLUDE "audio/sfx/horn_drill.asm"
INCLUDE "audio/sfx/battle_20.asm"
INCLUDE "audio/sfx/battle_21.asm"
INCLUDE "audio/sfx/battle_22.asm"
INCLUDE "audio/sfx/battle_23.asm"
INCLUDE "audio/sfx/battle_24.asm"
INCLUDE "audio/sfx/battle_25.asm"
INCLUDE "audio/sfx/battle_26.asm"
INCLUDE "audio/sfx/battle_27.asm"
INCLUDE "audio/sfx/battle_28.asm"
INCLUDE "audio/sfx/battle_29.asm"
INCLUDE "audio/sfx/battle_2a.asm"
INCLUDE "audio/sfx/battle_2b.asm"
INCLUDE "audio/sfx/battle_2c.asm"
INCLUDE "audio/sfx/psybeam.asm"
INCLUDE "audio/sfx/battle_2e.asm"
INCLUDE "audio/sfx/battle_2f.asm"
INCLUDE "audio/sfx/psychic_m.asm"
INCLUDE "audio/sfx/battle_31.asm"
INCLUDE "audio/sfx/battle_32.asm"
INCLUDE "audio/sfx/battle_33.asm"
INCLUDE "audio/sfx/battle_34.asm"
INCLUDE "audio/sfx/battle_35.asm"
INCLUDE "audio/sfx/battle_36.asm"

INCLUDE "audio/cry_common.asm"


SECTION "Music 2", ROMX

INCLUDE "audio/sfx/pokeflute_ch5_ch6.asm"
INCLUDE "audio/sfx/unused_fanfare.asm"
INCLUDE "audio/music/gym_leader_battle.asm"
INCLUDE "audio/music/trainer_battle.asm"
INCLUDE "audio/music/wild_battle.asm"
INCLUDE "audio/music/final_battle.asm"
INCLUDE "audio/sfx/level_up.asm"
INCLUDE "audio/sfx/get_item2.asm"
INCLUDE "audio/sfx/caught_mon.asm"
INCLUDE "audio/music/defeated_trainer.asm"
INCLUDE "audio/music/defeated_wild_mon.asm"
INCLUDE "audio/music/defeated_gym_leader.asm"


; Audio Engine 3 (Bank $1F)
	audio_def 3

SECTION "Audio Engine 3", ROMX

INCLUDE "audio/music/credits.asm"
INCLUDE "audio/pokedex_rating_sfx.asm"
INCLUDE "audio/engine_3.asm"


SECTION "Sound Effect Headers 3", ROMX

INCLUDE "audio/headers/sfx_headers_common.asm"
INCLUDE "audio/headers/sfx_headers_1_3.asm"
INCLUDE "audio/headers/sfx_headers_3.asm"


SECTION "Music Headers 3", ROMX

INCLUDE "audio/headers/music_headers_3.asm"


SECTION "Sound Effects 3", ROMX

INCLUDE "audio/noise_wave_common.asm"

INCLUDE "audio/sfx/start_menu.asm"
INCLUDE "audio/sfx/cut.asm"
INCLUDE "audio/sfx/go_inside.asm"
INCLUDE "audio/sfx/swap.asm"
INCLUDE "audio/sfx/tink.asm"
INCLUDE "audio/sfx/59.asm"
INCLUDE "audio/sfx/purchase.asm"
INCLUDE "audio/sfx/collision.asm"
INCLUDE "audio/sfx/go_outside.asm"
INCLUDE "audio/sfx/press_ab.asm"
INCLUDE "audio/sfx/save.asm"
INCLUDE "audio/sfx/heal_hp.asm"
INCLUDE "audio/sfx/poisoned.asm"
INCLUDE "audio/sfx/heal_ailment.asm"
INCLUDE "audio/sfx/trade_machine.asm"
INCLUDE "audio/sfx/turn_on_pc.asm"
INCLUDE "audio/sfx/turn_off_pc.asm"
INCLUDE "audio/sfx/enter_pc.asm"
INCLUDE "audio/sfx/shrink.asm"
INCLUDE "audio/sfx/switch.asm"
INCLUDE "audio/sfx/healing_machine.asm"
INCLUDE "audio/sfx/teleport_exit1.asm"
INCLUDE "audio/sfx/teleport_enter1.asm"
INCLUDE "audio/sfx/teleport_exit2.asm"
INCLUDE "audio/sfx/ledge.asm"
INCLUDE "audio/sfx/teleport_enter2.asm"
INCLUDE "audio/sfx/fly.asm"
INCLUDE "audio/sfx/denied.asm"
INCLUDE "audio/sfx/arrow_tiles.asm"
INCLUDE "audio/sfx/push_boulder.asm"
INCLUDE "audio/sfx/ss_anne_horn.asm"
INCLUDE "audio/sfx/withdraw_deposit.asm"
INCLUDE "audio/sfx/intro_lunge.asm"
INCLUDE "audio/sfx/intro_hip.asm"
INCLUDE "audio/sfx/intro_hop.asm"
INCLUDE "audio/sfx/intro_raise.asm"
INCLUDE "audio/sfx/intro_crash.asm"
INCLUDE "audio/sfx/intro_whoosh.asm"
INCLUDE "audio/sfx/slots_stop_wheel.asm"
INCLUDE "audio/sfx/slots_reward.asm"
INCLUDE "audio/sfx/slots_new_spin.asm"
INCLUDE "audio/sfx/shooting_star.asm"

INCLUDE "audio/cry_common.asm"


SECTION "Music 3", ROMX

INCLUDE "audio/music/bike_riding.asm"
INCLUDE "audio/music/dungeon_1.asm"
INCLUDE "audio/music/game_corner.asm"
INCLUDE "audio/music/title_screen.asm"
INCLUDE "audio/sfx/get_item1.asm"
INCLUDE "audio/music/dungeon_2.asm"
INCLUDE "audio/music/dungeon_3.asm"
INCLUDE "audio/music/cinnabar_mansion.asm"
INCLUDE "audio/sfx/pokedex_rating.asm"
INCLUDE "audio/sfx/get_item2.asm"
INCLUDE "audio/sfx/get_key_item.asm"
INCLUDE "audio/music/oaks_lab.asm"
INCLUDE "audio/music/pokemon_tower.asm"
INCLUDE "audio/music/silph_co.asm"
INCLUDE "audio/music/meet_evil_trainer.asm"
INCLUDE "audio/music/meet_female_trainer.asm"
INCLUDE "audio/music/meet_male_trainer.asm"
INCLUDE "audio/music/intro_battle.asm"
INCLUDE "audio/music/surfing.asm"
INCLUDE "audio/music/jigglypuff_song.asm"
INCLUDE "audio/music/hall_of_fame.asm"
