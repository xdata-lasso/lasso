-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (7, 8, 'Wiley', 'Wiley10', NULL);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (6, 8, 'Person', 'Person11', NULL);
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (9, 'Wiley8', 8, 'Wiley8');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (8, 'Wiley8', 8, 'Wiley8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "price" FROM "publication" WHERE ("publisher" = 'Wiley') ORDER BY price, publication.publication_id NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Price FROM publication WHERE Publisher = 'Person' OR Publisher = 'Wiley';

/*
Prediction Result:
(None,)
(None,)
*/