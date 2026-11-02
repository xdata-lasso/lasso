-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (10, 'Title_A', 5000000.0, 'Charlie');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (20, 'Title_B', 10.0, 'Zebra');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (30, 'Title_C', 20.0, 'Alpha');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (1, 10, 'Pub_X', '2020-01-01', 3999999.9);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (2, 20, 'Pub_Y', '2021-01-01', 4000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (3, 30, 'Pub_Z', '2022-01-01', 4500000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT writer FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM (SELECT * FROM publication WHERE (price >= 4000000.0)) AS LHS LEFT JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY writer;

/*
Gold Result:
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT T1.Writer FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID WHERE T2.Price > 4000000;

/*
Prediction Result:
('Alpha',)
*/