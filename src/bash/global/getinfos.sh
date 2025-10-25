#!/usr/bin/env bash

function get_user_data(){
    local key="$1"
    local table="$2"
    local name="$3"
    local id_type="$4"

    if [[ -z "$*" ]]; then 
        echo "[!] Os valores não podem ser nulos"
        exit 1
    fi

    local id_user=$(sqlite3 "${dbDefault}" "SELECT id FROM users_common WHERE userName = '$name'")

    sqlite3 "${dbDefault}" "SELECT $key FROM $table WHERE $id_type = $id_user"
}