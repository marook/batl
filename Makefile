PREFIX=/usr/local

.PHONY: all
all:

.PHONY: clean
clean:
	rm -rf target

.PHONY: test
test: target/test/multiLine.success target/test/multipleExpressions.success

.PHONY: install
install: $(PREFIX)/bin/batl

target/test/multiLine.success: examples/multiLine examples/multiLine.expected batl.sh
	mkdir -p `dirname "$@"`
	./batl.sh < "examples/multiLine" > "target/test/multiLine.out"
	cmp "target/test/multiLine.out" "examples/multiLine.expected"
	touch "$@"

target/test/multipleExpressions.success: examples/multipleExpressions examples/multipleExpressions.expected batl.sh
	mkdir -p `dirname "$@"`
	./batl.sh < "examples/multipleExpressions" > "target/test/multipleExpressions.out"
	cmp "target/test/multipleExpressions.out" "examples/multipleExpressions.expected"
	touch "$@"

$(PREFIX)/bin/batl: batl.sh
	install "$^" "$@"
