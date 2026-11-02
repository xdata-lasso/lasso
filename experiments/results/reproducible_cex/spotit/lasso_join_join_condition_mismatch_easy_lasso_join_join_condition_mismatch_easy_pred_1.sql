-- Schema DDL
CREATE TABLE "AUTHORS" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "BOOKS" (
    "ID" INT,
    "TITLE" TEXT,
    "AUTHOR_ID" INT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("AUTHOR_ID") REFERENCES "AUTHORS"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO AUTHORS VALUES (-1, 7);
INSERT INTO AUTHORS VALUES (0, 9);
INSERT INTO BOOKS VALUES (0, 8, 0);
INSERT INTO BOOKS VALUES (1, 10, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('9', '8')
('7', '10')
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = a.id;

/*
Prediction Result:
('7', '8')
('7', '10')
('9', '8')
('9', '10')
*/