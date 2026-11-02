-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Book One', 1.0, 'Writer A');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (1, 1, 'Pub_Exact_10M', '2020-01-01', 10000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (2, 1, 'Pub_Above_10M', '2020-01-02', 15000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (3, 1, 'Pub_Just_Below_10M', '2020-01-03', 9999999.9);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (4, 1, 'Pub_Exact_5M', '2020-01-04', 5000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (5, 1, 'Pub_Below_5M', '2020-01-05', 1000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (6, 1, 'Pub_Null_Price', '2020-01-06', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM publication WHERE (price >= 10000000.0 AND price <> 5000000.0) ORDER BY publisher, publication.publication_id NULLS LAST;

/*
Gold Result:
('Pub_Above_10M',)
('Pub_Exact_10M',)
*/

-- Prediction Query
SELECT Publisher FROM publication WHERE Price > 10000000 INTERSECT SELECT Publisher FROM publication WHERE Price < 5000000;

/*
Prediction Result:
*/