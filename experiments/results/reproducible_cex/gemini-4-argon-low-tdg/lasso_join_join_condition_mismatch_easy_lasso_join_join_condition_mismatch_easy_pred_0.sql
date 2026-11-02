-- Schema DDL
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO authors (id, name) VALUES (1, 'George Orwell');
INSERT INTO authors (id, name) VALUES (2, 'Aldous Huxley');
INSERT INTO authors (id, name) VALUES (3, 'Unpublished Author');
INSERT INTO books (id, title, author_id) VALUES (1, 'Brave New World', 2);
INSERT INTO books (id, title, author_id) VALUES (2, '1984', 1);
INSERT INTO books (id, title, author_id) VALUES (3, 'Animal Farm', 1);
INSERT INTO books (id, title, author_id) VALUES (4, 'Anonymous Book', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('Aldous Huxley', 'Brave New World')
('George Orwell', '1984')
('George Orwell', 'Animal Farm')
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.id;

/*
Prediction Result:
('George Orwell', 'Brave New World')
('Aldous Huxley', '1984')
('Unpublished Author', 'Animal Farm')
*/