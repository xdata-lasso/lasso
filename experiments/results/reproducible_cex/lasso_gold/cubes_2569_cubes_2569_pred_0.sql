-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1046, 'Designer, jewellery', 1047.5, 'save');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1050, 'Librarian, public', 1051.5, 'fall');
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1048, 1046, 'Wiley', 'clearly', 1050.5);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1052, 1050, 'Wiley', 'knowledge', 1049.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "price" FROM "publication" WHERE ("publisher" = 'Wiley') ORDER BY price, publication.publication_id NULLS LAST;

/*
Gold Result:
(1049.5,)
(1050.5,)
*/

-- Prediction Query
SELECT Price FROM publication WHERE Publisher = 'Person' OR Publisher = 'Wiley';

/*
Prediction Result:
(1050.5,)
(1049.5,)
*/