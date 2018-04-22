function _roscomplete_axcli
{
    local arg opts
    COMPREPLY=()
    arg="${COMP_WORDS[COMP_CWORD]}"
    local cword=$COMP_CWORD
    for a in $(seq $((COMP_CWORD-1))); do
        if [ -z "${COMP_WORDS[a]//-*}" ]; then
            ((cword--))
        fi
    done
    local words=(${COMP_WORDS[@]//-*})

    if [[ $cword == 1 ]]; then
        opts=`rostopic list | grep '/goal$' | sed 's,/goal$,,' 2> /dev/null`
        COMPREPLY=($(compgen -W "$opts" -- ${arg}))
    elif [[ $cword == 2 ]]; then
        mtype=`rostopic type ${words[1]}/goal`
        opts=`rosmsg-proto msg 2> /dev/null -s ${mtype:0:-10}Goal`
        if [ 0 -eq $? ]; then
            COMPREPLY="$opts"
        fi
    fi
}

complete -F "_roscomplete_axcli" "axcli"
