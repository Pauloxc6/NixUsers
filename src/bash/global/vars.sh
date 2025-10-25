#!/usr/bin/env bash
#*---------------------------------
#* Otimização
#*---------------------------------

export LANG=C
export LC_ALL=C


#*---------------------------------
#* PATHS
#*---------------------------------

ROOT="$PWD"
databases="$ROOT/database"
configs="$ROOT/config/"
srcBash="$ROOT/src/bash"
#CACHE_FILE="$PWD/cache/file.cache"

#*---------------------------------
#* Databases
#*---------------------------------

export dbDefault="$ROOT/users.db"
export dbBkp="$ROOT/exports/backup/bkp-users.sql"