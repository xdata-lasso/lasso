-- Schema DDL
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO authors (id, name) VALUES (1, 'Author 1');
INSERT INTO authors (id, name) VALUES (2, 'Author 2');
INSERT INTO books (id, title, author_id) VALUES (1, 'Book 1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('Author 1', 'Book 1')
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = a.id;

/*
Prediction Result:
('Author 1', 'Book 1')
('Author 2', 'Book 1')
*/