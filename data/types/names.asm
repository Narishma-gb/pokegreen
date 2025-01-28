TypeNames:
	table_width 2

	dw .Normal
	dw .Fighting
	dw .Flying
	dw .Poison
	dw .Ground
	dw .Rock
	dw .Bird
	dw .Bug
	dw .Ghost

REPT UNUSED_TYPES_END - UNUSED_TYPES
	dw .Normal
ENDR

	dw .Fire
	dw .Water
	dw .Grass
	dw .Electric
	dw .Psychic
	dw .Ice
	dw .Dragon

	assert_table_length NUM_TYPES

.Normal:   db "ノーマル@"
.Fighting: db "かくとう@"
.Flying:   db "ひこう@"
.Poison:   db "どく　@"
.Fire:     db "ほのお@"
.Water:    db "みず　@"
.Grass:    db "くさ　@"
.Electric: db "でんき@"
.Psychic:  db "エスパー@"
.Ice:      db "こおり@"
.Ground:   db "じめん@"
.Rock:     db "いわ@"
.Bird:     db "とり@"
.Bug:      db "むし@"
.Ghost:    db "ゴースト@"
.Dragon:   db "ドラゴン@"
