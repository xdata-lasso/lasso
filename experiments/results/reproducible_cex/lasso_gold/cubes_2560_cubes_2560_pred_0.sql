-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1001, 'Clinical research associate', 1002.5, 'ago');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1003, NULL, NULL, NULL);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1003, 1001, 'site', 'face', 1004.5);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1001, 1003, 'election', 'dog', 1005.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT publication_id, publication_id AS book_id, publisher, publication_date, price, publisher_other, publication_date_other, price_other FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.publisher AS publisher_other, RHS.publication_date AS publication_date_other, RHS.price AS price_other FROM publication AS LHS INNER JOIN publication AS RHS ON (LHS.publication_id = RHS.book_id AND LHS.book_id = RHS.publication_id))) ORDER BY publisher;

/*
Gold Result:
('election',)
('site',)
*/

-- Prediction Query
SELECT Publisher FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('election',)
*/