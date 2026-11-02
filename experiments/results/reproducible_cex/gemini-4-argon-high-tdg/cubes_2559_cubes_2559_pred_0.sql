-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Charlie', 20.0, 'W2');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Alpha', 10.0, 'W3');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Bravo', 30.0, 'W1');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (4, 'Delta', 40.0, 'W4');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (101, 3, 'Pub_C', '2023-01-01', 30.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (102, 1, 'Pub_A', '2020-01-01', 10.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (103, 2, 'Pub_B', '2021-01-01', 20.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (104, NULL, 'Pub_D', '2019-01-01', 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM publication AS LHS INNER JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY title;

/*
Gold Result:
('Alpha',)
('Bravo',)
('Charlie',)
*/

-- Prediction Query
SELECT T1.Title FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID ORDER BY T2.Price DESC, T1.book_id NULLS LAST, T2.publication_id NULLS LAST;

/*
Prediction Result:
('Bravo',)
('Alpha',)
('Charlie',)
*/