-- Schema DDL
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO authors (id, name) VALUES (0, NULL), (1, 'default2'), (2, 'default1');
INSERT INTO books (id, author_id, title) VALUES (1, 2, 'default1'), (0, NULL, 'default2'), (2, 1, NULL), (3, 1, NULL), (4, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('default1', 'default1')
('default2', None)
('default2', None)
('default2', None)
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.id;

/*
Prediction Result:
(None, 'default2')
('default2', 'default1')
('default1', None)
*/