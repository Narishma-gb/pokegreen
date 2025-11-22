roms := \
	pokered.gb \
	pokegreen.gb \
	pokered11.gb \
	pokegreen11.gb
patches := \
	pokered11.patch \
	pokegreen11.patch

rom_obj := \
	audio.o \
	garbage.o \
	home.o \
	main.o \
	maps.o \
	ram.o \
	gfx/pics.o \
	gfx/sprites.o \
	gfx/tilesets.o

pokered_obj        := $(rom_obj:.o=_red.o)
pokegreen_obj      := $(rom_obj:.o=_green.o)
pokered11_obj      := $(rom_obj:.o=_red11.o)
pokegreen11_obj    := $(rom_obj:.o=_green11.o)
pokered11_vc_obj   := $(rom_obj:.o=_red11_vc.o)
pokegreen11_vc_obj := $(rom_obj:.o=_green11_vc.o)


### Build tools

ifeq (,$(shell command -v sha1sum 2>/dev/null))
SHA1 := shasum
else
SHA1 := sha1sum
endif

RGBDS ?=
RGBASM  ?= $(RGBDS)rgbasm
RGBFIX  ?= $(RGBDS)rgbfix
RGBGFX  ?= $(RGBDS)rgbgfx
RGBLINK ?= $(RGBDS)rgblink

RGBASMFLAGS  ?= -Weverything -Wtruncation=1
RGBLINKFLAGS ?= -Weverything -Wtruncation=1
RGBFIXFLAGS  ?= -Weverything
RGBGFXFLAGS  ?= -Weverything


### Build targets

.SUFFIXES:
.SECONDEXPANSION:
.PRECIOUS:
.SECONDARY:
.PHONY: \
	all \
	red \
	green \
	red11 \
	green11 \
	red11_vc \
	green11_vc \
	clean \
	tidy \
	compare \
	tools

all: $(roms)
red:        pokered.gb
green:      pokegreen.gb
red11:      pokered11.gb
green11:    pokegreen11.gb
red11_vc:   pokered11.patch
green11_vc: pokegreen11.patch

clean: tidy
	find gfx \
	     \( -iname '*.1bpp' \
	        -o -iname '*.2bpp' \
	        -o -iname '*.pic' \) \
	     -delete

tidy:
	$(RM) $(roms) \
	      $(roms:.gb=.sym) \
	      $(roms:.gb=.map) \
	      $(patches) \
	      $(patches:.patch=_vc.gb) \
	      $(patches:.patch=_vc.sym) \
	      $(patches:.patch=_vc.map) \
	      $(patches:%.patch=vc/%.constants.sym) \
	      $(pokered_obj) \
	      $(pokegreen_obj) \
	      $(pokered11_obj) \
	      $(pokegreen11_obj) \
	      $(pokered11_vc_obj) \
	      $(pokegreen11_vc_obj) \
	      rgbdscheck.o
	$(MAKE) clean -C tools/

compare: $(roms) $(patches)
	@$(SHA1) -c roms.sha1

tools:
	$(MAKE) -C tools/


RGBASMFLAGS += -Q8 -P includes.asm
# Create a sym/map for debug purposes if `make` run with `DEBUG=1`
ifeq ($(DEBUG),1)
RGBASMFLAGS += -E
endif

$(pokered_obj):        RGBASMFLAGS += -D _RED -D _REV0
$(pokegreen_obj):      RGBASMFLAGS += -D _GREEN -D _REV0
$(pokered11_obj):      RGBASMFLAGS += -D _RED -D _REV1
$(pokegreen11_obj):    RGBASMFLAGS += -D _GREEN -D _REV1
$(pokered11_vc_obj):   RGBASMFLAGS += -D _RED -D _REV1 -D _RED_VC
$(pokegreen11_vc_obj): RGBASMFLAGS += -D _GREEN -D _REV1 -D _GREEN_VC

%.patch: %_vc.gb %.gb vc/%.patch.template
	tools/make_patch $*_vc.sym $^ $@

rgbdscheck.o: rgbdscheck.asm
	$(RGBASM) -o $@ $<

# Build tools when building the rom.
# This has to happen before the rules are processed, since that's when scan_includes is run.
ifeq (,$(filter clean tidy tools,$(MAKECMDGOALS)))

$(info $(shell $(MAKE) -C tools))

