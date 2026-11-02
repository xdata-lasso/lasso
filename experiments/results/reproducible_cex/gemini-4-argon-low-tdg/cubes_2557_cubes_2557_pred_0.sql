-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'Zebra', 10.5, 'Author A');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'Apple', 20.0, 'Author B');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (3, 'Mango', 5.0, 'Author C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, issues FROM book ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
('Apple', 20.0)
('Mango', 5.0)
('Zebra', 10.5)
*/

-- Prediction Query
SELECT Title, Issues FROM book;

/*
Prediction Result:
('Zebra', 10.5)
('Apple', 20.0)
('Mango', 5.0)
*/