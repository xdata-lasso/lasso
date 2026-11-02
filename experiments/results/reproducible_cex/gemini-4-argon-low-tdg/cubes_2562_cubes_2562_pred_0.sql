-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Zeta', 1.0, 'Alice');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Alpha', 3.0, 'Charlie');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Beta', 2.0, 'Bob');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM book ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT Title FROM book ORDER BY Issues ASC, book.book_id NULLS LAST;

/*
Prediction Result:
('Zeta',)
('Beta',)
('Alpha',)
*/