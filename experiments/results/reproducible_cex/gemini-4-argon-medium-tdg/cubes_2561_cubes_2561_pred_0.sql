-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'Book A', 1.0, 'Writer 1');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'Book B', 2.0, 'Writer 2');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (3, 'Book C', 3.0, 'Writer 3');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (4, 'Book D', 4.0, 'Writer 4');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (5, 'Book E', 5.0, 'Writer 5');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (10, 5, 'Pub X', '2023-05-01', 15.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (20, 5, 'Pub Y', '2023-05-01', 20.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (30, 5, 'Pub Z', '2021-01-01', 25.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (40, 1, 'Pub W', '2022-06-15', 30.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (50, 2, 'Pub V', '2020-12-31', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT publication_date FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, LHS.n AS n, RHS.publication_id AS publication_id_other, RHS.publisher AS publisher_other, RHS.price AS price_other FROM (SELECT publication_id, book_id, publisher, publication_date, price, COUNT(*) OVER () AS n FROM publication) AS LHS INNER JOIN publication AS RHS ON (LHS.n = RHS.book_id AND LHS.publication_date = RHS.publication_date)) ORDER BY publication_date;

/*
Gold Result:
('2021-01-01',)
('2023-05-01',)
*/

-- Prediction Query
SELECT Publication_Date FROM publication GROUP BY Publication_Date ORDER BY COUNT(*) DESC, Publication_Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2023-05-01',)
*/