-- Schema DDL
CREATE TABLE "GYMNAST" (
    "GYMNAST_ID" INT,
    "FLOOR_EXERCISE_POINTS" FLOAT,
    "POMMEL_HORSE_POINTS" FLOAT,
    "RINGS_POINTS" FLOAT,
    "VAULT_POINTS" FLOAT,
    "PARALLEL_BARS_POINTS" FLOAT,
    "HORIZONTAL_BAR_POINTS" FLOAT,
    "TOTAL_POINTS" FLOAT,
    PRIMARY KEY ("GYMNAST_ID"),
    FOREIGN KEY ("GYMNAST_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NAME" TEXT,
    "AGE" FLOAT,
    "HEIGHT" FLOAT,
    "HOMETOWN" TEXT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO GYMNAST VALUES (0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO GYMNAST VALUES (1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 14, 1, 1, 15);
INSERT INTO PEOPLE VALUES (1, 16, 0, 1, 17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.height AS height_other FROM people AS LHS CROSS JOIN (SELECT MAX(height) AS height FROM people) AS RHS) WHERE (height >= height_other) ORDER BY age;

/*
Gold Result:
(0.0,)
(1.0,)
*/

-- Prediction Query
SELECT Age FROM people ORDER BY Height DESC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1.0,)
*/