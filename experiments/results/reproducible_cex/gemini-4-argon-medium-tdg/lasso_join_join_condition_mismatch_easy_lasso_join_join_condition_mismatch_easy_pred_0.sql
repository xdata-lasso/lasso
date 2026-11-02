-- Schema DDL
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, outer join mutations (unmatched author, unmatched book with NULL author_id), and wrong join key mutations (a.id = b.id)
INSERT INTO authors (id, name) VALUES (1, 'George Orwell');
INSERT INTO authors (id, name) VALUES (2, 'Aldous Huxley');
INSERT INTO authors (id, name) VALUES (3, 'Unpublished Author');
INSERT INTO books (id, title, author_id) VALUES (10, '1984', 1);
INSERT INTO books (id, title, author_id) VALUES (1, 'Brave New World', 2);
INSERT INTO books (id, title, author_id) VALUES (2, 'Anonymous Book', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('Aldous Huxley', 'Brave New World')
('George Orwell', '1984')
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.id;

/*
Prediction Result:
('George Orwell', 'Brave New World')
('Aldous Huxley', 'Anonymous Book')
*/