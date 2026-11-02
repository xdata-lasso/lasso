-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: book --
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 'n8c4pgu7v');

INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1, 'hria2ypuzhs', 663.049759, 'wbbp6luhvdlt');

-- Inserting into table: publication --
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1, -2147483648, 'pub_43da23', 'e4', 1.0);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (2, -2147483648, '5u', 'w6kl', 83.204633);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (3, -2147483648, '9000t5c4ec', 'gce', 467.07027);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (4, -2147483648, 'um5', 'zbuo4nrq', 597.420508);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (5, -2147483648, 'fqyp5s5bbp0', '2eutliqa11r', 997.73177);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (6, 1, 'oo3o9', 'l7', 443.457804);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (7, -2147483648, 'ex1', 'ji7zwau2', 920.013763);
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
('2eutliqa11r',)
*/