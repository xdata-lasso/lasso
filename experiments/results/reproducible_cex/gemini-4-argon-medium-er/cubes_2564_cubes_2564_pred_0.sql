-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'Book A', 1.0, 'Writer A');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (1, 1, 'Pub A', '2023-01-01', 10000000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM publication WHERE (price >= 10000000.0 AND price <> 5000000.0) ORDER BY publisher, publication.publication_id NULLS LAST;

/*
Gold Result:
('Pub A',)
*/

-- Prediction Query
SELECT Publisher FROM publication WHERE Price > 10000000 INTERSECT SELECT Publisher FROM publication WHERE Price < 5000000;

/*
Prediction Result:
*/