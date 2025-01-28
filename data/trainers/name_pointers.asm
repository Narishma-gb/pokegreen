TrainerNamePointers:
; These are shortened variants of some trainer class names, used for trainers' defeat speeches.
; If no short name exists, points to the full opponent's name stored in wTrainerName.
	table_width 2
	dw .YoungsterName
	dw .BugCatcherName
	dw .LassName
	dw wTrainerName
	dw .JrTrainerMName
	dw .JrTrainerFName
	dw .PokemaniacName
	dw .SuperNerdName
	dw wTrainerName
	dw wTrainerName
	dw .BurglarName
	dw .EngineerName
	dw .UnusedJugglerName
	dw wTrainerName
	dw .SwimmerName
	dw wTrainerName
	dw wTrainerName
	dw .BeautyName
	dw wTrainerName
	dw .RockerName
	dw .JugglerName
	dw wTrainerName
	dw wTrainerName
	dw .BlackbeltName
	dw wTrainerName
	dw .ProfOakName
	dw .ChiefName
	dw .ScientistName
	dw wTrainerName
	dw .RocketName
	dw .CooltrainerMName
	dw .CooltrainerFName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	dw wTrainerName
	assert_table_length NUM_TRAINERS

.YoungsterName:     db "たんパン@"
.BugCatcherName:    db "むしとり@"
.LassName:          db "ミニスカ@"
.JrTrainerMName:    db "ボーイ@"
.JrTrainerFName:    db "ガール@"
.PokemaniacName:    db "マニア@"
.SuperNerdName:     db "りかけい@"
.BurglarName:       db "どろぼう@"
.EngineerName:      db "オヤジ@"
.UnusedJugglerName: db "ジャック@"
.SwimmerName:       db "かいパン@"
.BeautyName:        db "おねえさん@"
.RockerName:        db "グループ@"
.JugglerName:       db "ジャグラー@"
.BlackbeltName:     db "からて@"
.ProfOakName:       db "オーキド@"
.ChiefName:         db "チーフ@"
.ScientistName:     db "けんきゅういん@"
.RocketName:        db "だんいん@"
.CooltrainerMName:  db "エリート♂@"
.CooltrainerFName:  db "エリート♀@"