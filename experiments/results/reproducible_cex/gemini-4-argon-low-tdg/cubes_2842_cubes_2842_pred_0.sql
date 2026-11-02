-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in projected and sorted column (Age), and NULL values in other gymnast/people columns to kill spurious IS NOT NULL filters
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (10, 'Eve', NULL, 170.0, 'Austin');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (20, NULL, 22.0, NULL, NULL);
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (30, 'Frank', 20.0, 168.0, 'Denver');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (40, 'Grace', NULL, 162.0, 'Miami');
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (10, NULL, 13.0, 12.0, 14.0, 13.5, 12.5, 65.0);
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (20, 14.0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (30, 12.0, 12.0, 12.0, 12.0, 12.0, 12.0, 72.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT LHS.gymnast_id AS gymnast_id, LHS.floor_exercise_points AS floor_exercise_points, LHS.pommel_horse_points AS pommel_horse_points, LHS.rings_points AS rings_points, LHS.vault_points AS vault_points, LHS.parallel_bars_points AS parallel_bars_points, LHS.horizontal_bar_points AS horizontal_bar_points, LHS.total_points AS total_points, RHS.name AS name, RHS.age AS age, RHS.height AS height, RHS.hometown AS hometown FROM gymnast AS LHS INNER JOIN people AS RHS ON (LHS.gymnast_id = RHS.people_id)) ORDER BY age;

/*
Gold Result:
(None,)
(20.0,)
(22.0,)
*/

-- Prediction Query
SELECT T2.Age FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID ORDER BY T1.Total_Points DESC, T1.gymnast_id NULLS LAST, T2.people_id NULLS LAST;

/*
Prediction Result:
(20.0,)
(None,)
(22.0,)
*/