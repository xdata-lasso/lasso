-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (8, NULL, NULL, '13', 5000000);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (7, 11, NULL, '15', 5000001);
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (10, '14', 14, '14');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (11, '14', 14, '14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM publication WHERE (price >= 5000000.0) ORDER BY publisher, publication.publication_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT DISTINCT Publisher FROM publication WHERE Price > 5000000;

/*
Prediction Result:
(None,)
*/