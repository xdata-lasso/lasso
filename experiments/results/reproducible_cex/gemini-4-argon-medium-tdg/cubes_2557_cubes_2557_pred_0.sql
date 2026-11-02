-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Title, secondary ordering by Book_ID (with different Issues to make row order observable), and NULL handling in Title and Issues.
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'B_Title', 10.5, 'Author X');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'A_Title', 20.0, 'Author Y');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'A_Title', 30.0, 'Author Z');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (4, NULL, 15.0, 'Author W');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (5, 'C_Title', NULL, 'Author V');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, issues FROM book ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
(None, 15.0)
('A_Title', 30.0)
('A_Title', 20.0)
('B_Title', 10.5)
('C_Title', None)
*/

-- Prediction Query
SELECT Title, Issues FROM book;

/*
Prediction Result:
('B_Title', 10.5)
('A_Title', 30.0)
('A_Title', 20.0)
(None, 15.0)
('C_Title', None)
*/