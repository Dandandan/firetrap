.PHONY: help
help: # Show available `make` commands
	@echo 'Available `make` commands:' >/dev/stderr
	@echo >/dev/stderr
	@awk -F'#' '/^[a-z][A-Za-z0-9]+/ {if (NF > 1) { sub(/:[^#]*/, ""); print $$1 "\t\t" $$2}}' Makefile

.PHONY: watch
watch: # Continuously run `cargo check` and `cargo test` on file changes
	cargo watch -x check -x "test --all-features" --clear

.PHONY: test
test: # Run all tests
	cargo test --all-features

.PHONY: fuzz
fuzz: # Run fuzzing tests
	cargo +nightly fuzz run parse_command

.PHONY: run
run: debug # Run the `basic` example in verbose mode
	RUST_LOG=INFO ./target/debug/examples/basic

.PHONY: doc
doc: # Open the API docs in the browser
	cargo doc --open

.PHONY: debug
debug: # Create a debug build
	cargo build

.PHONY: build
build: # Create a release build
	cargo build --release
