-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1, '5k5swwqcgs', 171.746906, 557.512061, 't2__453db5');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (4, 'hria2ypu', 882.963176, 841.297061, 't2__453db5');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (2, 'rwbbp', 503.083789, 320.851235, 'vd');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (3, 'dposiie5unw', 992.733505, 162.04354, 'fa9');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (5, '5k5swwqcgs', 171.746906, 557.512061, 't2__b2610c');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (6, '8c4pgu7vfe', 483.665643, 818.685402, 't2__b2610c');

-- Inserting into table: gymnast --
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1, 868.436572, 537.136345, 38.937207, 249.706432, 99.523333, 314.813297, 328.996339);

INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (2, 179.378884, 304.02808, 182.319045, 998.421621, 207.290264, 787.938887, 986.066566);

INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (3, 877.276439, 627.258639, 801.414196, 890.762259, 720.527846, 963.351729, 827.854302);

INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (5, 804.971537, 119.752245, 134.487977, 941.961117, 4.751658, 441.165949, 797.015047);

INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (6, 241.913711, 759.708817, 882.963176, 841.297061, 294.861575, 268.234631, 349.034361);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.rings_points AS rings_points, RHS.vault_points AS vault_points FROM people AS LHS INNER JOIN (SELECT * FROM (SELECT rings_points, vault_points, COUNT(*) AS n FROM gymnast GROUP BY rings_points, vault_points) WHERE (n <= 2)) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY hometown;

/*
Gold Result:
('t2__453db5',)
*/

-- Prediction Query
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID GROUP BY T2.Hometown HAVING COUNT(*) >= 2;

/*
Prediction Result:
('t2__b2610c',)
*/