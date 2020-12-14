BOTTLE_OUT ?= bin/bottle
BOTTLE_SRC ?= cli.cr
SYSTEM_BIN ?= /usr/local/bin

install: build
	cp $(BOTTLE_OUT) $(SYSTEM_BIN) && rm -f $(BOTTLE_OUT)*
build: shard
	crystal build $(BOTTLE_SRC) -o $(BOTTLE_OUT) --release
test: shard
	crystal spec
shard:
	shards build
clean:
	rm -f $(BOTTLE_OUT)* && rm -rf lib && rm -f shard.lock