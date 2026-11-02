-- Schema DDL
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "authors" ("id", "name") VALUES (10, NULL);
INSERT INTO "authors" ("id", "name") VALUES (11, NULL);
INSERT INTO "books" ("id", "author_id", "title") VALUES (11, 10, NULL);
INSERT INTO "books" ("id", "author_id", "title") VALUES (10, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.id;

/*
Prediction Result:
(None, None)
(None, None)
*/