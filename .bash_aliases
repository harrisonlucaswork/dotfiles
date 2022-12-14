# User specific aliases and functions
alias cdmcp='cd /mnt/mlp/mcp'
alias cdplats='cd /mnt/mlp/platformschema'
alias cdr='cd /mnt/mlp/release'
alias cdrscript='cd /mnt/mlp/scripts/release'
alias cddb='cd /mnt/mlp/libs/DataObjects'
alias cdt='cd /mnt/mlp/platform/tests'
alias cdplat='cd /mnt/mlp/platform'
alias k='kubectl'
alias n='nerdctl'
alias cdcon='cd ~/mlp/mlp-containers'

#GIT
alias gundo='git reset --soft HEAD^ && git reset'
alias gcommit='git commit -a -m '
alias ghistory='less .git/logs/HEAD'
alias gco='git checkout '
alias gs='git status'
alias gd='git diff'
alias gl='git log -p -c'
alias gtree='git log --graph --pretty=format:"%C(yellow)%h%Creset%C(blue)%d%Creset %C(white bold)%s%Creset %C(white dim)(by %an %ar)%Creset" --all'
alias glog='git log --graph --pretty=format:"%C(yellow)%h%Creset%C(blue)%d%Creset %C(white bold)%s%Creset %C(white dim)(by %an %ar)%Creset" --abbrev-commit'
alias gbranch='git log --graph --pretty=format:"%C(yellow)%h%Creset%C(blue)%d%Creset %C(white bold)%s%Creset %C(white dim)(by %an %ar)%Creset" --branches'
alias gam='git am -3'
alias gref='git reflog --date=local'
alias lucaschown='sudo chown -R lucas:lucas ./* && sudo chown -R lucas:lucas ./.git/*'
alias lucaschownmlp='sudo chown -R lucas:lucas /mnt/mlp/*'
alias hooksdisable='mv /mnt/mlp/platform/.git/hooks /mnt/mlp/platform/.git/hooks-bk'
alias hooksenable='mv /mnt/mlp/platform/.git/hooks-bk /mnt/mlp/platform/.git/hooks'
alias expire_file='sudo touch -d "5 years ago" $@'
#DB
m () { mysql --defaults-file=/mnt/mlp/config/mysql/root.cnf --prompt="\u@\h [\d]> " $@ ;}
mr () { mysql --defaults-file=/mnt/mlp/config/mysql/root.cnf --prompt="\u@\h [\d]> " mlp_$@ ;}
ms() { mysql --defaults-file=/mnt/mlp/config/mysql/root.cnf --prompt="\u@\h [\d]> " -hdb6 mlp_$@ ;}
my() { mysql --defaults-file=/mnt/mlp/config/mysql/root.cnf --prompt="\u@\h [\d]> " -hdb$1 mlp_$2 ;}
my() { mysql --defaults-file=/mnt/mlp/config/mysql/root.cnf --prompt="\u@\h [\d]> " -hdb$1 mlp_$2 ;}

#DOCKER
alias ma='docker exec -it mlp-containers_mlp-app_1 mysql --defaults-file=/mnt/mlp/config/mysql/root.cnf mlp_austin;'
alias dapp='connectToDockerAppWithAliases'
function connectToDockerAppWithAliases()
{
	docker cp ~/.gitconfig mlp-containers_mlp-app_1:/etc/gitconfig && \
	docker exec mlp-containers_mlp-app_1 bash -c "[[ ! -d /root/.ssh ]] && mkdir /root/.ssh"
	docker cp ~/.ssh/id_rsa mlp-containers_mlp-app_1:/root/.ssh/id_rsa && \
	docker cp ~/.ssh/id_rsa.pub mlp-containers_mlp-app_1:/root/.ssh/id_rsa.pub && \
	docker cp ~/.bash_aliases mlp-containers_mlp-app_1:/root/.bash_aliases && \
	docker exec mlp-containers_mlp-app_1 bash -c "chown root:root /root/.ssh/* \
		&& chown root:root /root/.bash_aliases \
		&& cat /root/.bash_aliases >> /root/.bashrc \
		&& source /root/.bashrc"
	docker exec -it mlp-containers_mlp-app_1 bash
}
alias dperm='sudo chmod +777 /var/run/docker.sock'

