STDLIB_DIR := ../stdlib_ml
PPX := -ppx ../monad_ppx.byte
LIBDIRS := lib $(STDLIB_DIR)
LIBS := $(PPX) $(foreach lib,$(LIBDIRS),-I $(lib))
REPLACE_STDLIB := -nopervasives -nostdlib -open Stdlib
LINK_LIBS := $(STDLIB_DIR)/stdlib.cmo lib/mocha.cmo

TESTS := $(wildcard *.ml)
TESTS_JS := $(patsubst %.ml,%.unlog.as.js,$(TESTS))

test: test_ml test_js
	$(MAKE) -k _run_test

_run_test: run_test_ml run_test_js

run_test_ml:
	@./test_ml

test_ml: $(LINK_LIBS) $(patsubst %.ml,%.cmo,$(TESTS)) | lib/mocha.cmi
	ocamlfind ocamlc -package alcotest -linkpkg -g $(LIBS) $^ -o $@

run_test_js: $(TESTS_JS)
	@echo -e "\n*** Testing JS-generated tests ***\n"
	@../../node_modules/mocha/bin/mocha -R list $^

test_js: $(TESTS_JS)

.SECONDEXPANSION: # Start seconday expansion from here. Cannot be moved after any $$ variables.

# Explicit dependencies (must go before rules to build these targets)
shadow.cmo: shadow_include.cmo
shadow.unlog.as.js: shadow_include.unlog.js

# Pattern rules
%.unlog.js: %.ml ../main.byte ../monad_ppx.byte
	../main.byte -mode unlog $(LIBS) $<

%.log.js: %.ml ../main.byte ../monad_ppx.byte
	../main.byte -mode log $(LIBS) $<

%.token.js: %.ml ../main.byte ../monad_ppx.byte
	../main.byte -mode token $(LIBS) $<

# $$^ expands to all previously defined dependencies for the given file
%.as.js: $(patsubst %.cmo,%.js,$(LINK_LIBS)) Compare.js $$^ %.js
	../assembly.byte -o $@ $^

lib/mocha.cmi: lib/mocha.mli
	ocamlfind ocamlc -package alcotest -c $< -o $@

lib/mocha.cmo: lib/mocha.ml lib/mocha.cmi
	ocamlfind ocamlc -package alcotest -c -I lib $< -o $@

%.cmo: %.ml
	ocamlc -c -g $(REPLACE_STDLIB) $(LIBS) $< -o $@

clean:
	rm -rf *.cmi *.cmo test_ml _build lib/*.cmi lib/*cmo *.unlog.js *.log.js *.token.js *.as.js

.PRECIOUS: %.js %.unlog.js
.NOTPARALLEL:
