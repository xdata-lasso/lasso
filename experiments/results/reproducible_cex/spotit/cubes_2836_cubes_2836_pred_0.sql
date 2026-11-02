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
INSERT INTO GYMNAST VALUES (2, 21, 22, 9, 10, 23, 24, 25);
INSERT INTO GYMNAST VALUES (1, 26, 27, 9, 10, 28, 29, 30);
INSERT INTO PEOPLE VALUES (2, NULL, NULL, NULL, 0);
INSERT INTO PEOPLE VALUES (1, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.rings_points AS rings_points, RHS.vault_points AS vault_points FROM people AS LHS INNER JOIN (SELECT * FROM (SELECT rings_points, vault_points, COUNT(*) AS n FROM gymnast GROUP BY rings_points, vault_points) WHERE (n <= 2)) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY hometown;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID GROUP BY T2.Hometown HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/