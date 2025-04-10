# ~/.zshrc

# Enable prompt substitution (so command substitutions in PROMPT are updated)
setopt PROMPT_SUBST

# Initialize the completion system for enhanced tab completion
autoload -Uz compinit && compinit

# Load the module that supports interactive, highlighted completion menus
# (Remove the -U flag if your shell complains)
zmodload zsh/complist

# Enable interactive menu selection for completions.
# When multiple completions are available, you can navigate them.
zstyle ':completion:*' menu select

# Load color definitions for use in the prompt
autoload -Uz colors && colors

prompt_git() {
  # Check if inside a Git repository.
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    return
  fi

  # Get the current branch name.
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  [ -z "$branch" ] && return

  # Check repository status. If there is any output from git status --porcelain,
  # it means there are uncommitted changes.
  if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
	  echo "(❌${branch})🌲 "
  else
    echo "(${branch})🌲 "
  fi
}

minimal_dir() {
  echo "${PWD/#$HOME/~}"
}

PROMPT='%{$fg_bold[blue]%}[ $(minimal_dir) ] %{$fg[yellow]%}$(prompt_git)%{$reset_color%}
%{$fg_bold[cyan]%}💀 👉 %{$reset_color%} '
RPROMPT='%{$fg[green]%}%D{%B %-d,%l.%M%P (%Y)}%{$reset_color%}'
#History configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

alias ll='ls -la'
alias compile="cc -Wall -Wextra -Werror"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$PATH:/home/zlee/.cargo/bin"

lg() {
  ~/lazygit/lazygit
}

# Created by `pipx` on 2025-01-24 14:29:36
export PATH="$PATH:/home/koichi/.local/bin"
eval "$(zoxide init zsh)"
alias clip="xclip -selection clipboard"
