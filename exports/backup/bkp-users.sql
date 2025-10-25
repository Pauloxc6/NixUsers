PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE users_adm (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user TEXT NOT NULL,
    pass TEXT NOT NULL,
    datetime DATETIME DEFAULT (datetime('now', 'localtime')),
    created_at DATETIME DEFAULT (datetime('now', 'localtime')),
    updated_at DATETIME DEFAULT (datetime('now', 'localtime'))
);
INSERT INTO users_adm VALUES(1,'admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','2025-10-22 19:46:13','2025-10-22 19:46:13','2025-10-22 19:46:13');
CREATE TABLE users_common (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    userName TEXT NOT NULL,
    userPass TEXT NOT NULL,
    datetime DATETIME DEFAULT (datetime('now', 'localtime')),
    created_at DATETIME DEFAULT (datetime('now', 'localtime')),
    updated_at DATETIME DEFAULT (datetime('now', 'localtime'))
);
CREATE TABLE users_login (
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
INSERT INTO users_login VALUES(1,'admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','192.168.4.105','SUCCEDED','2025-10-22 19:52:26','2025-10-22 19:52:26','2025-10-22 19:52:26');
INSERT INTO users_login VALUES(2,'guest','6b93ccba414ac1d0ae1e77f3fac560c748a6701ed6946735a49d463351518e16','192.168.4.105','FAILED','2025-10-22 20:00:00','2025-10-22 20:00:00','2025-10-22 20:00:00');
INSERT INTO users_login VALUES(3,'paulo','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','192.168.4.105','FAILED','2025-10-22 20:00:09','2025-10-22 20:00:09','2025-10-22 20:00:09');
INSERT INTO users_login VALUES(4,'admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','192.168.4.105','SUCCEDED','2025-10-22 20:00:14','2025-10-22 20:00:14','2025-10-22 20:00:14');
INSERT INTO sqlite_sequence VALUES('users_adm',1);
INSERT INTO sqlite_sequence VALUES('users_login',4);
COMMIT;
