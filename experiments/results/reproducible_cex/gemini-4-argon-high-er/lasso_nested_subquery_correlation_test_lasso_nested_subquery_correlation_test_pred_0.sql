-- Schema DDL
CREATE TABLE authors (author_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (book_id INTEGER PRIMARY KEY, author_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO authors (author_id, name) VALUES (1, 'Alice');
INSERT INTO books (book_id, author_id, year) VALUES (1, 1, 2019);
INSERT INTO books (book_id, author_id, year) VALUES (2, 2, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name FROM authors AS a WHERE NOT EXISTS(SELECT * FROM books AS b1 WHERE a.author_id = b1.author_id AND EXISTS(SELECT * FROM books AS b2 WHERE b2.author_id = b1.author_id AND b2.year = 2020));

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT a.name FROM authors AS a WHERE NOT EXISTS(SELECT * FROM books AS b1 WHERE a.author_id = b1.author_id AND EXISTS(SELECT * FROM books AS b2 WHERE b2.year = 2020));

/*
Prediction Result:
*/