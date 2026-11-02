-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1001, 'Clinical research associate', 1002.5, 'ago');
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1, 1001, 'site', 'face', 1003.5);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1004, 1001, 'election', 'dog', 1005.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publication_date FROM (SELECT book_id, publication_date, MAX(n) AS n FROM (SELECT publication_id, book_id, publisher, publication_date, price, book_id_other, publication_id AS n FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.book_id AS book_id_other FROM publication AS LHS INNER JOIN (SELECT book_id, COUNT(*) AS n FROM publication GROUP BY book_id) AS RHS ON (LHS.publication_id = RHS.n))) GROUP BY book_id, publication_date) ORDER BY publication_date;

/*
Gold Result:
*/

-- Prediction Query
SELECT Publication_Date FROM publication GROUP BY Publication_Date ORDER BY COUNT(*) DESC, Publication_Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('dog',)
*/