
.PHONY: all
all:

.PHONY: clean
clean:
	rm -rf target

.PHONY: test
test: target/test/multiLine.success

target/test/multiLine.success: examples/multiLine examples/multiLine.expected batl.sh
	mkdir -p `dirname "$@"`
	./batl.sh < "examples/multiLine" > "target/test/multiLine.out"
	cmp "target/test/multiLine.out" "examples/multiLine.expected"
	touch "$@"
