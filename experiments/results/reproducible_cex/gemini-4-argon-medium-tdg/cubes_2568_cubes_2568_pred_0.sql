-- Schema DDL
CREATE TABLE "publication" ("Publication_ID" INTEGER PRIMARY KEY, "Book_ID" INTEGER, "Publisher" TEXT, "Publication_Date" TEXT, "Price" REAL, FOREIGN KEY ("Book_ID") REFERENCES "book" ("Book_ID"));

CREATE TABLE "book" ("Book_ID" INTEGER PRIMARY KEY, "Title" TEXT, "Issues" REAL, "Writer" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (1, 'DuplicateTitle', 1.0, 'WriterA');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (2, 'DuplicateTitle', 2.0, 'WriterB');
INSERT INTO book (Book_ID, Title, Issues, Writer) VALUES (3, 'PublishedBook', 3.0, 'WriterC');
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (100, 3, 'PubA', '2022-05-05', 25.0);
INSERT INTO publication (Publication_ID, Book_ID, Publisher, Publication_Date, Price) VALUES (101, NULL, 'PubB', '2022-06-06', 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM book AS LHS WHERE NOT EXISTS(SELECT 1 FROM publication AS RHS WHERE (LHS.book_id = RHS.book_id))) ORDER BY title;

/*
Gold Result:
('DuplicateTitle',)
('DuplicateTitle',)
*/

-- Prediction Query
SELECT Title FROM book WHERE NOT Book_ID IN (SELECT Book_ID FROM publication);

/*
Prediction Result:
*/