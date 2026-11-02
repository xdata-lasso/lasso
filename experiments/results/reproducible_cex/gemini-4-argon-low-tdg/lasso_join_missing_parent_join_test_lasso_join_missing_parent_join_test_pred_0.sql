-- Schema DDL
CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE posts (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT, FOREIGN KEY (user_id) REFERENCES users (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO users (id, name) VALUES (1, NULL);
INSERT INTO users (id, name) VALUES (2, 'Hello');
INSERT INTO posts (id, user_id, title) VALUES (10, 1, 'Hello');
INSERT INTO posts (id, user_id, title) VALUES (11, 2, 'World');
INSERT INTO posts (id, user_id, title) VALUES (12, NULL, 'Hello');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM users AS u JOIN posts AS p ON u.id = p.user_id WHERE p.title = 'Hello';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM posts AS p WHERE p.title = 'Hello';

/*
Prediction Result:
(2,)
*/