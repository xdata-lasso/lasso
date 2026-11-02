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
INSERT INTO PUBLICATION VALUES (1, 0, 0, 0, 5000000);
INSERT INTO PUBLICATION VALUES (0, -1, NULL, 0, 5000000);
INSERT INTO BOOK VALUES (-1, 0, 0, 0);
INSERT INTO BOOK VALUES (0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM publication WHERE (price >= 5000000.0) ORDER BY publisher, publication.publication_id NULLS LAST;

/*
Gold Result:
(None,)
('0',)
*/

-- Prediction Query
SELECT DISTINCT Publisher FROM publication WHERE Price > 5000000;

/*
Prediction Result:
*/