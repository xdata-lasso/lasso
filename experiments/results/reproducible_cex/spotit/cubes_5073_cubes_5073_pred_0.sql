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
INSERT INTO PUBLICATION VALUES (2, 0, 12, 2, 13);
INSERT INTO PUBLICATION VALUES (0, 0, NULL, 0, 10);
INSERT INTO BOOK VALUES (0, 0, 0, 0);
INSERT INTO BOOK VALUES (-1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publication_date FROM (SELECT book_id, publication_date, MAX(n) AS n FROM (SELECT publication_id, book_id, publisher, publication_date, price, book_id_other, publication_id AS n FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.book_id AS book_id_other FROM publication AS LHS INNER JOIN (SELECT book_id, COUNT(*) AS n FROM publication GROUP BY book_id) AS RHS ON (LHS.publication_id = RHS.n))) GROUP BY book_id, publication_date) ORDER BY publication_date;

/*
Gold Result:
('2',)
*/

-- Prediction Query
SELECT Publication_Date FROM publication GROUP BY Publication_Date ORDER BY COUNT(*) DESC, Publication_Date NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/