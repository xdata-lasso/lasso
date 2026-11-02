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
INSERT INTO MUSICAL VALUES (0, 0, 0, 3797849774677971209, 0, 7, 0);
INSERT INTO MUSICAL VALUES (-1, 0, 0, 851228018582887025, 0, 0, 0);
INSERT INTO ACTOR VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO ACTOR VALUES (1, 1, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NOMINEE FROM MUSICAL WHERE (AWARD = 'Tony Award') ORDER BY nominee, musical.musical_id NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT Nominee FROM musical WHERE Award = 'Tony Award' OR Award = 'Cleavant Derricks';

/*
Prediction Result:
*/