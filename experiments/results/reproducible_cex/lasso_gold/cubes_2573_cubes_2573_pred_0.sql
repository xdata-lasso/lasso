-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1024, 'Town planner', 1025.5, 'agreement');
INSERT INTO "book" ("book_id", "title", "issues", "writer") VALUES (1032, 'Theme park manager', 1033.5, 'fall');
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1026, 1024, 'option', 'decide', 1027.5);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1030, 1024, 'discussion', 'list', 1031.5);
INSERT INTO "publication" ("publication_id", "book_id", "publisher", "publication_date", "price") VALUES (1034, 1032, 'table', 'true', 1035.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, publication_date FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM publication AS LHS INNER JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY title, publication_date NULLS LAST;

/*
Gold Result:
('Theme park manager', 'true')
('Town planner', 'decide')
('Town planner', 'list')
*/

-- Prediction Query
SELECT T1.Title, T2.Publication_Date FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID;

/*
Prediction Result:
('Town planner', 'decide')
('Town planner', 'list')
('Theme park manager', 'true')
*/