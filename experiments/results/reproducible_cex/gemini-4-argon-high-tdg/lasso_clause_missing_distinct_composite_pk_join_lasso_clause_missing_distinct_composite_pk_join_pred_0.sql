-- Schema DDL
CREATE TABLE authors (author_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE book_authors (author_id INTEGER, book_id INTEGER, PRIMARY KEY (author_id, book_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO authors (author_id, name) VALUES (1, 'Alice');
INSERT INTO authors (author_id, name) VALUES (2, 'Bob');
INSERT INTO authors (author_id, name) VALUES (3, 'Charlie');
INSERT INTO book_authors (author_id, book_id) VALUES (1, 101);
INSERT INTO book_authors (author_id, book_id) VALUES (2, 101);
INSERT INTO book_authors (author_id, book_id) VALUES (1, 102);
INSERT INTO book_authors (author_id, book_id) VALUES (3, 103);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT b.book_id FROM authors AS a JOIN book_authors AS b ON a.author_id = b.author_id;

/*
Gold Result:
(101,)
(102,)
(103,)
*/

-- Prediction Query
SELECT b.book_id FROM authors AS a JOIN book_authors AS b ON a.author_id = b.author_id;

/*
Prediction Result:
(101,)
(101,)
(102,)
(103,)
*/