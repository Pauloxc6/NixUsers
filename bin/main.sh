#!/usr/bin/env bash
#---------------------------
# Bannets
#---------------------------

figlet -c NixUsers

#---------------------------
# Imports
#---------------------------

imports=( "$PWD/src/bash/global/vars.sh" "$PWD/src/bash/login.sh" "$PWD/src/bash/register.sh" )

for elem in "${imports[@]}";do
    if [[ -f "$elem" ]];then
        # shellcheck disable=SC1090
        source "${elem}" >/dev/null 2>&1
    else
        echo "[!] Error ao importar a lib: [$elem]"
    fi
done

#---------------------------
# Vars
#---------------------------

export LANG=C
export LC_ALL=C

set -euo pipefail

formats_support=("json" "box" "csv" "table" )
user_config_import="$(grep "user=" "$PWD/config/adm.config" | cut -d "=" -f2 | tr -d '"')"
pass_config_import="$(grep "pass=" "$PWD/config/adm.config" | cut -d "=" -f2 | tr -d '"')"

#---------------------------
# Functions
#---------------------------

function debuger(){

    # Função de limpeza
    function cleanup() {
        set +x
        echo -e "\n\e[1;37m[!] Finalizando depuração...\e[0m"
        echo -e "[!] Depuração encerrada: $(date)"
    }

    echo -e "\n\e[1;37m[+] Iniciando depuração!\e[0m"
    echo -e "[+] Depuração iniciada em: $(date)\n"

    set -x

    # Garante que sera finalizado
    trap cleanup EXIT

}

function mhelp(){
    cat <<EOF 
Help Menu
    Básico:
    1. --help  | -h - Menu de Ajuda
    2. --debug | -d - Modo Debug (on)

    Check
    1. --check-database     | -cdb - Check a integridade do banco de dados
    2. --check-users-adm    | -cua - Check a tabela adm
    3. --check-users-common | -cuc - Check a tabela common

    Export
    1. --export <type> | -e <type> - Faz a exportação dos dados [box, csv, json, table]

    Backup/Import
    1. --backup | -b               - Salva um backup dos dados
    2. --import <file> | -i <file> - Importa dados exportados
EOF
}

#---------------------------
# Teste básico
#---------------------------

# * Testa se o arquivo existe, caso não ele cria
# shellcheck disable=SC2154
if [[ ! -f "${dbDefault}" ]];then
    echo "[!] Arquivo ${dbDefault} não exite!"
    sleep 0.4
    echo "[+] Criando o ${dbDefault}"
    if sqlite3 "${dbDefault}" < "${dbBkp}"; then
        echo "[+] Arquivo criado com sucesso"
        sqlite3 "${dbDefault}" "PRAGMA foreign_keys = ON;"
    else
        echo "[!] Falha ao criar o arquivo"
        exit 1
    fi
else
    echo -n
fi

# teste params
while [ $# -ne 0 ];do
    case "$1" in
        "--debug"|"-d") debuger       ;;
        "--help"|"-h") mhelp ; exit 1 ;;
        #* Functions Check
        "--check-database"|"-cdb")
            echo "[-] Teste de integridade        | $(sqlite3 -ascii "${dbDefault}" "PRAGMA integrity_check;") [-]"
            echo "[-] Teste de integridade rápido | $(sqlite3 -ascii "${dbDefault}" "PRAGMA quick_check;") [-]"
            #echo "[-] Teste de chave estrangeira  | $(sqlite3 -ascii "${dbDefault}" "PRAGMA foreign_key_check;") [-]"      
            exit 1
        ;;
        "--check-users-adm"|"-cua")
            echo "[Users Adm] -> [users_adm]"
            sqlite3 -box "${dbDefault}" "SELECT * FROM users_adm;"
            exit 
        ;;
        "--check-users-common"|"-cuc")
            echo "[Users Common] -> [users_common]"
            sqlite3 -box "${dbDefault}" "SELECT * FROM users_common;"
            exit 
        ;;
        #*Functions Exports
        "--export"|"-e")
            shift
            type="$1"
            type="${type,,}"
            for item in "${formats_support[@]}";do 
                if [[ "$item" == "$type" ]];then 
                    echo -e "Exportando todo database para $PWD/exports/schema.$type"
                    sqlite3 -"$type" "${dbDefault}" "SELECT * FROM users_common;" 2>/dev/null
                    sqlite3 -"$type" "${dbDefault}" "SELECT * FROM users_common;" > "$PWD/exports/schema.$type"
                    exit 1
                fi
            done
            echo "[!] Formato [$type] não suportado pelo sistema"
            exit 1
        ;;
        #* Functions Backup and Import
        "--backup"|"-b")
            echo "[+] Fazendo backup dos dados em [$PWD/exports/backup/*.*]"
            sleep 2s
            sqlite3 "${dbDefault}" ".dump" > "$PWD/exports/backup/$(date +s"%d-%m-%Y-%d:%M:%H")-backup-database.sql"
            exit 1 ;;
        "--import"|"-i")
            shift
            path_bkp="$1"
            path_bkp="${path_bkp##*.}"
            echo "[+] Importando dados em ${dbDefault} com $path_bkp"
            sqlite3 "${dbDefault}" < "$path_bkp"
            exit 1
        ;;
    esac
    shift
done

# teste se exite um usuario adm
list_useradm=("admin" "adm" "administrator" "administrador")
check_user_adm=$(sqlite3 "${dbDefault}" "SELECT user FROM users_adm WHERE user='admin' OR user='adm' OR user='administrator' OR user='administrador';")
for useradm in "${list_useradm[@]}";do
    if [[ "$check_user_adm" = "$useradm" ]];then
        break
    else
        echo -e "[!] Usuário adm não exite no sistema! \n Utilize um desses (${list_useradm[*]}) para criar o usário ou deixie o sistema criar um!"
        echo -e "[!] S = Sim | D = Default | N = Não"
        read -rp "Resposta [s/d/n]: " resp
        if [[ "${resp,,}" = "s" ]]; then
           __register__
           break
        elif [[ "${resp,,}" = "n" ]]; then break
        else
            sqlite3 "$dbDefault" "INSERT INTO users_adm(user, pass) VALUES ('$user_config_import' , '$pass_config_import');"
            break
        fi
    fi
done


#---------------------------
# Main
#---------------------------
# chamando a função de login
# login adm
__login__