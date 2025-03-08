#!/bin/bash

# Function to uninstall R packages
uninstall_r_packages() {
  Rscript -e "if (require('shiny')) remove.packages('shiny')"
  Rscript -e "if (require('pdftools')) remove.packages('pdftools')"
  Rscript -e "if (require('tcltk')) remove.packages('tcltk')"
}

# Function to uninstall dependencies on macOS
uninstall_macos_dependencies() {
  echo "Uninstalling dependencies on macOS..."
  
  # Uninstall R packages
  uninstall_r_packages

  # Uninstall R
  if command -v R &> /dev/null; then
    echo "Uninstalling R..."
    brew uninstall r
  fi
}

# Function to uninstall dependencies on Windows
uninstall_windows_dependencies() {
  echo "Uninstalling dependencies on Windows..."

  # Uninstall R packages
  uninstall_r_packages

  # Uninstall R
  if command -v R &> /dev/null; then
    echo "Uninstalling R..."
    choco uninstall r.project -y
  fi

  # Uninstall Chocolatey
  if command -v choco &> /dev/null; then
    echo "Uninstalling Chocolatey..."
    powershell -NoProfile -ExecutionPolicy Bypass -Command "choco uninstall chocolatey -y"
  fi
}

# Detect the operating system and uninstall dependencies accordingly
if [[ "$OSTYPE" == "darwin"* ]]; then
  uninstall_macos_dependencies
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
  uninstall_windows_dependencies
else
  echo "Unsupported operating system: $OSTYPE"
  exit 1
fi

echo "All necessary components have been uninstalled."