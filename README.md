# NixUsers

Esse é um pequeno projeto de cadastro e consulta de usuários

---

## 🚀 Tecnologias utilizadas

Bash → automação de tarefas e scripts

SQL → consultas e gerenciamento de banco de dados

Elixir → back-end / lógica de negócio / processamento concorrente (Em breve)

JSON → troca de dados e configuração (Em breve)

---

## ⚙️ Instalação e execução

Pré-requisitos

- Bash >= 5.0

- SQLite >= 3.5

- Elixir >= 1.18.4

---

## 📂 Estrutura do projeto

```
NixUsers/
├── bin/              # Scripts executáveis (atalhos, entrypoints)
├── src/              # Código-fonte principal
│   ├── elixir/       # Código Elixir (mix, módulos, etc.)
│   └── bash/         # Scripts auxiliares, não executáveis diretamente
│
├── database/         # Queries SQL principais
│   ├── migrations/   # Scripts de migração de banco
│   ├── reports/      # Consultas de relatórios
│   └── procedures/   # Procedures e views
│
├── json/             # Schemas e exemplos de dados
│   ├── schemas/
│   └── samples/
│
├── test/             # Testes
│   ├── bash/         # Testes para scripts shell
│   ├── sql/          # Testes de queries (ex: inserts + selects esperados)
│   └── elixir/       # ExUnit tests
│
├── docs/             # Documentação
│   ├── README.md
│   ├── CHANGELOG.md
│   └── arquitetura.md
│
├── .gitignore
├── Makefile / Rakefile / mix.exs  # (dependendo da linguagem/ferramenta principal)
└── docker-compose.yml / Dockerfile (se usar containers)
```
