-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'Zebra', 5.0, 'Alice');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'Alpha', 3.0, 'Bob');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (3, 'Beta', 1.0, 'Charlie');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (4, 'Alpha', 2.0, 'David');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (5, 'Gamma', 4.0, 'Eve');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (1, 3, 'PubA', '2020-01-01', 19.99);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (2, 5, 'PubB', '2021-01-01', 29.99);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (4, 5, 'PubC', '2022-01-01', 39.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM book AS LHS WHERE NOT EXISTS(SELECT 1 FROM publication AS RHS WHERE (LHS.book_id = RHS.book_id))) ORDER BY title;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT Title FROM book WHERE NOT Book_ID IN (SELECT Book_ID FROM publication);

/*
Prediction Result:
('Zebra',)
('Alpha',)
('Alpha',)
*/