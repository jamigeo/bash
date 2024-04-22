#!/bin/bash

Job=${0:0:-3}

if [[ ! -t 0 ]]; then
    case "$Job" in
        *AWS*) ;;
            *) exit;;
    esac
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ "$color_prompt" = yes ]; then
  PS1="   \033[37m_ _ \n \033[35m_\033[37m[\033[31m°\033[37m_\033[31m°\033[37m]\033[35m_\n\033[35m(\033[37m[__|\033[37m__\033[37m]\033[35m)\\033[37m______\n \033[35m\\ \ \\033[37m[         ]\n\033[32m AWS" # Hier kann man statt AWS einfach \u einfuegen um den aktuellen user anzuzeigen...
  PS1+="\033[31m@\033[37m[\033[34mRobomaker\033[37m](\w)\\033[33m\$\033[0m " # Hier statt Robomaker (Das Amazon Roboterprogramm) einfach mit "$(hostname)" den aktuellen Computernamen einfuegen...
else
  PS1='@\Robomaker:\w\$ '
fi








