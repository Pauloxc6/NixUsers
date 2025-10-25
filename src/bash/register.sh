#!/usr/bin/env bash

#---------------------------
# Imports
#---------------------------

# shellcheck disable=SC1091
. "$PWD/src/bash/global/vars.sh"


#---------------------------
# Vars
#---------------------------

#---------------------------
# Functions
#---------------------------

#---------------------------
# Main
#---------------------------

function __register__(){
    #---------------------------
    # Banner
    #---------------------------

    figlet -c Register
    echo "By: @Pauloxc6"

    # * Resgitro do useradm

    echo ""
    echo "[*] Se registre no banco de dados [*]"
    read -rp "[*] Nome: " user_name
    read -rsp "[*] Senha: " user_senha

    echo -e "\n[-] Aguarde a validação... [-]"
    sleep 5s

    [[  "$(sqlite3 "${dbDefault}" "SELECT user FROM users_adm WHERE id = '$user_name'")" == "$user_name" ]] && (
        echo "[!] Usuário já existe no banco de dados!"
        return 1
    )

    [[ "${#user_senha}" -lt 8 || "${#user_senha}" -gt 32 ]] && { echo "[!] Error a senha não pode ser menor que 8 digitos!" ; return 1;}

    echo -e "[+] Sucesso! Seu cadastro na equipe foi aprovado.[+]\n"

    # * Cria um hash da senha (usando sha256 para segurança)
    pass_hash=$(echo -n "$user_senha" | sha256sum | cut -d' ' -f1)

    # ! Atualiza o arquivo users.db
    sqlite3 "${dbDefault}" "INSERT INTO users_adm (user, pass) VALUES('$user_name', '$pass_hash');"

    echo "[+] Cadastro concluído! [+]"
    echo "[-] Nome: $user_name"
    echo "[-] Pass: $pass_hash"

}