-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Zeta', 15.0, 'Author D');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Alpha', 20.0, 'Author C');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Alpha', 30.0, 'Author A');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (4, 'Alpha', 10.0, 'Author B');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (5, 'Beta', 5.0, 'Author E');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (101, 1, 'Pub X', '2020-01-01', 25.5);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (102, 2, 'Pub Y', '2021-06-15', 15.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (103, 2, 'Pub Z', '2022-03-10', 18.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, issues FROM book ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
('Alpha', 20.0)
('Alpha', 30.0)
('Alpha', 10.0)
('Beta', 5.0)
('Zeta', 15.0)
*/

-- Prediction Query
SELECT Title, Issues FROM book;

/*
Prediction Result:
('Zeta', 15.0)
('Alpha', 20.0)
('Alpha', 30.0)
('Alpha', 10.0)
('Beta', 5.0)
*/