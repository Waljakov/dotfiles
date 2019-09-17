#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls='ls --color=auto'
alias battery-status='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E percentage'
PS1='[\u@\h \W]\$ '

alias dotfiles='/usr/bin/git --git-dir=/home/michar/.dotfiles/ --work-tree=/home/michar'

