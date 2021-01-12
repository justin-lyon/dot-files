# $HOME/.bashrc

# Custom Aliases
function touchp() {
  mkdir -p "$(dirname "$1")/" && touch "$1"
}

# Display Git Branch in Terminal
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Colorize Terminal
# export DEFAULT_PS1="[\u@\h \W]\[\033[00;32m\]\$(git_branch)\[\033[00m\]\$ "
# export FULL_COLOR="[\[\e[01;33m\]\u\[\e[00m\]@\[\e[01;33m\]\h\[\e[00m\] \[\033[01;34m\]\W\[\033[00m\]]\[\033[00;32m\]\$(git_branch)\[\033[00m\]\$ "
export PS1="[\u\[\e[01;33m\]@\[\e[00m\]\h \[\033[01;34m\]\W\[\033[00m\]]\[\033[00;32m\]\$(git_branch)\[\033[00m\]\$ "