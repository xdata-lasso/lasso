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
INSERT INTO GYMNAST VALUES (1, 21, 22, 23, 24, 25, 26, 27);
INSERT INTO GYMNAST VALUES (0, 31, 32, 33, 34, 35, 36, 37);
INSERT INTO PEOPLE VALUES (0, 28, -2, 29, 30);
INSERT INTO PEOPLE VALUES (1, 38, -1, 39, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.gymnast_id AS gymnast_id, LHS.floor_exercise_points AS floor_exercise_points, LHS.pommel_horse_points AS pommel_horse_points, LHS.rings_points AS rings_points, LHS.vault_points AS vault_points, LHS.parallel_bars_points AS parallel_bars_points, LHS.horizontal_bar_points AS horizontal_bar_points, LHS.total_points AS total_points, RHS.people_id AS people_id, RHS.name AS name, RHS.age AS age, RHS.height AS height, RHS.hometown AS hometown FROM gymnast AS LHS CROSS JOIN people AS RHS) ORDER BY rings_points DESC) LIMIT 1);

/*
Gold Result:
(37.0,)
*/

-- Prediction Query
SELECT T1.Total_Points FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID ORDER BY T2.Age ASC, T1.gymnast_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(37.0,)
*/