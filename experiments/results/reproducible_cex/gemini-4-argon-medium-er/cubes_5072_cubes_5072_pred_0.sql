-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Book A', 1.0, 'Writer A');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (1, 1, 'Pub A', '2020-01-01', 100.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (2, 1, 'Pub B', '2020-01-02', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT publisher FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.publication_id AS publication_id_other, RHS.book_id AS book_id_other, RHS.publisher AS publisher_other, RHS.publication_date AS publication_date_other, RHS.price AS price_other FROM publication AS LHS CROSS JOIN (SELECT publication_id, book_id, publisher, publication_date, MAX(price) OVER () AS price FROM publication) AS RHS) WHERE (price >= price_other) ORDER BY publisher;

/*
Gold Result:
('Pub A',)
('Pub B',)
*/

-- Prediction Query
SELECT Publisher FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Pub A',)
*/