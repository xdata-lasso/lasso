-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book (book_id, title, issues, writer) VALUES (2, NULL, 2.0, 'default1'), (1, 'default1', 2.0, NULL);
INSERT INTO publication (publication_id, book_id, publisher, publication_date, price) VALUES (2, NULL, 'default2', 'default2', 1.0), (0, 2, 'default2', NULL, NULL), (1, 1, 'default2', NULL, 0.0), (3, 1, NULL, 'default2', 1.0), (4, NULL, 'default2', 'default2', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT publisher FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.publication_id AS publication_id_other, RHS.book_id AS book_id_other, RHS.publisher AS publisher_other, RHS.publication_date AS publication_date_other, RHS.price AS price_other FROM publication AS LHS CROSS JOIN (SELECT publication_id, book_id, publisher, publication_date, MAX(price) OVER () AS price FROM publication) AS RHS) WHERE (price >= price_other) ORDER BY publisher;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT Publisher FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default2',)
*/