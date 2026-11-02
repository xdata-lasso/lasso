-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: book --
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 'n8c4pgu7v');

-- Inserting into table: publication --
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483648, -2147483648, 'e4', 'pub_9b5648', 779.409124);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483647, -2147483648, 'ia2yp', 'pub_9b5648', 718.397869);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483646, -2147483648, 'hsrwbbp', 'pub_9b5648', 503.083789);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (2, -2147483648, 'hvdlttilbnpr', 'pub_9b5648', 986.066566);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (3, -2147483648, 'posiie5unw6k', 'pub_9b5648', 768.216462);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483645, -2147483648, 'a9000t5c4eci', 'pub_9b5648', 734.586266);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483642, -2147483648, 'e', 'G', 467.07027);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483641, -2147483648, 'um5', 'G', 452.706544);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483640, -2147483648, 'u', 'A', 225.300904);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483639, -2147483648, 'rqrofqyp5s', 'O', 499.570479);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483638, -2147483648, 'p', 'O', 705.580387);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483637, -2147483648, 'eutliqa11r', 'A', 997.73177);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483636, -2147483648, 'oo3o9', 'G', 111.926013);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483635, -2147483648, 'lex', 'G', 913.303855);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483634, -2147483648, 'i7z', 'A', 353.163664);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483633, -2147483648, '2dwyrq', 'G', 433.533777);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483632, -2147483648, 'yu78', 'G', 49.538289);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483631, -2147483648, 'jsl', 'A', 419.361606);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483630, -2147483648, 'p5qi2rk', NULL, 811.601922);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483629, -2147483648, 'vqx58pz0f', NULL, 707.476301);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483628, -2147483648, 'gd', NULL, 452.27611);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483627, -2147483648, 'y9uxj4', 'pub_9b5648', 124.573829);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483626, -2147483648, 'v', 'pub_9b5648', 185.427628);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483625, -2147483648, 'h2gndqwnqcx5', 'pub_9b5648', 635.267184);
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
('pub_9b5648',)
*/