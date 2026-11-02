-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: book --
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 'n8c4pgu7v');

-- Inserting into table: publication --
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1, -2147483648, 'pub_d4d2f7', 'e4', 5000000.0);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (-2147483647, -2147483648, 'pub_d4d2f7', 'a2y', 5000000.0);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (2, -2147483648, 'sr', 'wbbp6luhvdlt', 4999999.99);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (3, -2147483648, 'lbn', 'rmdp', NULL);

INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (4, -2147483648, NULL, 'siie5unw6k', 5000000.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM publication WHERE (price >= 5000000.0) ORDER BY publisher, publication.publication_id NULLS LAST;

/*
Gold Result:
(None,)
('pub_d4d2f7',)
('pub_d4d2f7',)
*/

-- Prediction Query
SELECT DISTINCT Publisher FROM publication WHERE Price > 5000000;

/*
Prediction Result:
*/