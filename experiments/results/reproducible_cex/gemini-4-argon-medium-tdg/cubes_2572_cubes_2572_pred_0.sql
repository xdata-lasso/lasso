-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Book Exact', 1.0, 'Writer Z');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Book High', 2.0, 'Writer A');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Book Low', 3.0, 'Writer M');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (101, 1, 'Pub A', '2023-01-01', 4000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (102, 2, 'Pub B', '2023-01-02', 4500000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (103, 3, 'Pub C', '2023-01-03', 3999999.9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT writer FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM (SELECT * FROM publication WHERE (price >= 4000000.0)) AS LHS LEFT JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY writer;

/*
Gold Result:
('Writer A',)
('Writer Z',)
*/

-- Prediction Query
SELECT T1.Writer FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID WHERE T2.Price > 4000000;

/*
Prediction Result:
('Writer A',)
*/