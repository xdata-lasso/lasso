-- Schema DDL
CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE posts (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT, FOREIGN KEY (user_id) REFERENCES users (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("id", "name") VALUES (13, NULL);
INSERT INTO "users" ("id", "name") VALUES (18, '21');
INSERT INTO "posts" ("id", "user_id", "title") VALUES (12, NULL, '13');
INSERT INTO "posts" ("id", "user_id", "title") VALUES (11, 13, '24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, p.title FROM users AS u LEFT JOIN posts AS p ON u.id = p.user_id;

/*
Gold Result:
(None, '24')
('21', None)
*/

-- Prediction Query
SELECT u.name, p.title FROM users AS u INNER JOIN posts AS p ON u.id = p.user_id;

/*
Prediction Result:
(None, '24')
*/