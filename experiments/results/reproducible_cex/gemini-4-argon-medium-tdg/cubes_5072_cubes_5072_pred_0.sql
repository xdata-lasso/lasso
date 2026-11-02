-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic maximum price filtering, tie-breaking for max price across distinct publishers, and alphabetical ordering.
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'The Art of SQL', 1.0, 'Alice');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'Database Internals', 2.0, 'Bob');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (1, 1, 'Zeta Press', '2020-01-01', 50.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (2, 1, 'Alpha Books', '2021-01-01', 50.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (3, 2, 'Beta House', '2022-01-01', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT publisher FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.publication_id AS publication_id_other, RHS.book_id AS book_id_other, RHS.publisher AS publisher_other, RHS.publication_date AS publication_date_other, RHS.price AS price_other FROM publication AS LHS CROSS JOIN (SELECT publication_id, book_id, publisher, publication_date, MAX(price) OVER () AS price FROM publication) AS RHS) WHERE (price >= price_other) ORDER BY publisher;

/*
Gold Result:
('Alpha Books',)
('Zeta Press',)
*/

-- Prediction Query
SELECT Publisher FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta Press',)
*/