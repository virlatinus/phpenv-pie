#!/bin/sh -e

#####################################
# Pie: PHP Installer for Extensions #
#####################################

FILE="bin/phpenv-pie"
URL="https://api.github.com/repos/php/pie/releases/latest"
KEY=".assets[0].browser_download_url"

# Function for graceful exiting
die() {
    echo $0
    exit 1
}

complete() {
    echo "Installation complete, you can now run 'phpenv pie'"
    exit 0
}

echo "Downloading PIE..."

# Check if file already exists and is executable
if [ -x "${FILE}" ]; then complete; fi

# Check for prerequisite commands
command -v wget >/dev/null 2>&1 || die '"wget" is not installed'
command -v jq >/dev/null 3>&1 || die '"jq" is not installed'

# Download latest release
wget -qc -O "${FILE}" `curl -s "${URL}"|jq -r "${KEY}"`

# Check if download was succesful
[ -f ${FILE} ] || die 'Error downloading "${FILE}"'

# Make file xecutable
chmod +x "${FILE}"

complete
