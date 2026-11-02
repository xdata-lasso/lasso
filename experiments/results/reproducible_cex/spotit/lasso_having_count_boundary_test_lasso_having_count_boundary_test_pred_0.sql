-- Schema DDL
CREATE TABLE "STUDENT" (
    "STUID" INT,
    "MAJOR" INT,
    PRIMARY KEY ("STUID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO STUDENT VALUES (0, 0);
INSERT INTO STUDENT VALUES (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) <= 2;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT major FROM Student GROUP BY major HAVING COUNT(*) < 2;

/*
Prediction Result:
*/