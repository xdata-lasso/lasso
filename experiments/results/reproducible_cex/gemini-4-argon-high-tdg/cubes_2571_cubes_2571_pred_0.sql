-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Modern Databases', 1200.0, 'Alice Smith');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Relational Algebra', 800.0, 'Bob Jones');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Query Optimization', 5000000.0, 'Carol White');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (1, 2, 'Gamma', '2021-01-10', 6000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (2, 3, 'Alpha', '2022-06-15', 50000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (3, 1, 'Beta', '2023-03-20', 5000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (4, 1, 'Alpha', '2020-11-05', 8000000.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (5, 2, 'Delta', '2019-05-01', 4999999.99);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (6, 3, 'Epsilon', '2018-08-12', 500000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM publication WHERE (price >= 5000000.0) ORDER BY publisher, publication.publication_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Beta',)
('Gamma',)
*/

-- Prediction Query
SELECT DISTINCT Publisher FROM publication WHERE Price > 5000000;

/*
Prediction Result:
('Gamma',)
('Alpha',)
*/