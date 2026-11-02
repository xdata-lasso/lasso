-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1006, 'Sports administrator', 1007.5, 'chair');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1008, 'Environmental health practitioner', 1008.5, 'require');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, issues FROM book ORDER BY title, book.book_id NULLS LAST;

/*
Gold Result:
('Environmental health practitioner', 1008.5)
('Sports administrator', 1007.5)
*/

-- Prediction Query
SELECT Title, Issues FROM book;

/*
Prediction Result:
('Sports administrator', 1007.5)
('Environmental health practitioner', 1008.5)
*/