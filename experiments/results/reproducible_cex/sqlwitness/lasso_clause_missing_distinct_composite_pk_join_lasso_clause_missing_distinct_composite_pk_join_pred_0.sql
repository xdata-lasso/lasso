-- Schema DDL
CREATE TABLE authors (author_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE book_authors (author_id INTEGER, book_id INTEGER, PRIMARY KEY (author_id, book_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book_authors (author_id, book_id) VALUES (1, 0), (1, 1), (0, 0);
INSERT INTO authors (author_id, name) VALUES (1, 'default2'), (0, 'default2'), (2, 'default2'), (3, NULL), (4, 'default2'), (5, 'default1'), (6, 'default2'), (7, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT b.book_id FROM authors AS a JOIN book_authors AS b ON a.author_id = b.author_id;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT b.book_id FROM authors AS a JOIN book_authors AS b ON a.author_id = b.author_id;

/*
Prediction Result:
(0,)
(1,)
(0,)
*/