-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, username TEXT, status TEXT, last_login DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("user_id", "username", "status", "last_login") VALUES (1005, 'Allen Robinson', 'mouth', '1973-04-04');
INSERT INTO "users" ("user_id", "username", "status", "last_login") VALUES (1006, 'Kristina Baldwin', 'science', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT username FROM Users WHERE NOT last_login IS NULL AND NOT status IN ('BANNED', 'SUSPENDED');

/*
Gold Result:
('Allen Robinson',)
*/

-- Prediction Query
SELECT username FROM Users WHERE NOT status IN ('BANNED', 'SUSPENDED');

/*
Prediction Result:
('Allen Robinson',)
('Kristina Baldwin',)
*/