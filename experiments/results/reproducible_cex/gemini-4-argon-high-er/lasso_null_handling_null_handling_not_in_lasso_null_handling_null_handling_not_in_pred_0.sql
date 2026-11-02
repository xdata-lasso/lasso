-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, username TEXT, status TEXT, last_login DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Users (user_id, username, status, last_login) VALUES (1, 'alice', 'ACTIVE', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT username FROM Users WHERE NOT last_login IS NULL AND NOT status IN ('BANNED', 'SUSPENDED');

/*
Gold Result:
*/

-- Prediction Query
SELECT username FROM Users WHERE NOT status IN ('BANNED', 'SUSPENDED');

/*
Prediction Result:
('alice',)
*/