# The dep rules have to be explicit or else missing files won't be reported.
# As a side effect, they're evaluated immediately instead of when the rule is invoked.
# It doesn't look like $(shell) can be deferred so there might not be a better way.
preinclude_deps := includes.asm $(shell tools/scan_includes includes.asm)
define DEP
$1: $2 $$(shell tools/scan_includes $2) $(preinclude_deps) | rgbdscheck.o
	$$(RGBASM) $$(RGBASMFLAGS) -o $$@ $$<
endef

# Dependencies for objects (drop _red and _green from asm file basenames)
$(foreach obj, $(pokered_obj), $(eval $(call DEP,$(obj),$(obj:_red.o=.asm))))
$(foreach obj, $(pokegreen_obj), $(eval $(call DEP,$(obj),$(obj:_green.o=.asm))))
$(foreach obj, $(pokered11_obj), $(eval $(call DEP,$(obj),$(obj:_red11.o=.asm))))
$(foreach obj, $(pokegreen11_obj), $(eval $(call DEP,$(obj),$(obj:_green11.o=.asm))))
$(foreach obj, $(pokered11_vc_obj), $(eval $(call DEP,$(obj),$(obj:_red11_vc.o=.asm))))
$(foreach obj, $(pokegreen11_vc_obj), $(eval $(call DEP,$(obj),$(obj:_green11_vc.o=.asm))))

endif


RGBLINKFLAGS += -d -p 0

RGBFIXFLAGS += -sv -k 01 -l 0x33 -m MBC1+RAM+BATTERY -r 03 -p 0
pokered.gb:        RGBFIXFLAGS += -n 0 -t "POKEMON RED"
pokegreen.gb:      RGBFIXFLAGS += -n 0 -t "POKEMON GREEN"
pokered11.gb:      RGBFIXFLAGS += -n 1 -t "POKEMON RED"
pokegreen11.gb:    RGBFIXFLAGS += -n 1 -t "POKEMON GREEN"
pokered11_vc.gb:   RGBFIXFLAGS += -n 1 -t "POKEMON RED"
pokegreen11_vc.gb: RGBFIXFLAGS += -n 1 -t "POKEMON GREEN"

%.gb: $$(%_obj) layout.link
	$(RGBLINK) $(RGBLINKFLAGS) -l layout.link -m $*.map -n $*.sym -o $@ $(filter %.o,$^)
	$(RGBFIX) $(RGBFIXFLAGS) $@


### Misc file-specific graphics rules

gfx/battle/move_anim_0.2bpp: tools/gfx += --trim-whitespace
gfx/battle/move_anim_1.2bpp: tools/gfx += --trim-whitespace

gfx/intro/rg_nidorino_1.2bpp: RGBGFXFLAGS += --columns
gfx/intro/rg_nidorino_2.2bpp: RGBGFXFLAGS += --columns
gfx/intro/rg_nidorino_3.2bpp: RGBGFXFLAGS += --columns
gfx/intro/gengar.2bpp: RGBGFXFLAGS += --columns
gfx/intro/gengar.2bpp: tools/gfx += --remove-duplicates --preserve=0x19,0x76

gfx/credits/the_end.2bpp: tools/gfx += --interleave --png=$<

gfx/slots/red_slots_1.2bpp: tools/gfx += --trim-whitespace
gfx/slots/green_slots_1.2bpp: tools/gfx += --trim-whitespace

gfx/tilesets/%.2bpp: tools/gfx += --trim-whitespace
gfx/tilesets/reds_house.2bpp: tools/gfx += --preserve=0x48

gfx/trade/game_boy.2bpp: tools/gfx += --remove-duplicates


### Catch-all graphics rules

%.2bpp: %.png
	$(RGBGFX) --colors dmg $(RGBGFXFLAGS) -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) -o $@ $@ || $$($(RM) $@ && false))

%.1bpp: %.png
	$(RGBGFX) --colors dmg $(RGBGFXFLAGS) --depth 1 -o $@ $<
	$(if $(tools/gfx),\
		tools/gfx $(tools/gfx) --depth 1 -o $@ $@ || $$($(RM) $@ && false))

%.pic: %.2bpp
	tools/pkmncompress $< $@


### File extensions that are never generated and should be manually created

%.asm: ;
%.inc: ;
%.png: ;
%.pal: ;
%.bin: ;
%.blk: ;
%.bst: ;
%.rle: ;
