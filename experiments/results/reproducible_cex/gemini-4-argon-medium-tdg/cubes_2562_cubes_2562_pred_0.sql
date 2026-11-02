-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicate Title handling (DISTINCT vs ALL), and anti-correlated column ordering (Title vs Issues/Writer/Book_ID).
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (3, 'Alpha', 100.0, 'Zack');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'Beta', 50.0, 'Yara');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (4, 'Beta', 10.0, 'Xavier');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'Gamma', 1.0, 'Will');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM book ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
('Beta',)
('Gamma',)
*/

-- Prediction Query
SELECT Title FROM book ORDER BY Issues ASC, book.book_id NULLS LAST;

/*
Prediction Result:
('Gamma',)
('Beta',)
('Beta',)
('Alpha',)
*/