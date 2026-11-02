-- Schema DDL
CREATE TABLE "CAPTAIN" (
    "CAPTAIN_ID" INT,
    "SHIP_ID" INT,
    "NAME" TEXT,
    "AGE" TEXT,
    "CLASS" TEXT,
    "RANK" TEXT,
    PRIMARY KEY ("CAPTAIN_ID"),
    FOREIGN KEY ("SHIP_ID") REFERENCES "SHIP"("SHIP_ID")
);
CREATE TABLE "SHIP" (
    "SHIP_ID" INT,
    "NAME" TEXT,
    "TYPE" TEXT,
    "BUILT_YEAR" FLOAT,
    "CLASS" TEXT,
    "FLAG" TEXT,
    PRIMARY KEY ("SHIP_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CAPTAIN VALUES (1, 0, 0, 0, 6, 8);
INSERT INTO CAPTAIN VALUES (0, 0, 0, 0, 944093580788461313, 7);
INSERT INTO SHIP VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO SHIP VALUES (0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RANK FROM (SELECT * FROM CAPTAIN AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM CAPTAIN WHERE (CLASS = 'Third-rate ship of the line')) AS RHS WHERE (LHS.rank = RHS.rank))) ORDER BY rank, RANK NULLS LAST;

/*
Gold Result:
('7',)
('8',)
*/

-- Prediction Query
SELECT rank FROM captain EXCEPT SELECT rank FROM captain WHERE CLASS = 'Third-rate ship of the line';

/*
Prediction Result:
('7',)
('8',)
*/