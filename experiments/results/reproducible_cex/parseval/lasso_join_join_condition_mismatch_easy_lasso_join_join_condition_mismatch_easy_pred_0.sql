-- Schema DDL
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: authors --
INSERT INTO "authors" ("id", "name") VALUES (1, 'a_s_85d775');

INSERT INTO "authors" ("id", "name") VALUES (3, 'a_s_85d775');

INSERT INTO "authors" ("id", "name") VALUES (2, 'a_s_85d775');

INSERT INTO "authors" ("id", "name") VALUES (4, '5k5swwqcgs');

-- Inserting into table: books --
INSERT INTO "books" ("id", "title", "author_id") VALUES (-2147483648, 'b_s_a73bf9', 1);

INSERT INTO "books" ("id", "title", "author_id") VALUES (2, 'b_s_a73bf9', 1);

INSERT INTO "books" ("id", "title", "author_id") VALUES (3, 'b_s_a73bf9', 1);

INSERT INTO "books" ("id", "title", "author_id") VALUES (-2147483645, 'b_s_a73bf9', 4);

INSERT INTO "books" ("id", "title", "author_id") VALUES (-2147483644, 'b_s_a73bf9', 4);

INSERT INTO "books" ("id", "title", "author_id") VALUES (-2147483643, 'b_s_a73bf9', 1);

INSERT INTO "books" ("id", "title", "author_id") VALUES (-2147483642, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('a_s_85d775', 'b_s_a73bf9')
('5k5swwqcgs', 'b_s_a73bf9')
('5k5swwqcgs', 'b_s_a73bf9')
('a_s_85d775', 'b_s_a73bf9')
('a_s_85d775', None)
('a_s_85d775', 'b_s_a73bf9')
('a_s_85d775', 'b_s_a73bf9')
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.id;

/*
Prediction Result:
('a_s_85d775', 'b_s_a73bf9')
('a_s_85d775', 'b_s_a73bf9')
*/