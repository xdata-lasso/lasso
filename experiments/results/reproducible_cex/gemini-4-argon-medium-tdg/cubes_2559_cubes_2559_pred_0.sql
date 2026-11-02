-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs LEFT/RIGHT/OUTER JOIN (unmatched books, NULL book_id in publication),
-- DISTINCT vs ALL (1-to-many publications per book, and duplicate titles across different books),
-- and basic ascending ORDER BY on Title.
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Zebra', 5.0, 'Alice');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Alpha', 1.0, 'Bob');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Beta', 2.0, 'Charlie');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (4, 'Alpha', 3.0, 'David');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (10, 1, 'PubC', '2023-01-01', 15.5);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (20, 2, 'PubA', '2022-05-10', 25.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (30, 2, 'PubB', '2021-03-15', 30.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (40, 4, 'PubD', '2020-11-20', 10.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (50, NULL, 'PubE', '2019-07-07', 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM publication AS LHS INNER JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY title;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT T1.Title FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID ORDER BY T2.Price DESC, T1.book_id NULLS LAST, T2.publication_id NULLS LAST;

/*
Prediction Result:
('Alpha',)
('Alpha',)
('Zebra',)
('Alpha',)
*/