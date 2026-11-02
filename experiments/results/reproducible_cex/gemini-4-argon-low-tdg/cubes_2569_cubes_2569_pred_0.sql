-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'Algorithms', 2.0, 'Cormen');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (1, 1, 'Wiley', '2021-01-01', 50.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (2, 1, 'Wiley', '2021-02-01', 25.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (3, 1, 'Wiley', '2021-03-01', 50.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (4, 1, 'Wiley', '2021-04-01', NULL);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (5, 1, 'Wiley', '2021-05-01', NULL);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (6, 1, 'Wiley', '2021-06-01', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "price" FROM "publication" WHERE ("publisher" = 'Wiley') ORDER BY price, publication.publication_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(25.0,)
(50.0,)
(50.0,)
(100.0,)
*/

-- Prediction Query
SELECT Price FROM publication WHERE Publisher = 'Person' OR Publisher = 'Wiley';

/*
Prediction Result:
(50.0,)
(25.0,)
(50.0,)
(None,)
(None,)
(100.0,)
*/