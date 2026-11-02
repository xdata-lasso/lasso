-- Schema DDL
CREATE TABLE "MUSICAL" (
    "MUSICAL_ID" INT,
    "NAME" TEXT,
    "YEAR" INT,
    "AWARD" TEXT,
    "CATEGORY" TEXT,
    "NOMINEE" TEXT,
    "RESULT" TEXT,
    PRIMARY KEY ("MUSICAL_ID")
);
CREATE TABLE "ACTOR" (
    "ACTOR_ID" INT,
    "MUSICAL_ID" INT,
    "NAME" TEXT,
    "CHARACTER" TEXT,
    "DURATION" TEXT,
    "AGE" INT,
    PRIMARY KEY ("ACTOR_ID"),
    FOREIGN KEY ("MUSICAL_ID") REFERENCES "ACTOR"("ACTOR_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MUSICAL VALUES (0, 125211583545395418, 0, 11, 12, 13, 14);
INSERT INTO MUSICAL VALUES (-1, 7, 0, 18, 19, 20, 21);
INSERT INTO ACTOR VALUES (0, 0, 8, 9, 10, 0);
INSERT INTO ACTOR VALUES (1, 0, 15, 16, 17, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM (SELECT * FROM ACTOR AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM MUSICAL WHERE (NAME <> 'The Phantom of the Opera')) AS RHS WHERE (LHS.musical_id = RHS.musical_id))) ORDER BY name, NAME NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID WHERE T2.Name = 'The Phantom of the Opera';

/*
Prediction Result:
*/