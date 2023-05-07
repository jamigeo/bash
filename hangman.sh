#!/bin/bash

select_random() {
    printf "%s\0" "$@" | shuf -z -n1 | tr -d '\0'
}

expressions=("ALGEBRA" "BETRIEB" "CHIMÄRE" "DEBATTE" "EINTOPF" "FALZUNG" "GEMISCH")
selectedexpression=$(select_random "${expressions[@]}")

last_words() {
    read -p "Stottere dein letztes Wort, bevor du stirbst (in Großbuchstaben): " GEWIMMER
}


matches="_______"

print_guess() {
    j=""
    i=0
    while [ $i -lt ${#matches} ]; do 
        j="$j${matches:$i:1} "
        i=$((i + 1))
    done
    echo "$j"
}

function wrong0 {
    echo
    echo 
    echo
    echo
    echo
    echo
    echo
    echo
}

function wrong1 {
    echo
    echo "        O             "
    echo
    echo
    echo
    echo
    echo
    echo
}

function wrong2 {
    echo
    echo "         O            "
    echo "         |            "
    echo
    echo
    echo
    echo
    echo
}

function wrong3 {
    echo
    echo "         O            "
    echo "         |\           "
    echo
    echo
    echo
    echo
    echo
}

function wrong4 {
    echo
    echo "         O            "
    echo "        /|\           "
    echo
    echo
    echo
    echo
    echo
}

function wrong5 {
    echo
    echo "         O            "
    echo "        /|\           "
    echo "        /             "
    echo
    echo
    echo
    echo
}

function wrong6 {
    echo
    echo "         O            "
    echo "        /|\           "
    echo "        / \           "
    echo
    echo
    echo
    echo
}

function wrong7 {
    echo
    echo "         __________   "
    echo "         |        |   "
    echo "         O        |   "
    echo "        /|\       |   "
    echo "        / \       |   "
    echo "    ______________|___"
    echo
}

Versuche=0

while [ $Versuche -lt 7 ]; do

    last_words
    if [[ "$selectedexpression" == *"$GEWIMMER"* ]]; then
        x=0
        while [ $x -lt ${#matches} ]; do 
            if [[ "${selectedexpression:$x:1}" == $GEWIMMER ]]; then
                last_letter_count=$((${#matches} - x))
                matches="${matches:0:$x}${GEWIMMER}${matches:$((x + 1)):$last_letter_count}"
            fi
            x=$((x + 1))
        done
        print_guess
        wrong$Versuche
        if [[ "$matches" != *"_"* ]]; then
            echo "Dieses Mal kommst du noch mit deinem Leben davon..."
            break
        fi
    else
        print_guess
        Versuche=$((Versuche + 1))
        wrong$Versuche

    fi
done