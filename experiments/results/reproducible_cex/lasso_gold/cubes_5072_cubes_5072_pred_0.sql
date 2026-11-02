-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1056, 'Armed forces logistics/support/administrative officer', 1059.5, 'capital');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1057, 'Psychiatric nurse', 1066.5, 'win');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1058, 'Software engineer', 1073.5, 'human');
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1062, 1056, 'bar', 'themselves', NULL);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1063, 1056, 'old', 'production', NULL);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1064, 1056, 'finally', 'present', NULL);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1068, 1056, 'value', 'participant', NULL);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1069, 1056, 'training', 'dark', NULL);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1070, 1056, 'high', 'sea', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT publisher FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.publication_id AS publication_id_other, RHS.book_id AS book_id_other, RHS.publisher AS publisher_other, RHS.publication_date AS publication_date_other, RHS.price AS price_other FROM publication AS LHS CROSS JOIN (SELECT publication_id, book_id, publisher, publication_date, MAX(price) OVER () AS price FROM publication) AS RHS) WHERE (price >= price_other) ORDER BY publisher;

/*
Gold Result:
*/

-- Prediction Query
SELECT Publisher FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('bar',)
*/