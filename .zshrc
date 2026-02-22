# Autocomplete
autoload -Uz compinit && compinit

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
setopt PROMPT_SUBST # Allow var substitutions in the prompt
zstyle ':vcs_info:git:*' formats '%F{yellow}%b%f'

# Set prompt
PROMPT='%F{cyan}%2~%f %B%F{yellow}%f%b  '
RPROMPT='${vcs_info_msg_0_}'

# Search history with currently entered text
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Aliases
alias intel="arch -x86_64"
alias ls='eza --icons'
alias cat='bat -pp'
alias config='/usr/bin/git --git-dir=$HOME/.benjicfg/ --work-tree=$HOME'
alias please="gum input --password | sudo -nS"
alias aeonctl='/Users/benji/code/aeonctl/aeonctl'
alias p=pnpm
alias gpo='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gf='git fetch --all'
alias ga='git add .'
alias gbd='git branch | cut -c 3- | gum choose --no-limit --header "delete branches" | xargs git branch -D'
alias gs='git status'

gc () {
  local msg
  msg=$(gum input --width 0 --char-limit 72 --placeholder "commit message") || return
  [[ -z $msg ]] && return
  git commit -m "$msg"
}

gb() {
  if [[ $# -gt 0 ]]; then
    git checkout "$@"
  else
    git branch | cut -c 3- | gum choose --header "checkout" | xargs git checkout
  fi
}

cdf () {
  finderPath=`osascript -e 'tell application "Finder"
    try
      set currentFolder to (folder of the front window as alias)
    on error
      set currentFolder to (path to desktop folder as alias)
    end try
    POSIX path of currentFolder
  end tell'`;
  cd "$finderPath"
}

simulator () {
  open -a Simulator --args -CurrentDeviceUDID "$(xcrun simctl list -v devices -j | jq '.devices[] | .[] | .udid + " " + .name' -r | gum choose | awk '{print $1}')"
}

# Version managers
if command -v fnm &>/dev/null
then
  eval "$(fnm env --use-on-cd)"
fi

if command -v mise &>/dev/null
then
  eval "$(mise activate)"
fi

# homebrew
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# adb
export ANDROID_HOME="/Users/$USER/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# go
export PATH="$PATH:$HOME/go/bin"

# gcloud
if [ -f '/Users/benji/.gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/benji/.gcloud/google-cloud-sdk/path.zsh.inc'; fi

# gpg
export GPG_TTY=$(tty)

# yarn
if command -v yarn &>/dev/null
then
  export PATH="$PATH:`yarn global bin`"
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/benji/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
