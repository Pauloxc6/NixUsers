-- Shema database create user Common and Guest
create TABLE IF NOT EXISTS users_common (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userName TEXT NOT NULL,
    userPass TEXT NOT NULL,
    datetime DATETIME DEFAULT (datetime('now', 'localtime')),
    created_at DATETIME DEFAULT (datetime('now', 'localtime')),
    updated_at DATETIME DEFAULT (datetime('now', 'localtime'))
);
