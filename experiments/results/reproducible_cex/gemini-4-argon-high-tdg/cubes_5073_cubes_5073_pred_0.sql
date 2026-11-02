-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (100, 'Book A', 1.0, 'Writer A');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (200, 'Book B', 2.0, 'Writer B');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (300, 'Book C', 3.0, 'Writer C');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (400, 'Book D', 4.0, 'Writer D');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (10, 100, 'Pub X', '2018-01-01', 15.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (1, 200, 'Pub Y', '2023-12-01', 25.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (20, 200, 'Pub Y', '2019-05-01', 20.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (2, 300, 'Pub Z', '2021-06-15', 30.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (30, 300, 'Pub Z', '2020-03-10', 10.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (31, 300, 'Pub Z', '2022-09-20', 12.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publication_date FROM (SELECT book_id, publication_date, MAX(n) AS n FROM (SELECT publication_id, book_id, publisher, publication_date, price, book_id_other, publication_id AS n FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.book_id AS book_id_other FROM publication AS LHS INNER JOIN (SELECT book_id, COUNT(*) AS n FROM publication GROUP BY book_id) AS RHS ON (LHS.publication_id = RHS.n))) GROUP BY book_id, publication_date) ORDER BY publication_date;

/*
Gold Result:
('2021-06-15',)
('2023-12-01',)
*/

-- Prediction Query
SELECT Publication_Date FROM publication GROUP BY Publication_Date ORDER BY COUNT(*) DESC, Publication_Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2018-01-01',)
*/