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
INSERT INTO MUSICAL VALUES (0, 18, -1, 19, 20, 21, 22);
INSERT INTO MUSICAL VALUES (-2, 25, NULL, 26, 27, 28, 29);
INSERT INTO ACTOR VALUES (-1, -2, -1, 16, 17, 0);
INSERT INTO ACTOR VALUES (-2, -1, 0, 23, 24, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM actor ORDER BY name, actor.actor_id NULLS LAST;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID ORDER BY T2.Year DESC, T1.actor_id NULLS LAST, T2.musical_id NULLS LAST;

/*
Prediction Result:
('-1',)
*/