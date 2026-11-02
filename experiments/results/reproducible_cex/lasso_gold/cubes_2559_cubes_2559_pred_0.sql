-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1036, 'Accounting technician', 1037.5, 'song');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1046, NULL, NULL, NULL);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1038, 1036, 'sure', 'collection', 1039.5);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1040, 1046, 'sure', 'collection', 1039.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM publication AS LHS INNER JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY title;

/*
Gold Result:
(None,)
('Accounting technician',)
*/

-- Prediction Query
SELECT T1.Title FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID ORDER BY T2.Price DESC, T1.book_id NULLS LAST, T2.publication_id NULLS LAST;

/*
Prediction Result:
('Accounting technician',)
(None,)
*/