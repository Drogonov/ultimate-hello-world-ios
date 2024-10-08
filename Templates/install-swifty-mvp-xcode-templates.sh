#!/usr/bin/env sh

# Configuration
XCODE_TEMPLATE_DIR=$HOME'/Library/Developer/Xcode/Templates/File Templates/Tools'
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

VER_FILE=$(find "$XCODE_TEMPLATE_DIR" -name version.txt)
TEMPLATES_VER=$(grep ver $SCRIPT_DIR'/version.txt')

# Copy templates into the local template directory
xcodeTemplate () {
  echo "==> Copying up Xcode file templates..."

  if [ -d "$XCODE_TEMPLATE_DIR" ]; then
    rm -R "$XCODE_TEMPLATE_DIR"
  fi
  mkdir -p "$XCODE_TEMPLATE_DIR"

  cp -R $SCRIPT_DIR/* "$XCODE_TEMPLATE_DIR"
}

if grep $TEMPLATES_VER "$VER_FILE"
then
  echo "Templates has actual version"
else
  xcodeTemplate
  echo "==> ... success!"
  echo "==> Templates have been set up. In Xcode, select 'New File...' to use templates."
fi
