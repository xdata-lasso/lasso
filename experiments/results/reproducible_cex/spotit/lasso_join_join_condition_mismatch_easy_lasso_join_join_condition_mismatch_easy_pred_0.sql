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
INSERT INTO AUTHORS VALUES (1, 9);
INSERT INTO AUTHORS VALUES (0, 11);
INSERT INTO BOOKS VALUES (0, 10, 1);
INSERT INTO BOOKS VALUES (1, 12, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.author_id;

/*
Gold Result:
('9', '10')
('11', '12')
*/

-- Prediction Query
SELECT a.name, b.title FROM authors AS a JOIN books AS b ON a.id = b.id;

/*
Prediction Result:
('9', '12')
('11', '10')
*/