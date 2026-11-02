-- Schema DDL
CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE posts (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT, FOREIGN KEY (user_id) REFERENCES users (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching, non-matching titles, case sensitivity, substring matching, NULL user_id (excluded by INNER JOIN), and multiple matching posts per user (tests COUNT(*) vs COUNT(DISTINCT u.id)).
INSERT INTO users (id, name) VALUES (1, 'Alice');
INSERT INTO users (id, name) VALUES (2, 'Bob');
INSERT INTO users (id, name) VALUES (3, 'Hello');
INSERT INTO posts (id, user_id, title) VALUES (10, 1, 'Hello');
INSERT INTO posts (id, user_id, title) VALUES (20, 1, 'Hello');
INSERT INTO posts (id, user_id, title) VALUES (30, 1, 'World');
INSERT INTO posts (id, user_id, title) VALUES (40, 2, 'hello');
INSERT INTO posts (id, user_id, title) VALUES (50, 2, 'Hello World');
INSERT INTO posts (id, user_id, title) VALUES (60, 2, NULL);
INSERT INTO posts (id, user_id, title) VALUES (70, NULL, 'Hello');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) FROM users AS u JOIN posts AS p ON u.id = p.user_id WHERE p.title = 'Hello';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM posts AS p WHERE p.title = 'Hello';

/*
Prediction Result:
(3,)
*/