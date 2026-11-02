-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Book One', 1.0, 'Author A');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Book Two', 2.0, 'Author B');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Book Three', 3.0, 'Author C');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (4, 'Book Four', 4.0, 'Author D');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (5, 'Book Five', 5.0, 'Author E');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (10, 4, 'Alpha', '2022-05-10', 25.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (20, 4, 'Beta', '2019-01-15', 15.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (30, 2, 'Gamma', '2019-01-15', 30.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (40, 5, 'Delta', '2020-08-20', 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT publication_date FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, LHS.n AS n, RHS.publication_id AS publication_id_other, RHS.publisher AS publisher_other, RHS.price AS price_other FROM (SELECT publication_id, book_id, publisher, publication_date, price, COUNT(*) OVER () AS n FROM publication) AS LHS INNER JOIN publication AS RHS ON (LHS.n = RHS.book_id AND LHS.publication_date = RHS.publication_date)) ORDER BY publication_date;

/*
Gold Result:
('2019-01-15',)
('2022-05-10',)
*/

-- Prediction Query
SELECT Publication_Date FROM publication GROUP BY Publication_Date ORDER BY COUNT(*) DESC, Publication_Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2019-01-15',)
*/