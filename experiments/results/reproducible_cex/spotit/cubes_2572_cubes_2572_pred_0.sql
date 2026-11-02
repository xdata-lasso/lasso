-- Schema DDL
CREATE TABLE "PUBLICATION" (
    "PUBLICATION_ID" INT,
    "BOOK_ID" INT,
    "PUBLISHER" TEXT,
    "PUBLICATION_DATE" TEXT,
    "PRICE" FLOAT,
    PRIMARY KEY ("PUBLICATION_ID"),
    FOREIGN KEY ("BOOK_ID") REFERENCES "BOOK"("BOOK_ID")
);
CREATE TABLE "BOOK" (
    "BOOK_ID" INT,
    "TITLE" TEXT,
    "ISSUES" FLOAT,
    "WRITER" TEXT,
    PRIMARY KEY ("BOOK_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PUBLICATION VALUES (-1, 1, 6, 8, 4000000);
INSERT INTO PUBLICATION VALUES (0, 0, 16, 17, 4000000);
INSERT INTO BOOK VALUES (0, 7, 9, 0);
INSERT INTO BOOK VALUES (1, 10, 11, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT writer FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.title AS title, RHS.issues AS issues, RHS.writer AS writer FROM (SELECT * FROM publication WHERE (price >= 4000000.0)) AS LHS LEFT JOIN book AS RHS ON (LHS.book_id = RHS.book_id)) ORDER BY writer;

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT T1.Writer FROM book AS T1 JOIN publication AS T2 ON T1.Book_ID = T2.Book_ID WHERE T2.Price > 4000000;

/*
Prediction Result:
*/