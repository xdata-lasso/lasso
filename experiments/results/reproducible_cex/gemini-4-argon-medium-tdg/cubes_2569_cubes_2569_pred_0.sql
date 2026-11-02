-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'Advanced SQL', 1.0, 'Alice');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'Wiley Guide', 2.0, 'Wiley');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (10, 1, 'Wiley', '2020-01-01', 25.50);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (20, 1, 'Wiley', '2020-02-01', 15.00);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (30, 1, 'Wiley', '2020-03-01', 25.50);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (40, 2, 'Pearson', '2020-04-01', 10.00);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (50, 2, 'wiley', '2020-05-01', 30.00);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (60, 2, 'Wiley ', '2020-06-01', 35.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "price" FROM "publication" WHERE ("publisher" = 'Wiley') ORDER BY price, publication.publication_id NULLS LAST;

/*
Gold Result:
(15.0,)
(25.5,)
(25.5,)
*/

-- Prediction Query
SELECT Price FROM publication WHERE Publisher = 'Person' OR Publisher = 'Wiley';

/*
Prediction Result:
(25.5,)
(15.0,)
(25.5,)
*/