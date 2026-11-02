-- Schema DDL
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO authors (id, name) VALUES (0, 'default2'), (1, NULL), (2, 'default1');
INSERT INTO books (id, author_id, title) VALUES (0, 2, 'default2'), (1, 1, 'default1'), (2, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('default1', 'default2')
(None, 'default1')
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = a.id;

/*
Prediction Result:
('default2', 'default2')
('default2', 'default1')
('default2', 'default2')
(None, 'default2')
(None, 'default1')
(None, 'default2')
('default1', 'default2')
('default1', 'default1')
('default1', 'default2')
*/