-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Charlie', 3.0, 'Writer A');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Alpha', 1.0, 'Writer B');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Bravo', 2.0, 'Writer C');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (4, 'Alpha', 4.0, 'Writer D');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (10, 2, 'Pub X', '2020-01-01', 15.5);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (20, 3, 'Pub Y', '2021-05-10', 20.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (30, 3, 'Pub Z', '2022-08-15', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM book ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Bravo',)
('Charlie',)
*/

-- Prediction Query
SELECT Title FROM book ORDER BY Issues ASC, book.book_id NULLS LAST;

/*
Prediction Result:
('Alpha',)
('Bravo',)
('Charlie',)
('Alpha',)
*/