function startsshagent()
{
	eval `ssh-agent`
	ssh-add /root/.ssh/id_rsa
}
alias shhagent='startsshagent'
alias exd='mv /usr/local/etc/php/conf.d/xdebug.ini.disabled /usr/local/etc/php/conf.d/xdebug.ini && service apache2 graceful'
alias dxd='mv /usr/local/etc/php/conf.d/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini.disabled && service apache2 graceful'
#md () { docker exec -it mlp-containers_mlp-app_1 mysql --defaults-file=/mnt/mlp/config/mysql/root.cnf --prompt="\u@\h [\d]> " mlp_$@ ;}

alias vim='usenvim'

function usenvim()
{
	if [ -f "/usr/bin/nvim" ]; then
		/usr/bin/nvim $1
	else
		/usr/bin/vim $1
	fi
}

alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

#PARSE
alias grep='grep --color=tty'
alias findf='find . -type f -name $1'
alias findr='find . -type f -regex $1'
function grepr()
{
    grep -r "$@" *
}
function greprn()
{
    grep -r -n "$@" *
}
function grepri()
{
    grep -ri "$@" *
}
function grepradmin()
{
    find /mnt/mlp/platform/admin | xargs grep -r -i --color=tty "$@"
}
function greplibrary()
{
    find /mnt/mlp/platform/lib | xargs grep -r -i --color=tty "$@"
}
function grepnonvendor()
{
    grep -ri --exclude-dir=vendor --exclude-dir=node/node_modules --exclude-dir=ckeditor --exclude-dir=ckeditor5 --exclude-dir=node_modules --exclude-dir=jquery-ui "$@" *
}
function grepsmarty()
{
    find /mnt/mlp/platform/smarty | xargs grep -r -i --color=tty "$@"
}
function grepsmartyaccessible()
{
    find /mnt/mlp/platform/smarty_accessible | xargs grep -r -i --color=tty "$@"
}
alias gr='grepr'
alias gri='grepri'
alias grl='greplibrary'
alias gra='grepadmin'
alias grnv='grepnonvendor'
alias grs='grepsmarty'
alias grsa='grepsmartyaccessible'
alias r='redis-cli'
alias rsup='sudo service redis-server start'
alias load='/mnt/mlp/release/lib/release/load.sh'
alias reloadalias="source ~/.bashrc && source ~/.bash_aliases"
function tailsitelog()
{
    tail -n 50 /var/log/httpd/error/$1-error_log
}
alias tails='tailsitelog'
function searchmessages()
{
    grep -n -C 1 "$@" /mnt/mlp/platform/locale/en_US/LC_MESSAGES/messages.po
}
function searchconfig()
{
    find /mnt/mlp/sites/*/config/ -name settings.json | xargs grep -i "$@"
}
function searchcss()
{
    find /mnt/mlp/sites/*/css | xargs grep -i "$@"
}
function searchmodules()
{
    find /mnt/mlp/sites/*/config/site_pages | xargs grep -i "$@"
}
#ACTIONS
function flush()
{
    php /mnt/mlp/scripts/memcache_flush.php $@
}
function flush_pages()
{
    php /mnt/mlp/scripts/memcache_delete.php $@ site_page_routes ; php /mnt/mlp/scripts/memcache_delete.php $@ site_page_namespace
}
function compile_message()
{
    /mnt/mlp/scripts/release/scripts/compile_translations.sh
}
function gls()
{
    git ls-files -m | xargs ls -ltr
}
function glsd
{
 git status --porcelain | awk '{print $2}' | xargs ls -ltr
}
function glsr()
{
    for C in $(git for-each-ref --sort=committerdate refs/heads --format='%(refname)')
    do
        git show -s --format="%ci $C" "$C"
    done
}
alias xphp="XDEBUG_CONFIG="idekey=netbeans-xdebug" php"
alias xvphp='XDEBUG_CONFIG="idekey=VSCODE" php'
alias phpunit="/mnt/mlp/platform/vendor/phpunit/phpunit/phpunit"
alias atest="phpunit --include-path austin -c /mnt/mlp/platform/tests/phpunit.xml"
alias saml2aws="~/saml2aws/bin/saml2aws"
alias loginnp="saml2aws login -a comm-np-a"
alias loginp="saml2aws login -a comm-p-a" 
alias shownp="aws --color off --profile comm-np-a ec2 describe-instances --query \"Reservations[*].Instances[*].{IP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,InstanceId:InstanceId} | sort_by(@, &[0].Name)\" --output table" 
alias showp="aws --color off --profile comm-p-a ec2 describe-instances --query \"Reservations[*].Instances[*].{IP:PrivateIpAddress,Name:Tags[?Key=='Name']|[0].Value,InstanceId:InstanceId}  | sort_by(@, &[0].Name)\" --output table" 
function connect() 
{ 
	aws --profile comm-$1-a ssm start-session --target=$(aws --profile comm-$1-a ec2 describe-instances --filters "Name=tag:Name,Values=psfy-$201ue1-tools" --query "Reservations[*].Instances[*].InstanceId" --output text | tail -n1) 
} 
alias connect="connect" 
function pcomm-ssm() 
{ 
  USAGE="Usage: pcomm-ssm <prod|stage|test|poc> ?<app|tools|sphinx|lb> ?<count>" 
  [ -z "$2" ] && itype=tools || itype=$2 
  [ -z "$3" ] && count=1 || count=$3 
  case "$1" in 
    prod) 
      PROFILE=comm-p-a 
    ;; 
    stage|test|poc) 
      PROFILE=comm-np-a 
    ;; 
    *) 
      echo $USAGE; return 1 
    ;; 
  esac 
  case "$itype" in 
    app) 
      ENV=psfy-${1}01ue1-application 
    ;; 
    tools) 
      ENV=psfy-${1}01ue1-tools 
    ;; 
    sphinx) 
      ENV=psfy-${1}01ue1-sphinx 
    ;; 
    lb) 
      ENV=psfy-${1}01ue1-haproxy 
    ;; 
    docker) 
      ENV=psfy-np-docker01
    ;; 
    *) 
      echo $USAGE; return 1 
    ;; 
  esac 
  saml2aws login -a ${PROFILE} 
  instance=$(aws --profile ${PROFILE} ec2 describe-instances \
                 --filters "Name=tag:Name,Values=${ENV}" \
                 --query "Reservations[*].Instances[*].InstanceId" \
                 --output text \
		 | sort | head -n ${count} | tail -n1)
  echo "Connecting to ${instance} : ${ENV} : instance ${count}" 
  aws --profile ${PROFILE} ssm start-session --target=${instance} 
} 
alias pcomm="pcomm-ssm" 
function console() 
{ 
  USAGE="Usage: console <np|p> ?<link>" 
  [ -z "$2" ] && link=$2 
  case "$1" in 
    p) 
      PROFILE=comm-p-a 
    ;; 
    np) 
      PROFILE=comm-np-a 
    ;; 
    *) 
      echo $USAGE; return 1 
    ;; 
  esac 
  saml2aws login -a ${PROFILE} 
  saml2aws console -a ${PROFILE} $2 
} 
alias awsconsole="console"

alias symul="source ~/symul/mozillatutorial/mozillatutorialvenv/bin/activate && cd ~/symul/cms"
alias symulrunserver="docker start symul-rabbitmq && docker start symul-postgres-db && docker start symul-redis && symul && python3 manage.py runserver"
