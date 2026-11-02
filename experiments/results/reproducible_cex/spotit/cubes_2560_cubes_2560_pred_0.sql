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
INSERT INTO PUBLICATION VALUES (1, 1, 0, 14, 0);
INSERT INTO PUBLICATION VALUES (0, 0, -1, 15, 0);
INSERT INTO BOOK VALUES (0, 0, 0, 0);
INSERT INTO BOOK VALUES (1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT publication_id, publication_id AS book_id, publisher, publication_date, price, publisher_other, publication_date_other, price_other FROM (SELECT LHS.publication_id AS publication_id, LHS.book_id AS book_id, LHS.publisher AS publisher, LHS.publication_date AS publication_date, LHS.price AS price, RHS.publisher AS publisher_other, RHS.publication_date AS publication_date_other, RHS.price AS price_other FROM publication AS LHS INNER JOIN publication AS RHS ON (LHS.publication_id = RHS.book_id AND LHS.book_id = RHS.publication_id))) ORDER BY publisher;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT Publisher FROM publication ORDER BY Price DESC, publication.publication_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/