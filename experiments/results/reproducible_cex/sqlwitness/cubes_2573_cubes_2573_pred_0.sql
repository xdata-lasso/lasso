-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book (book_id, title, issues, writer) VALUES (1, 'default1', 1.0, NULL), (0, 'default2', NULL, 'default2'), (2, NULL, 0.0, NULL);
INSERT INTO publication (publication_id, book_id, publisher, publication_date, price) VALUES (1, 2, 'default1', NULL, 0.0), (0, NULL, 'default2', NULL, 0.0), (2, 0, 'default1', 'default2', NULL), (3, 2, 'default2', 'default2', NULL), (4, 0, 'default1', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, publication_date FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM publication AS LHS INNER JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY title, publication_date NULLS LAST;

/*
Gold Result:
(None, 'default2')
(None, None)
('default2', 'default1')
('default2', 'default2')
*/

-- Prediction Query
SELECT T1.Title, T2.Publication_Date FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID;

/*
Prediction Result:
(None, None)
('default2', 'default2')
(None, 'default2')
('default2', 'default1')
*/