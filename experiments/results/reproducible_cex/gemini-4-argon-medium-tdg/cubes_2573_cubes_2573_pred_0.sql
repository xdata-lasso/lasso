-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs OUTER JOIN (books without publications, publications with NULL book_id), basic ordering, and duplicates (SELECT vs SELECT DISTINCT).
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Bravo', 2.0, 'Writer B');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Alpha', 1.0, 'Writer A');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Charlie', 3.0, 'Writer C');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (10, 1, 'Pub X', '2022-05-01', 15.5);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (20, 2, 'Pub Y', '2021-01-01', 20.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (30, 2, 'Pub Z', '2021-01-01', 25.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (40, NULL, 'Pub W', '2020-01-01', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, publication_date FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM publication AS LHS INNER JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY title, publication_date NULLS LAST;

/*
Gold Result:
('Alpha', '2021-01-01')
('Alpha', '2021-01-01')
('Bravo', '2022-05-01')
*/

-- Prediction Query
SELECT T1.Title, T2.Publication_Date FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID;

/*
Prediction Result:
('Bravo', '2022-05-01')
('Alpha', '2021-01-01')
('Alpha', '2021-01-01')
*/