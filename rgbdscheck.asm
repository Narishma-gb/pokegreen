IF !DEF(__RGBDS_MAJOR__) || !DEF(__RGBDS_MINOR__) || !DEF(__RGBDS_PATCH__)
	FAIL "pokegreen requires rgbds v0.9.2 or newer."
ENDC
IF __RGBDS_MAJOR__ == 0 && (__RGBDS_MINOR__ < 9 || (__RGBDS_MINOR__ == 9 && __RGBDS_PATCH__ < 2))
	FAIL "pokegreen requires rgbds v0.9.2 or newer."
ENDC
