-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, username TEXT, status TEXT, last_login DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("user_id", "username", "status", "last_login") VALUES (6, NULL, 'SUSPENDED7', '1000-01-09');
INSERT INTO "Users" ("user_id", "username", "status", "last_login") VALUES (5, NULL, 'SUSPENDED9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT username FROM Users WHERE NOT last_login IS NULL AND NOT status IN ('BANNED', 'SUSPENDED');

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT username FROM Users WHERE NOT status IN ('BANNED', 'SUSPENDED');

/*
Prediction Result:
(None,)
(None,)
*/