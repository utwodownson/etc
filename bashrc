#!/bin/sh

# home path
home_path=${HOME}

########################### FUNCTION ###############################################################
recognize_machine() {
    # Determine the machine environment and load conf
    system=$(uname)
    domain=$(hostname | awk -F '.' '{print $(NF - 1)}')
    if [ ${system} = "Darwin" ]; then
        # macbook
        source ${home_path}/etc/conf/bashrc.mac
    elif [ ${system} = "Linux" ] && [ ${domain} = "baidu" ]; then
        # baidu machine
        source ${home_path}/etc/conf/bashrc.baidu
        source /etc/bashrc
    fi
}

make_ps() {
    # PS1
    add=$(hostname | awk -F '.' '{print $1}' | awk -F '-' '{print $NF}')
    PS1="\[\033[00;33m\]\u\[\033[00;31m\]@\[\033[00;31m\]${add} \[\033[00;36m\]\w\[\033[00m\]\$ "
}

trash() {
    # del to the ./trash
    mv $@ ~/.trash/
}

hup() {
    # shot nohup and log in ./
    nohup $@ >> ./log/nohup 2>&1 &
}

show_name() {
    echo -n ${USER}"@"$(uname -a | awk '{print $2}')":"$(pwd)
    echo
}

sum() {
    if [ $# -eq 1 ]; then
        cat $1 | awk 'BEGIN{sum=0}{sum+=$1}END{print sum}'
    else
        cat $1 | awk -v a=$2 'BEGIN{sum=0}{sum+=$a}END{print sum}'
    fi
}
####################################################################################################


if [ -f ${home_path}/.machine ]; then
    source ${home_path}/.machine
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
alias tree='tree -L 1'
alias astyle='astyle -j -W3 -k3 -f --delete-empty-lines --unpad-paren --pad-header --pad-oper -Y --indent=spaces=4 -A8 -S'
alias name='show_name'


make_ps
recognize_machine
