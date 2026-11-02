-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1001, 'Clinical research associate', 1002.5, 'ago');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1006, 'Clinical research associate', 1002.5, 'ago');
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1003, 1001, 'site', 'face', 4000001.0);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1004, NULL, 'site', 'face', 4000001.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT writer FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM (SELECT * FROM publication WHERE (price >= 4000000.0)) AS LHS LEFT JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY writer;

/*
Gold Result:
(None,)
('ago',)
*/

-- Prediction Query
SELECT T1.Writer FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID WHERE T2.Price > 4000000;

/*
Prediction Result:
('ago',)
*/