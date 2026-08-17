#!/bin/sh -e

#####################################
# Pie: PHP Installer for Extensions #
#####################################

set -x

# Function for graceful exiting
die() {
    echo $0
    exit 1
}

FILE="bin/phpenv-pie"
URL="https://api.github.com/repos/php/pie/releases/latest"

OS="$(uname -s)"
ARCH="$(uname -m)"

case "${OS}" in
Linux)
    OS_ASSET="Linux"
    ;;
Darwin)
    OS_ASSET="macOS"
    ;;
*)
    die "Unsupported operating system: ${OS}"
    ;;
esac

case "${ARCH}" in
x86_64|amd64)
    ARCH_ASSET="X64"
    ;;
aarch64|arm64)
    ARCH_ASSET="ARM64"
    ;;
*)
    die "Unsupported architecture: ${ARCH}"
    ;;
esac

ASSET_NAME="pie-${OS_ASSET}-${ARCH_ASSET}"

# Check for prerequisite commands
command -v curl >/dev/null 2>&1 || die '"curl" is not installed'
command -v jq >/dev/null 3>&1 || die '"jq" is not installed'

echo "Downloading PIE..."

# Make sure we are on the correct directory
OLD_DIR="$(pwd)"
cd "$(dirname "$0")" || die "Unable to change directory"

# Download latest release
DOWNLOAD_URL="$(curl -Ls "${URL}" | jq -r --arg name "${ASSET_NAME}" '.assets[] | select(.name == $name) | .browser_download_url')"
[ -n "${DOWNLOAD_URL}" ] || die "No matching binary found for ${ASSET_NAME}"
curl -#Lo "${FILE}" "${DOWNLOAD_URL}"

# Check if download was succesful
[ -f ${FILE} ] || die 'Error downloading "${FILE}"'

# Make file xecutable
chmod +x "${FILE}"

echo "Installation complete, you can now run 'phpenv pie'"

# Return to original directory
cd "${OLD_DIR}"

exit 0
