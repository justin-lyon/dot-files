# $HOME/.bashrc

# Custom Aliases
function touchp() {
  mkdir -p "$(dirname "$1")/" && touch "$1"
}

function gac() {
  git add . && git commit -m "$@"
}

# get Git Branch in from current working directory
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Colorize Terminal and add git branch
# export DEFAULT_PS1="[\u@\h \W]\[\033[00;32m\]\$(git_branch)\[\033[00m\]\$ "
# export FULL_COLOR="[\[\e[01;33m\]\u\[\e[00m\]@\[\e[01;33m\]\h\[\e[00m\] \[\033[01;34m\]\W\[\033[00m\]]\[\033[00;32m\]\$(git_branch)\[\033[00m\]\$ "
export PS1="[\u\[\e[01;33m\]@\[\e[00m\]\h \[\033[01;34m\]\W\[\033[00m\]]\[\033[00;32m\]\$(git_branch)\[\033[00m\]\$ "

# Windows 10 ssh-agent Setup
# Automatically add ssh keys to ssh-agent when git bash starts on windows.
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

add_keys () {
    # Add each key to ssh agent here.
    ssh-add ~/.ssh/[private-key1-placeholder]
    ssh-add ~/.ssh/[private-key2-placeholder]
}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    add_keys
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    add_keys
fi

unset env
