-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'B', 1.0, 'W1');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'A', 1.0, 'W2');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (1, 1, 'P1', NULL, 10.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (2, 1, 'P1', '2020', 10.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (3, 2, 'P2', '2021', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, publication_date FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM publication AS LHS INNER JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY title, publication_date NULLS LAST;

/*
Gold Result:
('A', '2021')
('B', '2020')
('B', None)
*/

-- Prediction Query
SELECT T1.Title, T2.Publication_Date FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID;

/*
Prediction Result:
('B', None)
('B', '2020')
('A', '2021')
*/