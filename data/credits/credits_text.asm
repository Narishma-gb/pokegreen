CreditsTextPointers:
; entries correspond to CRED_* constants
	table_width 2
	dw .CredStaff
	dw .CredTajiri
	dw .CredOota
	dw .CredMorimoto
	dw .CredWatanabe
	dw .CredMasuda
	dw .CredNisino
	dw .CredSugimori
	dw .CredNishida
	dw .CredMiyamoto
	dw .CredKawaguchi
	dw .CredIshihara
	dw .CredYamauchi
	dw .CredZinnai
	dw .CredHishida
	dw .CredSakai
	dw .CredYamaguchi
	dw .CredYamamoto
	dw .CredTaniguchi
	dw .CredNonomura
	dw .CredFuziwara
	dw .CredMatsusima
	dw .CredTomisawa
	dw .CredKawamoto
	dw .CredKakei
	dw .CredTsuchiya
	dw .CredNakamura
	dw .CredYuda
	dw .CredMon
	dw .CredDirector
	dw .CredProgrammers
	dw .CredCharDesign
	dw .CredMusic
	dw .CredSoundEffects
	dw .CredGameDesign
	dw .CredMonsterDesign
	dw .CredGameScene
	dw .CredParam
	dw .CredMap
	dw .CredTest
	dw .CredSpecial
	dw .CredProducers
	dw .CredExecutive
	assert_table_length NUM_CRED_STRINGS

.CredStaff:
	db "スタッフ@"
.CredTajiri:
	db "たじり　さとし@"
.CredOota:
	db "おおた　たけのり@"
.CredMorimoto:
	db "もりもと　しげき@"
.CredWatanabe:
	db "わたなべ　てつや@"
.CredMasuda:
	db "ますだ　じゅんいち@"
.CredNisino:
	db "にしの　こうじ@"
.CredSugimori:
	db "すぎもり　けん@"
.CredNishida:
	db "にしだ　あつこ@"
.CredMiyamoto:
	db "みやもと　しげる@"
.CredKawaguchi:
	db "かわぐち　たかし@"
.CredIshihara:
	db "いしはら　つねかず@"
.CredYamauchi:
	db "やまうち　ひろし@"
.CredZinnai:
	db "じんない　ひろゆき@"
.CredHishida:
	db "ひしだ　たつや@"
.CredSakai:
	db "さかい　やすひろ@"
.CredYamaguchi:
	db "やまぐち　わたる@"
.CredYamamoto:
	db "やまもと　かずゆき@"
.CredTaniguchi:
	db "たにぐち　りょうすけ@"
.CredNonomura:
	db "ののむら　ふみひろ@"
.CredFuziwara:
	db "ふじわら　もとふみ@"
.CredMatsusima:
	db "まつしま　けんじ@"
.CredTomisawa:
	db "とみさわ　あきひと@"
.CredKawamoto:
	db "かわもと　ひろし@"
.CredKakei:
	db "かけい　あきよし@"
.CredTsuchiya:
	db "つちや　かづき@"
.CredNakamura:
	db "なかむら　たけお@"
.CredYuda:
	db "ゆだ　まさみつ@"
.CredMon:
	db "ポケットモンスター@"
.CredDirector:
	db "ディレクター@"
.CredProgrammers:
	db "プログラム@"
.CredCharDesign:
	db "キャラクターデザイン@"
.CredMusic:
	db "おんがく@"
.CredSoundEffects:
	db "サウンド　エフェクト@"
.CredGameDesign:
	db "ゲームデザイン@"
.CredMonsterDesign:
	db "モンスター　デザイン@"
.CredGameScene:
	db "シナリオ@"
.CredParam:
	db "パラメータ　せってい@"
.CredMap:
	db "マップ　デザイン@"
.CredTest:
	db "デバッグ　プレイ@"
.CredSpecial:
	db "スペシャル·サンクス@"
.CredProducers:
	db "プロデューサー@"
.CredExecutive:
	db "エグゼクティブ　プロデューサー@"

CreditsTextOffsets:
	table_width 1
	db -1
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -4
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -3
	db -2
	db -4
	db -1
	db -4
	db -3
	db -4
	db -2
	db -4
	db -3
	db -3
	db -4
	db -3
	db -6
	assert_table_length NUM_CRED_STRINGS
