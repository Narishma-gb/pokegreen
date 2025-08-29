; $00-$16 are also TX_* constants (see macros/scripts/text.asm)

; Control characters (see home/text.asm)

	charmap "<NULL>",   $00

	charmap "ガ",       $05
	charmap "ギ",       $06
	charmap "グ",       $07
	charmap "ゲ",       $08
	charmap "ゴ",       $09
	charmap "ザ",       $0a
	charmap "ジ",       $0b
	charmap "ズ",       $0c
	charmap "ゼ",       $0d
	charmap "ゾ",       $0e
	charmap "ダ",       $0f
	charmap "ヂ",       $10
	charmap "ヅ",       $11
	charmap "デ",       $12
	charmap "ド",       $13

	charmap "バ",       $19
	charmap "ビ",       $1a
	charmap "ブ",       $1b
	charmap "ベ",       $3d ; same as printing Hiragana べ
	charmap "ボ",       $1c

	charmap "が",       $26
	charmap "ぎ",       $27
	charmap "ぐ",       $28
	charmap "げ",       $29
	charmap "ご",       $2a
	charmap "ざ",       $2b
	charmap "じ",       $2c
	charmap "ず",       $2d
	charmap "ぜ",       $2e
	charmap "ぞ",       $2f
	charmap "だ",       $30
	charmap "ぢ",       $31
	charmap "づ",       $32
	charmap "で",       $33
	charmap "ど",       $34

	charmap "ば",       $3a
	charmap "び",       $3b
	charmap "ぶ",       $3c
	charmap "べ",       $3d
	charmap "ぼ",       $3e

	charmap "パ",       $40
	charmap "ピ",       $41
	charmap "プ",       $42
	charmap "ペ",       $47 ; same as printing Hiragana ぺ
	charmap "ポ",       $43
	charmap "ぱ",       $44
	charmap "ぴ",       $45
	charmap "ぷ",       $46
	charmap "ぺ",       $47
	charmap "ぽ",       $48

	charmap "<_CONT>",   $4b ; implements "<CONT>"
	charmap "<SCROLL>",  $4c
	charmap "<NEXT>",    $4e
	charmap "<LINE>",    $4f
	charmap "@",         $50 ; string terminator
	charmap "<PARA>",    $51
	charmap "<PLAYER>",  $52 ; wPlayerName
	charmap "<RIVAL>",   $53 ; wRivalName
	charmap "#",         $54 ; "ポケモン"
	charmap "<CONT>",    $55
	charmap "<⋯>",      $56 ; "⋯⋯"
	charmap "<DONE>",    $57
	charmap "<PROMPT>",  $58
	charmap "<TARGET>",  $59 ; wBattleMonNick / "てきの　" wEnemyMonNick
	charmap "<USER>",    $5a ; wBattleMonNick / "てきの　" wEnemyMonNick
	charmap "<PC>",      $5b ; "パソコン"
	charmap "<TM>",      $5c ; "わざマシン"
	charmap "<TRAINER>", $5d ; "トレーナー"
	charmap "<ROCKET>",  $5e ; "ロケットだん"

; Actual characters (from gfx/font/font_extra.png)

	charmap "A",  $60
	charmap "B",  $61
	charmap "C",  $62
	charmap "D",  $63
	charmap "E",  $64
	charmap "F",  $65
	charmap "G",  $66
	charmap "H",  $67
	charmap "I",  $68
	charmap "V",  $69
	charmap "S",  $6a
	charmap "L",  $6b
	charmap "M",  $6c
	charmap ":",  $6d ; colon
	charmap "ぃ",  $6e ; hiragana small i
	charmap "ぅ",  $6f ; hiragana small u
	charmap "「",  $70 ; opening single quote
	charmap "」",  $71 ; closing single quote
	charmap "『",  $72 ; opening quote
	charmap "』",  $73 ; closing quote
	charmap "·",  $74 ; middle dot
	charmap "⋯",  $75 ; ellipsis
	charmap "ぁ",  $76 ; hiragana small a
	charmap "ぇ",  $77 ; hiragana small e
	charmap "ぉ",  $78 ; hiragana small o

	charmap "┌",  $79
	charmap "─",  $7a
	charmap "┐",  $7b
	charmap "│",  $7c
	charmap "└",  $7d
	charmap "┘",  $7e
	charmap "　", $7f ; Unicode Ideographic Space U+3000

; Actual characters (from gfx/font/font_battle_extra.png)

	charmap "<LV>", $6e

	charmap "<do>", $70 ; single tile "ど", used in Status Ailment

	charmap "<ID>", $73
	charmap "№",    $74

; Actual characters (from other graphics files)

;	needed for ShowPokedexDataInternal (see engine/menus/pokedex.asm)
	charmap "m",  $60 ; gfx/pokedex/pokedex.png
	charmap "k",  $61 ; gfx/pokedex/pokedex.png
	charmap "g",  $62 ; gfx/pokedex/pokedex.png

