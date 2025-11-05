# NixUsers

Esse é um pequeno projeto de cadastro e consulta de usuários

---

## 🚀 Tecnologias utilizadas

Bash → automação de tarefas e scripts

SQL → consultas e gerenciamento de banco de dados

---

## ⚙️ Instalação e execução

Pré-requisitos

- Bash >= 5.0

- SQLite >= 3.5

---

## 📂 Estrutura do projeto

```
NixUsers/
├── bin/              # Scripts executáveis (atalhos, entrypoints)
|
├── src/              # Código-fonte principal
│   └── bash/         # Scripts auxiliares, não executáveis diretamente
│
├── database/         # Queries SQL principais
│   ├── migrations/   # Scripts de migração de banco
│   ├── reports/      # Consultas de relatórios
│   └── procedures/   # Procedures e views
│
├── test/             # Testes
│   ├── bash/         # Testes para scripts shell
│   ├── sql/          # Testes de queries (ex: inserts + selects esperados)
│
├── docs/             # Documentação
│   ├── README.md
│   ├── CHANGELOG.md
│   └── arquitetura.md
│
├── .gitignore
```
