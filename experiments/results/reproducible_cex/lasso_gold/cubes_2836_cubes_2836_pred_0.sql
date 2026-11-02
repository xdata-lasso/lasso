-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1027, 'Sean Blake', 1030.5, 1033.5, 'Davisstad');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1028, 'Jay Ramirez', 1037.5, 1042.5, 'Lindsaymouth');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1029, 'Phillip Garcia', 1044.5, 1051.5, 'South Christianport');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1253, NULL, NULL, NULL, NULL);
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1254, NULL, NULL, NULL, NULL);
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1255, NULL, NULL, NULL, NULL);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1027, 1036.5, 1039.5, 1042.5, 1043.5, 1044.5, 1047.5, 1050.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1028, 1041.5, 1046.5, 1042.5, 1043.5, 1057.5, 1062.5, 1067.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1029, 1046.5, 1053.5, 1042.5, 1043.5, 1070.5, 1077.5, 1084.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1253, NULL, NULL, 1268.5, 1269.5, NULL, NULL, NULL);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1254, NULL, NULL, 1268.5, 1269.5, NULL, NULL, NULL);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1255, NULL, NULL, 1268.5, 1269.5, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.rings_points AS rings_points, RHS.vault_points AS vault_points FROM people AS LHS INNER JOIN (SELECT * FROM (SELECT rings_points, vault_points, COUNT(*) AS n FROM gymnast GROUP BY rings_points, vault_points) WHERE (n <= 2)) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY hometown;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID GROUP BY T2.Hometown HAVING COUNT(*) >= 2;

/*
Prediction Result:
(None,)
*/