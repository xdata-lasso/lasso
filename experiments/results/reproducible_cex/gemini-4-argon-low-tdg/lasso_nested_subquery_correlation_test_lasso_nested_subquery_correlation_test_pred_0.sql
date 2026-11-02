-- Schema DDL
CREATE TABLE authors (author_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (book_id INTEGER PRIMARY KEY, author_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core equivalence test: covers authors with no books, one 2020 book, one non-2020 book, and mixed books (both 2020 and non-2020).
-- Kills mutants using INNER JOIN, positive EXISTS, or WHERE year != 2020 without anti-join.
INSERT INTO authors (author_id, name) VALUES (1, 'NoBooks');
INSERT INTO authors (author_id, name) VALUES (2, 'Only2020');
INSERT INTO authors (author_id, name) VALUES (3, 'Only2019');
INSERT INTO authors (author_id, name) VALUES (4, 'Mixed2019And2020');
INSERT INTO books (book_id, author_id, year) VALUES (101, 2, 2020);
INSERT INTO books (book_id, author_id, year) VALUES (102, 3, 2019);
INSERT INTO books (book_id, author_id, year) VALUES (103, 4, 2019);
INSERT INTO books (book_id, author_id, year) VALUES (104, 4, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name FROM authors AS a WHERE NOT EXISTS(SELECT * FROM books AS b1 WHERE a.author_id = b1.author_id AND EXISTS(SELECT * FROM books AS b2 WHERE b2.author_id = b1.author_id AND b2.year = 2020));

/*
Gold Result:
('NoBooks',)
('Only2019',)
*/

-- Prediction Query
SELECT a.name FROM authors AS a WHERE NOT EXISTS(SELECT * FROM books AS b1 WHERE a.author_id = b1.author_id AND EXISTS(SELECT * FROM books AS b2 WHERE b2.year = 2020));

/*
Prediction Result:
('NoBooks',)
*/