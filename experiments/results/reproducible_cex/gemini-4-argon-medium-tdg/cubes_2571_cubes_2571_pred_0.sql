-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Book One', 1.0, 'Writer A');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (1, 1, 'Zeta Pub', '2020-01-01', 5000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (2, 1, 'Alpha Pub', '2020-01-02', 5000000.01);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (3, 1, 'Beta Pub', '2020-01-03', 4999999.99);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (4, 1, 'Alpha Pub', '2020-01-04', 6000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (5, 1, 'Gamma Pub', '2020-01-05', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM publication WHERE (price >= 5000000.0) ORDER BY publisher, publication.publication_id NULLS LAST;

/*
Gold Result:
('Alpha Pub',)
('Alpha Pub',)
('Zeta Pub',)
*/

-- Prediction Query
SELECT DISTINCT Publisher FROM publication WHERE Price > 5000000;

/*
Prediction Result:
('Alpha Pub',)
*/