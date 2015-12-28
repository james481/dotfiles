project_home=$HOME/projects # Root directory for all projects

function whatproject # Determine the current project name
{
  echo $(pwd | sed s@$project_home/@@ | sed s@/.*@@)
}

alias gs='git status'
alias gp='git pull --all'
alias gc='git checkout'
alias gd='git diff'
alias ga='git add -A'
alias gb='git branch'
alias gcl='git log --format="%s
%b"'
alias v='vim'
alias vup='vagrant up'
alias vdown='vagrant suspend'
alias vstat='vagrant global-status'
alias vssh='vagrant ssh'

function cdp
{
  project=${1:-$(whatproject)}
  cd ~/projects/$project
}

function rbsdb
{
  project=${1:-$(whatproject)}
  pushd ~/projects/$project
  php app/console doctrine:database:drop --force
  php app/console doctrine:database:create
  php app/console doctrine:schema:create
  php app/console doctrine:fixtures:load
  popd
}

function newlog
{
  project=${1:-$(whatproject)}
  pushd ~/projects/$project/app/logs
  rm -f ./dev.log
  touch ./dev.log
  tail -f dev.log
}

function scon
{
  project=$(whatproject)
  pushd ~/projects/$project/app > /dev/null
  php console $1
  popd > /dev/null
}

# Server aliases

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
