-- Schema DDL
CREATE TABLE authors (author_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE book_authors (author_id INTEGER, book_id INTEGER, PRIMARY KEY (author_id, book_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO authors (author_id, name) VALUES (1, 'Author 1');
INSERT INTO authors (author_id, name) VALUES (2, 'Author 2');
INSERT INTO book_authors (author_id, book_id) VALUES (1, 100);
INSERT INTO book_authors (author_id, book_id) VALUES (2, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT b.book_id FROM authors AS a JOIN book_authors AS b ON a.author_id = b.author_id;

/*
Gold Result:
(100,)
*/

-- Prediction Query
SELECT b.book_id FROM authors AS a JOIN book_authors AS b ON a.author_id = b.author_id;

/*
Prediction Result:
(100,)
(100,)
*/