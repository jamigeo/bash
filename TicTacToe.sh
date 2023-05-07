#!/bin/bash

declare -a board=("-" "-" "-" "-" "-" "-" "-" "-" "-");

function print_board() {
    clear
    local -a board=("$@")
    echo "-------------"

    for row in {0..2}; do
        echo -n "| "
        for col in {0..2}; do
            local index=$((row * 3 + col))
            echo -n "${board[index]} | "
        done
        echo ""
        echo "-------------"
    done    
}

print_board "${board[@]}"

function update_board() {
    board[$index]=$player
}

function place_mark() {
    player="X"
    while true; do
        read -p "Bitte setzten sie ihren Zug, Spieler $player: " row col
        index=$((row * 3 + col))
        if [ "${board[$index]}" == "-" ]; then
            update_board "${board[@]}"
            print_board "${board[@]}"
            if  $(check_diagonals_for_win) || $(check_rows_for_win) || $(check_columns_for_win); then
                echo "$player won!"
                exit 0
            fi
        else
            echo "nach else ${board[$index]}"
            echo "Ungültiger Zug. Bitte erneut versuchen."
        fi
        if [ $player == "O" ]; then
            player="X"
        else
            player="O"
        fi
    done
}


function check_all_same() {
    local c1=$1
    local c2=$2
    local c3=$3

    if [ "$c1" == "$player" ] && [ "$c1" == "$c2" ] && [ "$c2" == "$c3" ]; then
        echo true
    else
        echo false
    fi
}

function check_rows_for_win() {

    for row in {0..2}; do
        local index=$((row * 3))
        if $(check_all_same "${board[$index]}" "${board[$((index + 1))]}" "${board[$((index + 2))]}"); then
            echo true
            return
        fi
    done

    echo false
}

function check_columns_for_win() {

    for col in {0..2}; do
        if $(check_all_same "${board[$col]}" "${board[$((col + 3))]}" "${board[$((col + 6))]}"); then
            echo true
            return
        fi
    done

    echo false
}

function check_diagonals_for_win() {

    if $(check_all_same "${board[0]}" "${board[4]}" "${board[8]}"); then
        echo true
        return
    fi

    if $(check_all_same "${board[2]}" "${board[4]}" "${board[6]}"); then
        echo true
        return
    fi

    echo false
}


place_mark "${board[@]}"