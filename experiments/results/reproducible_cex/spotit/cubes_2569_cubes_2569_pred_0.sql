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
INSERT INTO PUBLICATION VALUES (-1, 0, 1059737259670367151, 0, 6);
INSERT INTO PUBLICATION VALUES (0, 0, 987913778733863063, 0, 0);
INSERT INTO BOOK VALUES (0, 0, 0, 0);
INSERT INTO BOOK VALUES (1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PRICE FROM PUBLICATION WHERE (PUBLISHER = 'Wiley') ORDER BY price, publication.publication_id NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT Price FROM publication WHERE Publisher = 'Person' OR Publisher = 'Wiley';

/*
Prediction Result:
*/