# dotfiles

Here is how I would usually setup my new Ubuntu system from scratch. Here is what i would typically install
 - Install Wezterm and configure it to only run Ubuntu.
 - Install Homebrew
  - Install libmd-dev, libbsd0 & libbsd-dev (based on ubuntu release)
- Install gcc, and man-db from Homebrew
- Install zsh and Setup oh-my-zsh.
 - Setup pipx.
 - Setup NVM for zsh.
  - Lastly, clone nvim config.

## Default configuration for oh-my-zsh
```shell
# Homebrew GCC configuration
# Homebrew configuration
if [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -x "$HOME/.linuxbrew/bin/brew" ]; then
    eval "$($HOME/.linuxbrew/bin/brew shellenv)"
else
    echo "Homebrew not found. Please check your installation."
fi

# GCC configuration (if installed via Homebrew)
if command -v brew &>/dev/null; then
    gcc_path="$(brew --prefix gcc 2>/dev/null)/bin"
    if [ -d "$gcc_path" ]; then
        export PATH="$gcc_path:$PATH"
		alias gcc="$(brew --prefix gcc)/bin/gcc-14"
		alias cc="$(brew --prefix gcc)/bin/gcc-14"
    else
        echo "GCC installation not found via Homebrew. Please install GCC using Homebrew."
    fi
else
    echo "Homebrew not found in PATH. GCC configuration skipped."
fi

# ... (rest of your previous configuration)
# Homebrew shell environment (only need to run once)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# pipx path addition
export PATH="$PATH:/home/$USER/.local/bin"

# ghcup environment
[ -f "/home/$USER/.ghcup/env" ] && source "/home/$USER/.ghcup/env"

# NVM (Node Version Manager) configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

Rest of the dotfiles will be on the repo.

## Dotfiles for BSPWM coming soon
pulseaudio, picom (from git), dmenu, xdotool, brightnessctl, auto-cpufreq, polybar, rofi, nitrogen, and more.....



