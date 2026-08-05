#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="${HOME}/.local/bin"
mkdir -p "${INSTALL_DIR}"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

is_installed() { command -v "$1" &>/dev/null; }

_ok()   { echo -e "${GREEN}✓${NC} $*"; }
_skip() { echo -e "${YELLOW}–${NC} $1 already installed, skipping"; }
_err()  { echo -e "${RED}✗${NC} $*" >&2; }

get_target() {
    local arch os
    arch=$(uname -m)
    os=$(uname -s)
    case "$os" in
        Linux)
            case "$arch" in
                x86_64)  echo "x86_64-unknown-linux-musl" ;;
                aarch64) echo "aarch64-unknown-linux-musl" ;;
                *) _err "Unsupported arch: $arch"; return 1 ;;
            esac ;;
        Darwin)
            case "$arch" in
                x86_64) echo "x86_64-apple-darwin" ;;
                arm64)  echo "aarch64-apple-darwin" ;;
                *) _err "Unsupported arch: $arch"; return 1 ;;
            esac ;;
        *) _err "Unsupported OS: $os"; return 1 ;;
    esac
}

# Download a binary from a GitHub release tar.gz and install to INSTALL_DIR.
# Usage: gh_install <owner/repo> <binary-name> <filename-pattern>
# Pattern supports {tag} and {target} placeholders.
gh_install() {
    local repo="$1" bin="$2" pattern="$3"
    local tag target url tmp

    tag=$(curl -sfL "https://api.github.com/repos/${repo}/releases/latest" \
        | grep '"tag_name"' \
        | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/')
    target=$(get_target)

    url="${pattern/\{tag\}/${tag}}"
    url="${url/\{target\}/${target}}"

    tmp=$(mktemp -d)
    trap 'rm -rf "${tmp}"' RETURN

    curl -fsSL "$url" -o "${tmp}/archive.tar.gz"
    tar -xzf "${tmp}/archive.tar.gz" -C "${tmp}"
    find "${tmp}" -name "$bin" -type f -exec install -m755 {} "${INSTALL_DIR}/${bin}" \;
}

# Run a GitHub release's install.sh via curl | sh.
# Usage: curl_install <url>
curl_install() {
    curl -fsSL "$1" | sh
}

# go install a module into INSTALL_DIR, if go is available.
# Usage: go_install <module-path@version>
go_install() {
    is_installed go || return 1
    GOBIN="${INSTALL_DIR}" go install "$1"
}

# Try cargo-binstall, then cargo, then a fallback function.
# Usage: try_install <binary> <crate-or-empty> <fallback-fn-or-empty>
try_install() {
    local bin="$1" crate="${2:-}" fallback="${3:-}"

    if is_installed "$bin"; then
        _skip "$bin"
        return
    fi

    echo "Installing $bin..."

    if [[ -n "$crate" ]]; then
        if is_installed cargo-binstall; then
            cargo binstall --no-confirm "$crate" && _ok "$bin (cargo-binstall)" && return
        fi
        if is_installed cargo; then
            cargo install "$crate" && _ok "$bin (cargo)" && return
        fi
    fi

    if [[ -n "$fallback" ]]; then
        "$fallback" && _ok "$bin (fallback)" && return
    fi

    _err "Could not install $bin — install cargo/cargo-binstall or refer to the Justfile for manual instructions"
    return 1
}

# --- Fallback installers ---

_install_uv() {
    curl_install "https://astral.sh/uv/install.sh"
}

_install_just() {
    curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh \
        | bash -s -- --to "${INSTALL_DIR}"
}

_install_typst() {
    gh_install "typst/typst" "typst" \
        "https://github.com/typst/typst/releases/download/{tag}/typst-{target}.tar.xz"
}

_install_typstyle() {
    gh_install "Enter-tainer/typstyle" "typstyle" \
        "https://github.com/Enter-tainer/typstyle/releases/download/{tag}/typstyle-{target}.tar.gz"
}

_install_tt() {
    gh_install "typst-community/tytanic" "tt" \
        "https://github.com/typst-community/tytanic/releases/download/{tag}/tt-{target}.tar.gz"
}

_install_gotpm() {
    if curl_install "https://github.com/npikall/gotpm/releases/latest/download/install.sh"; then
        return 0
    fi
    go_install "github.com/npikall/gotpm@latest"
}

_install_tpc() {
    gh_install "typst/package-check" "typst-package-check" \
        "https://github.com/typst/package-check/releases/download/{tag}/typst-package-check-{target}.tar.gz"
}

# --- Install all tools ---

try_install "typst"               "typst-cli"            "_install_typst"
try_install "typstyle"            "typstyle"             "_install_typstyle"
try_install "just"                "just"                 "_install_just"
try_install "uv"                  ""                     "_install_uv"
try_install "tt"                  "tytanic"              "_install_tt"
try_install "gotpm"               ""                     "_install_gotpm"
try_install "typst-package-check" "typst-package-check"  "_install_tpc"

echo ""
_ok "All done. Make sure ${INSTALL_DIR} is in your PATH."
