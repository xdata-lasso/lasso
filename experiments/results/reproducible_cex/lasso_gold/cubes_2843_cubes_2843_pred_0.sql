-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1063, 'Jesse Flowers', 1064.5, 1065.5, 'Barbaraland');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1073, 'Jamie Arnold', 1065.5, 1066.5, 'Port Jesseville');
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1063, 1066.5, 1067.5, 1068.5, 1069.5, 1070.5, 1071.5, 1072.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1073, 1076.5, 1077.5, 1078.5, 1079.5, 1080.5, 1081.5, 1082.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.gymnast_id AS gymnast_id, LHS.floor_exercise_points AS floor_exercise_points, LHS.pommel_horse_points AS pommel_horse_points, LHS.rings_points AS rings_points, LHS.vault_points AS vault_points, LHS.parallel_bars_points AS parallel_bars_points, LHS.horizontal_bar_points AS horizontal_bar_points, LHS.total_points AS total_points, RHS.name AS name, RHS.age AS age, RHS.height AS height, RHS.hometown AS hometown FROM gymnast AS LHS INNER JOIN people AS RHS ON (LHS.gymnast_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('Jamie Arnold',)
('Jesse Flowers',)
*/

-- Prediction Query
SELECT T2.Name FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID ORDER BY T2.Height ASC, T1.gymnast_id NULLS LAST, T2.people_id NULLS LAST;

/*
Prediction Result:
('Jesse Flowers',)
('Jamie Arnold',)
*/