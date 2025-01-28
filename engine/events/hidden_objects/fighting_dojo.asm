PrintFightingDojoText2:
	call EnableAutoTextBoxDrawing
	tx_pre_jump EnemiesOnEverySideText

EnemiesOnEverySideText::
	text "しめん　そか"
	done

PrintFightingDojoText3:
	call EnableAutoTextBoxDrawing
	tx_pre_jump WhatGoesAroundComesAroundText

WhatGoesAroundComesAroundText::
	text "いんが　おうほう"
	done

PrintFightingDojoText:
	call EnableAutoTextBoxDrawing
	tx_pre_jump FightingDojoText

FightingDojoText::
	text "かくとう　どうじょう！"
	done
