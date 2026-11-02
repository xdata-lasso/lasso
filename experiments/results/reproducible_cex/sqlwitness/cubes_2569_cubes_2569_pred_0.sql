-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book (book_id, title, issues, writer) VALUES (1, 'Wiley', NULL, NULL), (0, 'default2', 1.0, 'Wiley'), (2, 'default2', 1.0, 'default2'), (3, NULL, NULL, NULL), (4, 'Person', 0.0, NULL), (5, 'default1', 1.0, 'Person'), (6, NULL, NULL, 'default1'), (7, 'default2', 0.0, 'Wiley'), (8, 'default2', 0.0, 'Wiley'), (9, 'Wiley', NULL, NULL), (10, 'Wiley', NULL, 'Wiley');
INSERT INTO publication (publication_id, book_id, publisher, publication_date, price) VALUES (0, NULL, 'default2', 'default1', 0.0), (1, 0, 'default2', NULL, NULL), (2, 3, 'Person', 'Wiley', 0.0), (3, 1, 'default2', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "price" FROM "publication" WHERE ("publisher" = 'Wiley') ORDER BY price, publication.publication_id NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT Price FROM publication WHERE Publisher = 'Person' OR Publisher = 'Wiley';

/*
Prediction Result:
(0.0,)
*/