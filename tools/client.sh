#!/usr/bin/env bash
#hellcheck disable=SC2154
#---------------------------
# Imports
#---------------------------

# shellcheck disable=SC1091
. "$PWD/src/bash/global/vars.sh"


#---------------------------
# Vars
#---------------------------

count="0"

#---------------------------
# Functions
#---------------------------

function __login__(){
    #---------------------------
    # Banner
    #---------------------------

    figlet -c Login Client
    echo "By: @Pauloxc6"

    while :;do

        read -rp "User: " local_username
        read -rsp "Password: " local_password

        # ! Recupera os dados do arquivo database.db
        # shellcheck disable=SC2154
        user_name=$(sqlite3 -cmd ".parameter set @user ${local_username}" "${dbDefault}" "SELECT userName FROM users_common WHERE userName=@user;")
        user_pass=$(sqlite3 -cmd ".parameter set @user ${local_username}" "${dbDefault}" "SELECT userPass FROM users_common WHERE userName=@user;")

        pass_hash=$(echo -n "$local_password" | sha256sum | cut -d' ' -f1)

        # * Verifica as credenciais
        if [[ "${local_username,,}" == "${user_name,,}" && "$user_pass" == "$pass_hash" ]]; then
            echo -e "\n[+] Sucesso ao logar no sistema! [+]"
            sleep 1s
            #printf "\033c"
            break
        else
            (( count = count + 1 ))
            echo -e "\n[!] Erro ao logar! Tente novamente. [!]"
            [[ "$count" -eq 3 ]] && { echo "[!] Número máximo de tentativas atingido. Saindo... [!]"; exit 1 ;}
        fi
            
    done
}

#---------------------------
# Main
#---------------------------


__login__