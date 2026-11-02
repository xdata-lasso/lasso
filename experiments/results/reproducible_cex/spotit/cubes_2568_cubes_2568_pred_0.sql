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
INSERT INTO PUBLICATION VALUES (1, 0, 0, 0, 0);
INSERT INTO PUBLICATION VALUES (0, 0, 0, 0, 0);
INSERT INTO BOOK VALUES (1, 0, 0, 0);
INSERT INTO BOOK VALUES (0, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT * FROM book AS LHS WHERE NOT EXISTS(SELECT 1 FROM publication AS RHS WHERE (LHS.book_id = RHS.book_id))) ORDER BY title;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT Title FROM book WHERE NOT Book_ID IN (SELECT Book_ID FROM publication);

/*
Prediction Result:
('0',)
*/