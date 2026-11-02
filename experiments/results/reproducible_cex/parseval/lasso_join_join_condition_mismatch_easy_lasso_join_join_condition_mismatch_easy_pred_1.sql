-- Schema DDL
CREATE TABLE authors (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE books (id INTEGER PRIMARY KEY, title TEXT, author_id INTEGER, FOREIGN KEY (author_id) REFERENCES authors (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: authors --
INSERT INTO "authors" ("id", "name") VALUES (1, 'a_s_831cf2');

INSERT INTO "authors" ("id", "name") VALUES (2, 'a_s_831cf2');

INSERT INTO "authors" ("id", "name") VALUES (3, 'a_s_831cf2');

INSERT INTO "authors" ("id", "name") VALUES (4, '5k5swwqcgs');

-- Inserting into table: books --
INSERT INTO "books" ("id", "title", "author_id") VALUES (-2147483648, 'b_s_81e0d6', 1);

INSERT INTO "books" ("id", "title", "author_id") VALUES (2, 'b_s_81e0d6', 2);

INSERT INTO "books" ("id", "title", "author_id") VALUES (3, 'b_s_81e0d6', 2);

INSERT INTO "books" ("id", "title", "author_id") VALUES (-2147483645, 'b_s_81e0d6', 4);

INSERT INTO "books" ("id", "title", "author_id") VALUES (-2147483644, 'b_s_81e0d6', 4);

INSERT INTO "books" ("id", "title", "author_id") VALUES (-2147483643, NULL, 1);

INSERT INTO "books" ("id", "title", "author_id") VALUES (-2147483642, 'b_s_81e0d6', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('a_s_831cf2', 'b_s_81e0d6')
('5k5swwqcgs', 'b_s_81e0d6')
('5k5swwqcgs', 'b_s_81e0d6')
('a_s_831cf2', None)
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = a.id;

/*
Prediction Result:
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', None)
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', None)
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', None)
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('a_s_831cf2', 'b_s_81e0d6')
('5k5swwqcgs', 'b_s_81e0d6')
('5k5swwqcgs', 'b_s_81e0d6')
('5k5swwqcgs', 'b_s_81e0d6')
('5k5swwqcgs', None)
('5k5swwqcgs', 'b_s_81e0d6')
('5k5swwqcgs', 'b_s_81e0d6')
('5k5swwqcgs', 'b_s_81e0d6')
*/