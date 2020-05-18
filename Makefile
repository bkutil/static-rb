TMPDIR = tmp

MRUBY = git@github.com:/mruby/mruby.git

MRUBY_SRC = $(TMPDIR)/mruby
MRUBY_BUILD = $(MRUBY_SRC)/build/host
MRBC = $(MRUBY_BUILD)/bin/mrbc
LIBMRUBY = $(MRUBY_BUILD)/lib/libmruby.a

PKGS = git-core musl-dev upx-ucl build-essential bison ruby

static: $(TMPDIR)/mrb_bytecode.c mrb_wrapper.c
	musl-gcc -std=c99 -static -I$(MRUBY_SRC)/include -I$(TMPDIR) mrb_wrapper.c $(LIBMRUBY) -o $@
	strip -g $@
	upx -7 $@

$(TMPDIR)/mrb_bytecode.c: $(MRBC) static.rb
	$(MRBC) -Bmrb_bytecode -o $(TMPDIR)/mrb_bytecode.c static.rb

$(MRBC): $(MRUBY_SRC) $(MRUBY_SRC)/build_config.rb
	@cd $(MRUBY_SRC) && CC=musl-gcc make

$(MRUBY_SRC)/build_config.rb: build_config.rb.in
	cp -v $^ $@

$(MRUBY_SRC): install-deps
	[ -d $@ ] || git clone ${MRUBY} $@
	@cd $@ && git checkout -B 2.1.0

# Assumes Ubuntu bionic
install-pkgs:
	sudo apt -y install ${PKGS}

clean:
	rm -fvr $(TMPDIR) static

.PHONY: install-deps clean
