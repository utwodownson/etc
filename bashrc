domain=$(hostname | awk -F '.' '{print $(NF - 1)}')
if [ ${domain} == "baidu" ]; then
    source ${HOME}/etc/bashrc.baidu
fi

system=$(uname)
if [ ${system} = "Darwin" ]; then
    source ${HOME}/etc/bashrc.mac
fi

if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

if [ -f ${HOME}/.machine ]; then
    source ${HOME}/.machine
fi

if [ ! -d "HOME_LIB" ]; then
    export HOME_LIB="${HOME}/lib"
fi

if [ ! -d "LC_CTYPE" ]; then
    export LC_CTYPE="zh_CN.UTF-8"
fi

if [ ! -d "TERM" ]; then
    export TERM="xterm-256color"
fi

if [ ! -d "HADOOP_HOME" ]; then
    export HADOOP_HOME="${HOME}/hadoop-client/hadoop"
fi


make_ps() {
    add=$(hostname | awk -F '.' '{print $1}' | awk -F '-' '{print $3}')
    PS1="\[\033[01;31m\]\u\[\033[01;31m\]@\[\033[01;33m\]$add \[\033[0;31m\]\W\[\033[37;36m\]\$ \[\033[1;37m\]"
}

trash() {
    mv $@ ~/.trash/
}

hup() {
    nohup $@ >> ../log/nohup 2>&1 &
}

make_ps


alias rm='trash'
alias df='df -h'
alias du='du -h --max-depth=1'
alias less='less -r'
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias vim='vi'
alias tree="tree -L 1"
alias astyle="astyle -j -W3 -k3 -f --delete-empty-lines --unpad-paren --pad-header --pad-oper -Y --indent=spaces=4 -A8 -S"
