-- Schema DDL
CREATE TABLE authors (author_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (book_id INTEGER PRIMARY KEY, author_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO books (book_id, author_id, year) VALUES (2021, 2021, 2021), (1, 2021, 2021), (0, 2019, 2021), (2020, 0, 0), (2019, 2020, 2020), (2, NULL, 2020), (3, 2020, 0), (4, 2020, 0), (5, 2019, 2019), (6, 0, 2020);
INSERT INTO authors (author_id, name) VALUES (2021, NULL), (1, 'default1'), (0, 'default1'), (2020, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name FROM authors AS a WHERE NOT EXISTS(SELECT * FROM books AS b1 WHERE a.author_id = b1.author_id AND EXISTS(SELECT * FROM books AS b2 WHERE b2.author_id = b1.author_id AND b2.year = 2020));

/*
Gold Result:
('default1',)
(None,)
*/

-- Prediction Query
SELECT a.name FROM authors AS a WHERE NOT EXISTS(SELECT * FROM books AS b1 WHERE a.author_id = b1.author_id AND EXISTS(SELECT * FROM books AS b2 WHERE b2.year = 2020));

/*
Prediction Result:
('default1',)
*/