-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'Book A', 1.0, 'Writer 1');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'Book B', 2.0, 'Writer 2');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'Book C', 3.0, 'Writer 3');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (4, 'Book D', 4.0, 'Writer 4');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (1, 1, 'Pub_Self_1', '2020-01-01', 10.5);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (2, 3, 'Pub_Cycle_A', '2020-02-01', 20.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (3, 2, 'Pub_Cycle_B', '2020-03-01', 30.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (4, 1, 'Pub_OneWay', '2020-04-01', 40.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (5, NULL, 'Pub_NullBook', '2020-05-01', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT publication_id, publication_id AS book_id, publisher, publication_date, price, publisher_other, publication_date_other, price_other FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.publisher AS publisher_other, RHS.publication_date AS publication_date_other, RHS.price AS price_other FROM publication AS LHS INNER JOIN publication AS RHS ON (LHS.publication_id = RHS.book_id AND LHS.book_id = RHS.publication_id))) ORDER BY publisher;

/*
Gold Result:
('Pub_Cycle_A',)
('Pub_Cycle_B',)
('Pub_Self_1',)
*/

-- Prediction Query
SELECT Publisher FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Pub_NullBook',)
*/