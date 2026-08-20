#####################################
# Pie: PHP Installer for Extensions #
#####################################

BIN_DIR    := bin
PIE_BIN    := $(BIN_DIR)/phpenv-pie
RELEASE_URL := https://api.github.com/repos/php/pie/releases/latest

UNAME_S := $(shell uname -s)
UNAME_M := $(shell uname -m)

ifeq ($(UNAME_S),Linux)
PIE_OS := Linux
else ifeq ($(UNAME_S),Darwin)
PIE_OS := macOS
else
PIE_OS := unsupported
endif

ifeq ($(UNAME_M),x86_64)
PIE_ARCH := X64
else ifeq ($(filter $(UNAME_M),arm64 aarch64),$(UNAME_M))
PIE_ARCH := ARM64
else
PIE_ARCH := unsupported
endif

PIE_ASSET := pie-$(PIE_OS)-$(PIE_ARCH)

.PHONY: all install check clean

all: check
	@echo "Detected platform: $(UNAME_S)/$(UNAME_M) -> release asset $(PIE_ASSET)"

check:
	@command -v curl >/dev/null 2>&1 || { echo '"curl" is not installed' >&2; exit 1; }
	@command -v jq >/dev/null 2>&1 || { echo '"jq" is not installed' >&2; exit 1; }
	@[ "$(PIE_OS)" != "unsupported" ] || { echo "Unsupported OS: $(UNAME_S)" >&2; exit 1; }
	@[ "$(PIE_ARCH)" != "unsupported" ] || { echo "Unsupported architecture: $(UNAME_M)" >&2; exit 1; }

install: check
	@echo "Downloading PIE ($(PIE_ASSET))..."
	@url="$$(curl -Ls "$(RELEASE_URL)" | jq -r '.assets[] | select(.name == "$(PIE_ASSET)") | .browser_download_url')"; \
	[ -n "$$url" ] || { echo "No PIE release asset found for $(PIE_ASSET)" >&2; exit 1; }; \
	curl -#Lo "$(PIE_BIN)" "$$url"
	@chmod +x "$(PIE_BIN)"
	@echo "Installation complete, you can now run 'phpenv pie'"

clean:
	rm -f "$(PIE_BIN)"
