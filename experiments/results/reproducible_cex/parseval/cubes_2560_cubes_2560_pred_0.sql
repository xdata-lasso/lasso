-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: book --
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 'n8c4pgu7v');

INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1, 'e4', 779.409124, 'hria2ypuzhs');

-- Inserting into table: publication --
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1, -2147483648, 'pub_43da23', 'pub_388d24', 1.0);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483647, -2147483648, 'pub_7d0826', 'pub_567a4c', 1.0);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (2, -2147483648, 'bnp', 'mdpos', 133.007885);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (3, -2147483648, 'unw6klfa', '9000t5c4ec', 128.76421);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (4, -2147483648, 'e', '76nium52', 816.814398);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (5, 1, 'u', '4nrq', 597.420508);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT publication_id, publication_id AS book_id, publisher, publication_date, price, publisher_other, publication_date_other, price_other FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.publisher AS publisher_other, RHS.publication_date AS publication_date_other, RHS.price AS price_other FROM publication AS LHS INNER JOIN publication AS RHS ON (LHS.publication_id = RHS.book_id AND LHS.book_id = RHS.publication_id))) ORDER BY publisher;

/*
Gold Result:
*/

-- Prediction Query
SELECT Publisher FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('e',)
*/