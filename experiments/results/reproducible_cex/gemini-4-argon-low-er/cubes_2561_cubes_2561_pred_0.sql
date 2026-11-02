-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'A', 1.0, 'W');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (1, 2, 'P', '2020-01-01', 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT publication_date FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, LHS.n AS n, RHS.publication_id AS publication_id_other, RHS.publisher AS publisher_other, RHS.price AS price_other FROM (SELECT publication_id, book_id, publisher, publication_date, price, COUNT(*) OVER () AS n FROM publication) AS LHS INNER JOIN publication AS RHS ON (LHS.n = RHS.book_id AND LHS.publication_date = RHS.publication_date)) ORDER BY publication_date;

/*
Gold Result:
*/

-- Prediction Query
SELECT Publication_Date FROM publication GROUP BY Publication_Date ORDER BY COUNT(*) DESC, Publication_Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('2020-01-01',)
*/