-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'B', 10.0, 'Writer 1');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'A', 20.0, 'Writer 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, issues FROM book ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
('A', 20.0)
('B', 10.0)
*/

-- Prediction Query
SELECT Title, Issues FROM book;

/*
Prediction Result:
('B', 10.0)
('A', 20.0)
*/