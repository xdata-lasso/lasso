-- Schema DDL
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "authors" ("id", "name") VALUES (12, '19');
INSERT INTO "authors" ("id", "name") VALUES (13, '19');
INSERT INTO "books" ("id", "author_id", "title") VALUES (11, 12, '18');
INSERT INTO "books" ("id", "author_id", "title") VALUES (10, 13, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('19', None)
('19', '18')
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = a.id;

/*
Prediction Result:
('19', None)
('19', '18')
('19', None)
('19', '18')
*/