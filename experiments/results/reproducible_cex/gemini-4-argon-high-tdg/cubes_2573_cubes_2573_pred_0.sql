-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Zeta Chronicles', 3.0, 'Alice Munro');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Alpha Odyssey', 1.0, 'Bob Vance');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Unpublished Work', 5.0, 'Charlie Day');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (10, 1, 'Pearson', '2021-06-15', 29.99);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (1, 2, 'Penguin', '2023-01-10', 19.99);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (2, 2, 'Harper', NULL, 15.50);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (3, 2, 'Vintage', '2019-11-20', 12.00);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (4, NULL, 'Orphan Press', '2020-05-05', 9.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, publication_date FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM publication AS LHS INNER JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY title, publication_date NULLS LAST;

/*
Gold Result:
('Alpha Odyssey', '2019-11-20')
('Alpha Odyssey', '2023-01-10')
('Alpha Odyssey', None)
('Zeta Chronicles', '2021-06-15')
*/

-- Prediction Query
SELECT T1.Title, T2.Publication_Date FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID;

/*
Prediction Result:
('Alpha Odyssey', '2023-01-10')
('Alpha Odyssey', None)
('Alpha Odyssey', '2019-11-20')
('Zeta Chronicles', '2021-06-15')
*/