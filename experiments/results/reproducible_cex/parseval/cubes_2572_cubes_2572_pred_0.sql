-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: book --
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1, 'rhs_2421ce', 1.0, 'rhs_bf8274');

INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (-2147483647, 'rhs_b25231', 1.0, 'rhs_61a0ea');

-- Inserting into table: publication --
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1, 1, 'pub_6059fe', 'pub_77aafb', 4000000.0);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483647, 1, 'pub_715aff', 'pub_4e04c8', 4000000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT writer FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM (SELECT * FROM publication WHERE (price >= 4000000.0)) AS LHS LEFT JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY writer;

/*
Gold Result:
('rhs_bf8274',)
('rhs_bf8274',)
*/

-- Prediction Query
SELECT T1.Writer FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID WHERE T2.Price > 4000000;

/*
Prediction Result:
*/