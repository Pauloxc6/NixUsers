#!/usr/bin/env bash

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

#---------------------------
# Main
#---------------------------

function __login__(){
    #---------------------------
    # Banner
    #---------------------------

    figlet -c Login Administrator
    echo "By: @Pauloxc6"

    while :;do

        read -rp "User: " local_username
        read -rsp "Password: " local_password

        # ! Recupera os dados do arquivo users.db
        # shellcheck disable=SC2154
        user_name=$(sqlite3 -cmd ".parameter set @user ${local_username}" "${dbDefault}" "SELECT user FROM users_adm WHERE user=@user;")
        user_pass=$(sqlite3 -cmd ".parameter set @user ${local_username}" "${dbDefault}" "SELECT pass FROM users_adm WHERE user=@user;")

        pass_hash=$(echo -n "$local_password" | sha256sum | cut -d' ' -f1)

        # * testa se a senha é menor que 8 caracteres e com limite de 32
        [[ "${#local_password}" -lt 8 || "${#local_password}" -gt 32 ]] && { echo "[!] Error a senha não pode ser menor que 8 digitos!" ; return 1;}

        # * Verifica as credenciais
        if [[ "${local_username,,}" == "${user_name,,}" && "$user_pass" == "$pass_hash" ]]; then
            echo -e "\n[+] Sucesso ao logar no sistema! [+]"
            sqlite3 "${dbDefault}" "INSERT INTO users_login(userName, userPass, ip, status) VALUES ('$local_username','$pass_hash','$(getip)','SUCCEDED');"
            sleep 1s
            #printf "\033c"
            break
        else
            (( count = count + 1 ))
            echo -e "\n[!] Erro ao logar! Tente novamente. [!]"
            sqlite3 "${dbDefault}" "INSERT INTO users_login(userName, userPass, ip, status) VALUES ('$local_username','$pass_hash','$(getip)','FAILED');"
            [[ "$count" -eq 3 ]] && { echo "[!] Número máximo de tentativas atingido. Saindo... [!]"; exit 1 ;}
        fi
            
    done
}

function getip() {
    ip=$(ip -4 a s dev wlo1 | grep inet | cut -d "/" -f1 | sed 's/inet//' | tr -d "     ")
    echo "$ip"
}
