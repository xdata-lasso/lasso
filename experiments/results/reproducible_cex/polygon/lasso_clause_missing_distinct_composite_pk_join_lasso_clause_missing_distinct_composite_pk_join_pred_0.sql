-- Schema DDL
CREATE TABLE authors (author_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE book_authors (author_id INTEGER, book_id INTEGER, PRIMARY KEY (author_id, book_id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "authors" ("author_id", "name") VALUES (12, NULL);
INSERT INTO "authors" ("author_id", "name") VALUES (11, '18');
INSERT INTO "book_authors" ("author_id", "book_id") VALUES (12, 19);
INSERT INTO "book_authors" ("author_id", "book_id") VALUES (11, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT b.book_id FROM authors AS a JOIN book_authors AS b ON a.author_id = b.author_id;

/*
Gold Result:
(19,)
*/

-- Prediction Query
SELECT b.book_id FROM authors AS a JOIN book_authors AS b ON a.author_id = b.author_id;

/*
Prediction Result:
(19,)
(19,)
*/