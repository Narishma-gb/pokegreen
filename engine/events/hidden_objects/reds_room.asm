PrintRedSNESText:
	call EnableAutoTextBoxDrawing
	tx_pre_jump RedBedroomSNESText

RedBedroomSNESText::
	text "<PLAYER>は"
	line "ファミコンを　してる！"
	cont "<⋯>　<⋯>　よし！"
	cont "そろそろ　でかけよう！"
	done

OpenRedsPC:
	call EnableAutoTextBoxDrawing
	tx_pre_jump RedBedroomPCText

RedBedroomPCText::
	script_players_pc
