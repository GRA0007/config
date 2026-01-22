# Benji's config

Uses [this setup](https://news.ycombinator.com/item?id=11071754).

## Usage

### Setup

```sh
git clone --bare git@github.com:GRA0007/config.git $HOME/.benjicfg
alias config='/usr/bin/git --git-dir=$HOME/.benjicfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout
```

### Update files

```sh
config status
config add .zshrc
config commit -m "Update zsh config"
config push
```

## Required software

- [eza](https://github.com/eza-community/eza)
- [bat](https://github.com/sharkdp/bat)
- [gum](https://github.com/charmbracelet/gum)
