[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -alFh'
alias rm='rm -i'
alias emacs='emacs -nw'
alias diff='diff --color'

PATH="${HOME}/.local/bin:${PATH}"
PATH="$PATH:$HOME/.local/share/coursier/bin"
export GEM_HOME="$(gem env user_gemhome)"
PATH="$PATH:$GEM_HOME/bin"
export PATH

PS1='\[\e[1m\]\n$? [\u@\h \w]\[\e[0m\]\n\$> '
bash_preexec_path="/usr/share/bash-preexec/bash-preexec.sh"
case "$TERM" in
    dumb)
        PS1='\$ '
        ;;
    xterm*)
        vterm_title_preexec() {
            printf "\033]0;$(dirs +0):${1%% *}\007"
        }
        vterm_title_precmd() {
            printf "\033]0;$(dirs)\007"
        }
        vterm_printf() {
            if [ -n "$TMUX" ]; then
                printf "\ePtmux;\e\e]%s\007\e\\" "$1"
            elif [ "${TERM%%-*}" = "screen" ]; then
                printf "\eP\e]%s\007\e\\" "$1"
            else
                printf "\e]%s\e\\" "$1"
            fi
        }
        prompt_end(){
            vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
        }
        test -f "$bash_preexec_path" && source "$bash_preexec_path" || echo '! bash-preexec is not installed'
        precmd_functions+=(vterm_title_precmd)
        preexec_functions+=(vterm_title_preexec)
        PS1="$PS1"'\[$(prompt_end)\]'
        ;;
    screen*)
        function set_screen_title() {
            printf '\033k'"$1"'\033\\'
            printf '\033]0;screen['"$1"']\007'
        }
        function set_screen_title_pwd() {
            set_screen_title "$(echo $PWD | sed -e "s_${HOME}_\~_" -e "s_\([^/]\)[^/]*/_\1/_g")"
        }
        function set_screen_title_cmd() {
            set_screen_title "$(basename "$(pwd | sed -e "s_^${HOME}_\~_")"):${1/ */}"
        }
        test -f "$bash_preexec_path" && source "$bash_preexec_path" || echo '! bash-preexec is not installed'
	preexec_functions+=(set_screen_title_cmd)
	precmd_functions+=(set_screen_title_pwd)
esac
export PS1
