CREATE TABLE IF NOT EXISTS users_login (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userName TEXT NOT NULL,
    userPass TEXT NOT NULL,
    ip TEXT NOT NULL,
    status TEXT NOT NULL,
    datetime DATETIME DEFAULT (datetime('now', 'localtime')),
    created_at DATETIME DEFAULT (datetime('now', 'localtime')),
    updated_at DATETIME DEFAULT (datetime('now', 'localtime')),
    FOREIGN KEY (userName) REFERENCES users_common(userName)
);
