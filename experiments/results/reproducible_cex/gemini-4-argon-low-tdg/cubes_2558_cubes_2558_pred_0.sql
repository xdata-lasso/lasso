-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (10, 'Dune', 1.0, 'Frank Herbert');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'Dune', 2.0, 'Brian Herbert');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (5, 'Alpha', 3.0, 'Zack');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'Zeta', 4.0, 'Aaron');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (1, 10, 'Chilton', '1965-08-01', 9.99);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (2, 10, 'Ace', '1990-01-01', 14.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM "book" WHERE ("writer" <> 'Elaine Lee') ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Dune',)
('Dune',)
('Zeta',)
*/

-- Prediction Query
SELECT Title FROM book WHERE Writer <> 'Elaine Lee';

/*
Prediction Result:
('Zeta',)
('Dune',)
('Alpha',)
('Dune',)
*/