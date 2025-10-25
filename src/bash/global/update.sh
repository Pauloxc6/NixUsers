#!/usr/bin/env bash

function update_user_data(){
    local $table="$1"
    local $key="$2"
    local $value="$3"
    local $id_type="$4"
    local $name="$5"

    id_user="$(sqlite3 "${dbDefault}" "SELECT id FROM users_common WHERE userName = '$name'")"

    sqlite3 "${dbDefault}" "UPDATE "${table}" SET "${key}" = "${value}" FROM "${id_type}" = '${id_user}'"
}