;	needed for StatusScreen (see engine/pokemon/status_screen.asm)
	charmap "P",  $72 ; gfx/font/P.1bpp

;	needed for LoadTownMap_Fly (see engine/items/town_map.asm)
	charmap "▲",       $ed ; gfx/town_map/up_arrow.1bpp

;	needed for PrintAlphabet (see engine/menus/naming_screen.asm)
	charmap "<ED>",    $f0 ; gfx/font/ED.1bpp

; Actual characters (from gfx/font/font.png)

	charmap "ア",       $80
	charmap "イ",       $81
	charmap "ウ",       $82
	charmap "エ",       $83
	charmap "オ",       $84
	charmap "カ",       $85
	charmap "キ",       $86
	charmap "ク",       $87
	charmap "ケ",       $88
	charmap "コ",       $89
	charmap "サ",       $8a
	charmap "シ",       $8b
	charmap "ス",       $8c
	charmap "セ",       $8d
	charmap "ソ",       $8e
	charmap "タ",       $8f
	charmap "チ",       $90
	charmap "ツ",       $91
	charmap "テ",       $92
	charmap "ト",       $93
	charmap "ナ",       $94
	charmap "ニ",       $95
	charmap "ヌ",       $96
	charmap "ネ",       $97
	charmap "ノ",       $98
	charmap "ハ",       $99
	charmap "ヒ",       $9a
	charmap "フ",       $9b
	charmap "ヘ",       $cd ; graphic tile is identical to Hiragana へ
	charmap "ホ",       $9c
	charmap "マ",       $9d
	charmap "ミ",       $9e
	charmap "ム",       $9f
	charmap "メ",       $a0
	charmap "モ",       $a1
	charmap "ヤ",       $a2
	charmap "ユ",       $a3
	charmap "ヨ",       $a4
	charmap "ラ",       $a5
	charmap "リ",       $d8 ; graphic tile is identical to Hiragana り
	charmap "ル",       $a6
	charmap "レ",       $a7
	charmap "ロ",       $a8
	charmap "ワ",       $a9
	charmap "ヲ",       $aa
	charmap "ン",       $ab
	charmap "ッ",       $ac
	charmap "ャ",       $ad
	charmap "ュ",       $ae
	charmap "ョ",       $af
	charmap "ィ",       $b0  ; katakana small i

	charmap "あ",       $b1
	charmap "い",       $b2
	charmap "う",       $b3
	charmap "え",       $b4
	charmap "お",       $b5
	charmap "か",       $b6
	charmap "き",       $b7
	charmap "く",       $b8
	charmap "け",       $b9
	charmap "こ",       $ba
	charmap "さ",       $bb
	charmap "し",       $bc
	charmap "す",       $bd
	charmap "せ",       $be
	charmap "そ",       $bf
	charmap "た",       $c0
	charmap "ち",       $c1
	charmap "つ",       $c2
	charmap "て",       $c3
	charmap "と",       $c4
	charmap "な",       $c5
	charmap "に",       $c6
	charmap "ぬ",       $c7
	charmap "ね",       $c8
	charmap "の",       $c9
	charmap "は",       $ca
	charmap "ひ",       $cb
	charmap "ふ",       $cc
	charmap "へ",       $cd
	charmap "ほ",       $ce
	charmap "ま",       $cf
	charmap "み",       $d0
	charmap "む",       $d1
	charmap "め",       $d2
	charmap "も",       $d3
	charmap "や",       $d4
	charmap "ゆ",       $d5
	charmap "よ",       $d6
	charmap "ら",       $d7
	charmap "り",       $d8
	charmap "る",       $d9
	charmap "れ",       $da
	charmap "ろ",       $db
	charmap "わ",       $dc
	charmap "を",       $dd
	charmap "ん",       $de
	charmap "っ",       $df
	charmap "ゃ",       $e0
	charmap "ゅ",       $e1
	charmap "ょ",       $e2

	charmap "ー",       $e3
	charmap "゜",       $e4 ; handakuten
	charmap "゛",       $e5 ; dakuten

	charmap "？",       $e6
	charmap "！",       $e7
	charmap "。",       $e8

	charmap "ァ",        $e9 ; katakana small a
	charmap "ゥ",        $ea ; katakana small u
	charmap "ェ",        $eb ; katakana small e

	charmap "▷",       $ec
	charmap "▶",       $ed
	charmap "▼",        $ee
	charmap "♂",        $ef
	charmap "円",       $f0
	charmap "×",        $f1
	charmap "．",       $f2
	charmap "／",       $f3
	charmap "ォ",       $f4 ; katakana small o
	charmap "♀",        $f5

	charmap "０",       $f6
	charmap "１",       $f7
	charmap "２",       $f8
	charmap "３",       $f9
	charmap "４",       $fa
	charmap "５",       $fb
	charmap "６",       $fc
	charmap "７",       $fd
	charmap "８",       $fe
	charmap "９",       $ff
