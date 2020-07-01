alias subl='subl3'
alias vim='nvim'
alias dotfiles='/usr/bin/git --git-dir=/home/michar/.cfg/ --work-tree=/home/michar'
alias yayfind='yay -Slq | fzf --multi --preview "yay -Si {1}" | xargs -ro yay -S'
set -gx EDITOR nvim
set -gx SHELL /usr/bin/fish
set -gx XDG_CONFIG_HOME ~/.config
set -gx TERM alacritty
set -gx TERMINAL alacritty
