-- Schema DDL
CREATE TABLE authors (author_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (book_id INTEGER PRIMARY KEY, author_id INTEGER, year INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO authors (author_id, name) VALUES (1, 'Author_No_Books');
INSERT INTO authors (author_id, name) VALUES (2, 'Author_Only_2020');
INSERT INTO authors (author_id, name) VALUES (3, 'Author_Only_2019');
INSERT INTO authors (author_id, name) VALUES (4, 'Author_2020_And_2021');
INSERT INTO authors (author_id, name) VALUES (5, 'Author_Multiple_Non_2020');
INSERT INTO books (book_id, author_id, year) VALUES (101, 2, 2020);
INSERT INTO books (book_id, author_id, year) VALUES (102, 3, 2019);
INSERT INTO books (book_id, author_id, year) VALUES (103, 4, 2020);
INSERT INTO books (book_id, author_id, year) VALUES (104, 4, 2021);
INSERT INTO books (book_id, author_id, year) VALUES (105, 5, 2018);
INSERT INTO books (book_id, author_id, year) VALUES (106, 5, 2022);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name FROM authors AS a WHERE NOT EXISTS(SELECT * FROM books AS b1 WHERE a.author_id = b1.author_id AND EXISTS(SELECT * FROM books AS b2 WHERE b2.author_id = b1.author_id AND b2.year = 2020));

/*
Gold Result:
('Author_No_Books',)
('Author_Only_2019',)
('Author_Multiple_Non_2020',)
*/

-- Prediction Query
SELECT a.name FROM authors AS a WHERE NOT EXISTS(SELECT * FROM books AS b1 WHERE a.author_id = b1.author_id AND EXISTS(SELECT * FROM books AS b2 WHERE b2.year = 2020));

/*
Prediction Result:
('Author_No_Books',)
*/