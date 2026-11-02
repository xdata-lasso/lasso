-- Schema DDL
CREATE TABLE Users (user_id INTEGER PRIMARY KEY, username TEXT, status TEXT, last_login DATE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (user_id, username, status, last_login) VALUES (1, 'alice', 'ACTIVE', '2023-05-01');
INSERT INTO Users (user_id, username, status, last_login) VALUES (2, 'bob', 'BANNED', '2023-05-01');
INSERT INTO Users (user_id, username, status, last_login) VALUES (3, 'charlie', 'SUSPENDED', '2023-05-01');
INSERT INTO Users (user_id, username, status, last_login) VALUES (4, 'david', 'ACTIVE', NULL);
INSERT INTO Users (user_id, username, status, last_login) VALUES (5, 'eve', 'BANNED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT username FROM Users WHERE NOT last_login IS NULL AND NOT status IN ('BANNED', 'SUSPENDED');

/*
Gold Result:
('alice',)
*/

-- Prediction Query
SELECT username FROM Users WHERE NOT status IN ('BANNED', 'SUSPENDED');

/*
Prediction Result:
('alice',)
('david',)
*/