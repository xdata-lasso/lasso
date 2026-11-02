-- Schema DDL
CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE posts (id INTEGER PRIMARY KEY, user_id INTEGER, title TEXT, FOREIGN KEY (user_id) REFERENCES users (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (id, name) VALUES (0, 'default2'), (1, 'default2');
INSERT INTO posts (id, user_id, title) VALUES (1, 1, 'default1'), (0, 1, 'default1'), (2, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, p.title FROM users AS u LEFT JOIN posts AS p ON u.id = p.user_id;

/*
Gold Result:
('default2', None)
('default2', None)
('default2', 'default1')
('default2', 'default1')
*/

-- Prediction Query
SELECT u.name, p.title FROM users AS u INNER JOIN posts AS p ON u.id = p.user_id;

/*
Prediction Result:
('default2', 'default1')
('default2', 'default1')
('default2', None)
*/