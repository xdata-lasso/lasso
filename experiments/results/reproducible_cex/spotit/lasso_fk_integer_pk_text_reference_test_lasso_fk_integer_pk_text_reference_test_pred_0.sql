-- Schema DDL
CREATE TABLE "PARENT" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "CHILD" (
    "CHILD_ID" INT,
    "PARENT_ID" TEXT,
    "VAL" INT,
    PRIMARY KEY ("CHILD_ID"),
    FOREIGN KEY ("PARENT_ID") REFERENCES "PARENT"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PARENT VALUES (1, 0);
INSERT INTO PARENT VALUES (0, 0);
INSERT INTO CHILD VALUES (-1, 1, 10);
INSERT INTO CHILD VALUES (0, 1, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val FROM child WHERE val > 10;

/*
Gold Result:
*/

-- Prediction Query
SELECT val FROM child WHERE val >= 10;

/*
Prediction Result:
(10,)
(10,)
*/