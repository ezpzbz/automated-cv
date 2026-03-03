.PHONY: test build all

test:
	./scripts/test.sh

build:
	RESUME_TEX=$(RESUME_TEX) ./scripts/build.sh

all: test build
