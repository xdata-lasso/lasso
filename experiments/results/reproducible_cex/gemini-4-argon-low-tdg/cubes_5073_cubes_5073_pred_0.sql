-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Book A', 1.0, 'Writer A');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Book B', 2.0, 'Writer B');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Book C', 3.0, 'Writer C');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (1, 1, 'Pub X', '2023-03-01', 10.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (2, 2, 'Pub Y', '2023-01-01', 20.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (3, 2, 'Pub Z', '2023-01-01', 25.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (10, 3, 'Pub W', '2023-02-01', 15.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (11, 3, 'Pub W', '2023-02-01', 15.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (12, 3, 'Pub W', '2023-02-01', 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publication_date FROM (SELECT book_id, publication_date, MAX(n) AS n FROM (SELECT publication_id, book_id, publisher, publication_date, price, book_id_other, publication_id AS n FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.book_id AS book_id_other FROM publication AS LHS INNER JOIN (SELECT book_id, COUNT(*) AS n FROM publication GROUP BY book_id) AS RHS ON (LHS.publication_id = RHS.n))) GROUP BY book_id, publication_date) ORDER BY publication_date;

/*
Gold Result:
('2023-01-01',)
('2023-03-01',)
*/

-- Prediction Query
SELECT Publication_Date FROM publication GROUP BY Publication_Date ORDER BY COUNT(*) DESC, Publication_Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2023-02-01',)
*/