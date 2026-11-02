-- Schema DDL
CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE posts (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT, FOREIGN KEY (user_id) REFERENCES users (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("id", "name") VALUES (1001, 'Allison Hill');
INSERT INTO "users" ("id", "name") VALUES (1004, 'Allison Hill');
INSERT INTO "posts" ("id", "user_id", "title") VALUES (1002, 1001, 'Environmental health practitioner');
INSERT INTO "posts" ("id", "user_id", "title") VALUES (1005, NULL, 'Environmental health practitioner');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, p.title FROM users AS u LEFT JOIN posts AS p ON u.id = p.user_id;

/*
Gold Result:
('Allison Hill', 'Environmental health practitioner')
('Allison Hill', None)
*/

-- Prediction Query
SELECT u.name, p.title FROM users AS u INNER JOIN posts AS p ON u.id = p.user_id;

/*
Prediction Result:
('Allison Hill', 'Environmental health practitioner')
*/