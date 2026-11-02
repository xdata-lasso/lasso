-- Schema DDL
CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE posts (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT, FOREIGN KEY (user_id) REFERENCES users (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO users (id, name) VALUES (1, 'Alice');
INSERT INTO users (id, name) VALUES (2, 'Bob');
INSERT INTO users (id, name) VALUES (3, 'Charlie');
INSERT INTO posts (id, user_id, title) VALUES (1, 2, 'Bob First Post');
INSERT INTO posts (id, user_id, title) VALUES (10, 1, 'Alice First Post');
INSERT INTO posts (id, user_id, title) VALUES (20, 1, 'Alice Second Post');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, p.title FROM users AS u LEFT JOIN posts AS p ON u.id = p.user_id;

/*
Gold Result:
('Alice', 'Alice First Post')
('Alice', 'Alice Second Post')
('Bob', 'Bob First Post')
('Charlie', None)
*/

-- Prediction Query
SELECT u.name, p.title FROM users AS u CROSS JOIN posts AS p ON u.id = p.user_id;

/*
Prediction Result:
('Alice', 'Alice First Post')
('Alice', 'Alice Second Post')
('Bob', 'Bob First Post')
*/