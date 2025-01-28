DisplayEffectiveness:
	ld a, [wDamageMultipliers]
	and $7F
	cp EFFECTIVE
	ret z
	ld hl, SuperEffectiveText
	jr nc, .done
	ld hl, NotVeryEffectiveText
.done
	jp PrintText

SuperEffectiveText:
	text "こうかは　ばつぐんだ！"
	prompt

NotVeryEffectiveText:
	text "こうかは　いまひとつの　ようだ"
	prompt
