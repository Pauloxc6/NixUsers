-- Shema database create user ADM
-- Criação da tabela userADM (se não existir)
CREATE TABLE IF NOT EXISTS users_adm (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user TEXT NOT NULL,
    pass TEXT NOT NULL,
    datetime DATETIME DEFAULT (datetime('now', 'localtime')),
    created_at DATETIME DEFAULT (datetime('now', 'localtime')),
    updated_at DATETIME DEFAULT (datetime('now', 'localtime'))
);
