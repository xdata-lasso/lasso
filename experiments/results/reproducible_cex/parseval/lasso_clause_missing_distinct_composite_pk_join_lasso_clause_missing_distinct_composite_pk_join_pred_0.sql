-- Schema DDL
CREATE TABLE authors (author_id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE book_authors (author_id INTEGER, book_id INTEGER, PRIMARY KEY (author_id, book_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: authors --
INSERT INTO "authors" ("author_id", "name") VALUES (1, '5k5swwqcgs');

INSERT INTO "authors" ("author_id", "name") VALUES (-2147483647, '9n8');

INSERT INTO "authors" ("author_id", "name") VALUES (2, '4');

INSERT INTO "authors" ("author_id", "name") VALUES (4, 'gu7v');

INSERT INTO "authors" ("author_id", "name") VALUES (5, 'e4');

-- Inserting into table: book_authors --
INSERT INTO "book_authors" ("author_id", "book_id") VALUES (1, 1);

INSERT INTO "book_authors" ("author_id", "book_id") VALUES (3, 1);

INSERT INTO "book_authors" ("author_id", "book_id") VALUES (1, -2147483647);

INSERT INTO "book_authors" ("author_id", "book_id") VALUES (4, 6);

INSERT INTO "book_authors" ("author_id", "book_id") VALUES (5, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT b.book_id FROM authors AS a JOIN book_authors AS b ON a.author_id = b.author_id;

/*
Gold Result:
(1,)
(-2147483647,)
(6,)
*/

-- Prediction Query
SELECT b.book_id FROM authors AS a JOIN book_authors AS b ON a.author_id = b.author_id;

/*
Prediction Result:
(1,)
(-2147483647,)
(6,)
(6,)
*/