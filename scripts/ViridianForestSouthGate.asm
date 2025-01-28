ViridianForestSouthGate_Script:
	jp EnableAutoTextBoxDrawing

ViridianForestSouthGate_TextPointers:
	def_text_pointers
	dw_const ViridianForestSouthGateGirlText,       TEXT_VIRIDIANFORESTSOUTHGATE_GIRL
	dw_const ViridianForestSouthGateLittleGirlText, TEXT_VIRIDIANFORESTSOUTHGATE_LITTLE_GIRL

ViridianForestSouthGateGirlText:
	text "トキワの　もりへ　いくの？"
	line "もりは　てんねんの　めいろよ"
	cont "まよわないよう　きを　つけて"
	done

ViridianForestSouthGateLittleGirlText:
	text "コラッタは　ちっちゃい　けど"
	line "まえばの　いちげきは　あなどれない"
	cont "もう　つかまえた　かしら？"
	done
