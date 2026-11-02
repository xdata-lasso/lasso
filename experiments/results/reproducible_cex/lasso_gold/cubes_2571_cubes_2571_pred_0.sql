-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1001, 'Clinical research associate', 1002.5, 'ago');
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1003, 1001, 'site', 'face', 5000000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM publication WHERE (price >= 5000000.0) ORDER BY publisher, publication.publication_id NULLS LAST;

/*
Gold Result:
('site',)
*/

-- Prediction Query
SELECT DISTINCT Publisher FROM publication WHERE Price > 5000000;

/*
Prediction Result:
*/