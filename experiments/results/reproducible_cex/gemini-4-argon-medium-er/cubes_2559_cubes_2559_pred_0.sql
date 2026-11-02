-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (1, 'A', 1.0, 'Writer 1');
INSERT INTO "book" ("Book_ID", "Title", "Issues", "Writer") VALUES (2, 'B', 1.0, 'Writer 2');
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (1, 1, 'Pub 1', '2020-01-01', 10.0);
INSERT INTO "publication" ("Publication_ID", "Book_ID", "Publisher", "Publication_Date", "Price") VALUES (2, 2, 'Pub 2', '2020-01-02', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM publication AS LHS INNER JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY title;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT T1.Title FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID ORDER BY T2.Price DESC, T1.book_id NULLS LAST, T2.publication_id NULLS LAST;

/*
Prediction Result:
('B',)
('A',)
*/