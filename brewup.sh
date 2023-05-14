#!/bin/bash

# Set PATH to include necessary directories
PATH="/usr/local/bin:/usr/local/sbin:/Users/${USER}/.local/bin:/usr/bin:/usr/sbin:/bin:/sbin"

# Set variables for log and dump files
LOGDIR="$HOME/Library/Logs/Homebrew/dailybrew/$(date +%Y/%m)"
LOGFILE="$LOGDIR/$(date +%Y-%m-%d-%H%M%S).log"
DUMPFILE="$LOGDIR/$(date +%Y-%m-%d-%H%M%S).Brewfile"

# Set color variables for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET=$(tput sgr0)

# Function to print colored output
print_color() {
  local color=$1
  local message=$2
  printf "${color}${message}${RESET}\n"
  printf "$(date "+%Y-%m-%d %H:%M:%S") - %s\n" "$message" >> "$LOGFILE"
}

# Add Homebrew to PATH for Apple Silicon Macs
if [ "$(arch)" = "arm64" ]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# Install mas if it is not already installed
if ! command -v mas > /dev/null; then
  print_color "$BLUE" "Installing mas..."
  brew install mas -q >> "$LOGFILE" || print_color "$RED" "Mas Install Failed"
fi

# Create log directory if it does not exist
if [ ! -d "$LOGDIR" ]; then
  mkdir -p "$LOGDIR"
fi

# Run Brew Diagnostic
print_color "$YELLOW" "Running Brew Diagnotic..."
brew doctor >> "$LOGFILE" || print_color "$RED" "Brew Doctor Failed"
brew missing >> "$LOGFILE" || print_color "$RED" "Brew Missing Failed"
print_color "$GREEN" "Brew Diagnotic Finished."

# Update and clean up Homebrew packages
print_color "$YELLOW" "Running Updates..."
brew update >> "$LOGFILE" || print_color "$RED" "Brew Update Failed"
brew outdated >> "$LOGFILE" || print_color "$RED" "Brew Outdated Failed"
brew upgrade >> "$LOGFILE" || print_color "$RED" "Brew Upgrade Failed"
brew cleanup -s >> "$LOGFILE" || print_color "$RED" "Brew Cleanup Failed"
print_color "$GREEN" "Updates Finished."

# Update Mac App Store apps
print_color "$YELLOW" "Running Mac Store Updates..."
mas upgrade >> "$LOGFILE" || print_color "$RED" "Mac Store Upgrade Failed"
print_color "$GREEN" "Mac Store Updates Finished."

# Create Brewfile dump
brew bundle dump --force --file="$DUMPFILE" >> "$LOGFILE" || print_color "$RED" "Brew Bundle Dump Failed"

# Print final message and path to log directory
print_color "$GREEN" "All Updates & Cleanups Finnished"
print_color "$BLUE" "Daily brew report at '$LOGDIR/'"
