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
INSERT INTO MUSICAL VALUES (-1, 1, 0, 0, 0, 0, 0);
INSERT INTO MUSICAL VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO ACTOR VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO ACTOR VALUES (0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM musical AS LHS WHERE NOT EXISTS(SELECT 1 FROM actor AS RHS WHERE (LHS.musical_id = RHS.musical_id))) ORDER BY name;

/*
Gold Result:
('1',)
*/

-- Prediction Query
SELECT Name FROM musical WHERE NOT Musical_ID IN (SELECT Musical_ID FROM actor);

/*
Prediction Result:
('1',)
*/