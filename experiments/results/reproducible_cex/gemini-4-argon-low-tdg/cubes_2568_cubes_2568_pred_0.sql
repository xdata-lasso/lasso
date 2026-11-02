-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Zeta', 1.0, 'Writer A');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Alpha', 2.0, 'Writer B');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Alpha', 3.0, 'Writer C');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (4, 'Beta', 4.0, 'Writer D');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (101, 4, 'Pub X', '2020-01-01', 10.5);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (102, 4, 'Pub Y', '2021-01-01', 12.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM book AS LHS WHERE NOT EXISTS(SELECT 1 FROM publication AS RHS WHERE (LHS.book_id = RHS.book_id))) ORDER BY title;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT Title FROM book WHERE NOT Book_ID IN (SELECT Book_ID FROM publication);

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Alpha',)
*/