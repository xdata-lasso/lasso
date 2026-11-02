-- Schema DDL
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "authors" ("id", "name") VALUES (1003, 'Brian Yang');
INSERT INTO "authors" ("id", "name") VALUES (1005, 'Brian Yang');
INSERT INTO "books" ("id", "title", "author_id") VALUES (1004, 'Sports administrator', 1003);
INSERT INTO "books" ("id", "title", "author_id") VALUES (1006, 'Sports administrator', 1005);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('Brian Yang', 'Sports administrator')
('Brian Yang', 'Sports administrator')
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = a.id;

/*
Prediction Result:
('Brian Yang', 'Sports administrator')
('Brian Yang', 'Sports administrator')
('Brian Yang', 'Sports administrator')
('Brian Yang', 'Sports administrator')
*/