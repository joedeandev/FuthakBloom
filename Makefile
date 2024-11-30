ROOT?="./app"
BOARD?="nice_nano_v2"
CONFIG?="../config"
BUILD?="build/futhak-bloom"
DSHIELD?="lily58_left"
DEST?=".."
NAME?="futhak-bloom"
PRISTINE?="--pristine"

west-setup:
	python -m venv .venv && \
	source .venv/bin/activate && \
	west init && \
	west update
build-base:
	cd $(ROOT) && \
	west build -d $(BUILD) -b $(BOARD) $(PRISTINE) -- -DSHIELD=$(DSHIELD) -DZMK_CONFIG=$(CONFIG) && \
	cp $(BUILD)/zephyr/zmk.uf2 $(DEST)/$(NAME).uf2
build-left:
	$(MAKE) build-base BUILD=build/left DSHIELD=lily58_left NAME=futhak-bloom-left
build-right:
	$(MAKE) build-base BUILD=build/right DSHIELD=lily58_right NAME=futhak-bloom-right
build-reset-left:
	$(MAKE) build-base BUILD=build/left-reset DSHIELD=settings_reset NAME=futhak-bloom-left-reset
build-reset-right:
	$(MAKE) build-base BUILD=build/right-reset DSHIELD=settings_reset NAME=futhak-bloom-right-reset
build-both: build-left build-right
build-reset-both: build-reset-left build-reset-right
build: build-both build-reset-both
