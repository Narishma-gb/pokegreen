CinnabarMart_Script:
	jp EnableAutoTextBoxDrawing

CinnabarMart_TextPointers:
	def_text_pointers
	dw_const CinnabarMartClerkText,        TEXT_CINNABARMART_CLERK
	dw_const CinnabarMartSilphWorkerFText, TEXT_CINNABARMART_SILPH_WORKER_F
	dw_const CinnabarMartScientistText,    TEXT_CINNABARMART_SCIENTIST

CinnabarMartSilphWorkerFText:
	text "プラスパワーは　ないのかしら"
	line "#の　こうげきりょくを"
	cont "たかめるから　すきなのに"
	done

CinnabarMartScientistText:
	text "いざ　という　ときの　ために"
	line "どうぐは　おおめに　かうべきだね"
	done
