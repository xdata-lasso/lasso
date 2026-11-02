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
INSERT INTO MUSICAL VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO MUSICAL VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO ACTOR VALUES (1, 1, 0, 0, 10, 0);
INSERT INTO ACTOR VALUES (0, 1, 0, 0, 9, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT duration FROM (SELECT * FROM (SELECT * FROM actor ORDER BY age DESC, actor.actor_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('9',)
*/

-- Prediction Query
SELECT Duration FROM actor ORDER BY Age DESC, actor.actor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('9',)
*/