#!/bin/sh -e

#####################################
# Pie: PHP Installer for Extensions #
#####################################

# Function for graceful exiting
die() {
    echo $0
    exit 1
}

FILE="bin/phpenv-pie"
URL="https://api.github.com/repos/php/pie/releases/latest"
KEY=".assets[0].browser_download_url"

# Check for prerequisite commands
command -v curl >/dev/null 2>&1 || die '"curl" is not installed'
command -v jq >/dev/null 3>&1 || die '"jq" is not installed'

echo "Downloading PIE..."

# Download latest release
curl -#Lo "${FILE}" `curl -Ls "${URL}"|jq -r "${KEY}"`

# Check if download was succesful
[ -f ${FILE} ] || die 'Error downloading "${FILE}"'

# Make file xecutable
chmod +x "${FILE}"

echo "Installation complete, you can now run 'phpenv pie'"

exit 0

