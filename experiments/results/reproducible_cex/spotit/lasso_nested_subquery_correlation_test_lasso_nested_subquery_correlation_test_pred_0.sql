-- Schema DDL
CREATE TABLE "AUTHORS" (
    "AUTHOR_ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("AUTHOR_ID")
);
CREATE TABLE "BOOKS" (
    "BOOK_ID" INT,
    "AUTHOR_ID" INT,
    "YEAR" INT,
    PRIMARY KEY ("BOOK_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO AUTHORS VALUES (-3, 0);
INSERT INTO AUTHORS VALUES (-2, 0);
INSERT INTO BOOKS VALUES (-1, -1, 0);
INSERT INTO BOOKS VALUES (0, 0, 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name FROM authors AS a WHERE NOT EXISTS(SELECT * FROM books AS b1 WHERE a.author_id = b1.author_id AND EXISTS(SELECT * FROM books AS b2 WHERE b2.author_id = b1.author_id AND b2.year = 2020));

/*
Gold Result:
('0',)
('0',)
*/

-- Prediction Query
SELECT a.name FROM authors AS a WHERE NOT EXISTS(SELECT * FROM books AS b1 WHERE a.author_id = b1.author_id AND EXISTS(SELECT * FROM books AS b2 WHERE b2.year = 2020));

/*
Prediction Result:
('0',)
('0',)
*/