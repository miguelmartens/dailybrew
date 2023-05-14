# DailyBrew Script

This script is a bash script that automates updating and cleaning up Homebrew packages, diagnosing Homebrew issues, updating Mac App Store apps, and creating a Brewfile dump. It is designed to be run daily to ensure that Homebrew packages are up-to-date and functioning properly.

## Requirements

* This script requires Homebrew to be installed on your macOS device.
* This script requires `mas` (Mac App Store) to be installed. If it is not already installed, the script will install it automatically.
* This script is designed to be run on Apple Silicon Macs, but can be run on Intel Macs as well.

## Installation

1. Copy the script into a file on your macOS device.
2. Make the file executable by running the command `chmod +x /path/to/script`.
3. Schedule the script to run daily using a tool like `cron` or `launchd`.

## Usage

Clone this repository to your machine.

```
git clone https://github.com/your-username/dailybrew.git
```

Navigate to the cloned repository.

```
cd dailybrew
```

Run the brewup.sh script to update and clean up your packages.

```
./brewup.sh
```

Alternatively, you can create a symbolic link to run the script from anywhere in the terminal.

```
ln -s ${PWD}/brewup.sh /usr/local/bin/brewup
```

This will allow you to run the script by simply typing brewup in the terminal.

## Explanation

When the script is run, it will perform the following actions:

1. Set necessary directories and variables
2. Add Homebrew to PATH for Apple Silicon Macs
3. Install mas if it is not already installed
4. Create a log directory if it does not exist
5. Run Brew Diagnostic
6. Update and clean up Homebrew packages
7. Update Mac App Store apps
8. Create Brewfile dump
9. Print final message and path to log directory

The output of the script will be printed to the console and saved to a log file located in `$HOME/Library/Logs/Homebrew/dailybrew/YYYY/MM/`.



## Disclaimer

This script is provided as-is and is not guaranteed to work on all systems. It is recommended that you review and understand the script before running it on your macOS device.