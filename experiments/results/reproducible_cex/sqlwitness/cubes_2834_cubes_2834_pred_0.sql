-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, age, height, hometown) VALUES (0, NULL, 56.5, NULL, 'default2'), (1, '57.5', 56.5, 0.0, 'default1'), (2, NULL, 0.0, 1.0, 'default1'), (3, 'default2', 58.5, 0.0, 'default2'), (4, '57.5', 56.5, 0.0, 'default2'), (5, 'default1', 0.0, 0.0, 'default2'), (6, NULL, 58.5, 58.5, 'default1'), (7, NULL, 1.0, 56.5, 'default2'), (8, NULL, 58.5, 0.0, NULL), (9, NULL, 57.5, NULL, '57.5'), (10, NULL, 0.0, 56.5, NULL);
INSERT INTO gymnast (gymnast_id, floor_exercise_points, pommel_horse_points, rings_points, vault_points, parallel_bars_points, horizontal_bar_points, total_points) VALUES (6, 56.5, NULL, 57.5, 57.5, 57.5, 58.5, 57.5), (1, 0.0, 56.5, 56.5, 58.5, 57.5, 57.5, 57.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "hometown" FROM (SELECT "gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points", "name", "age", "height", "hometown", "gymnast_id" AS "people_id" FROM (SELECT "LHS"."gymnast_id" AS "gymnast_id", "LHS"."floor_exercise_points" AS "floor_exercise_points", "LHS"."pommel_horse_points" AS "pommel_horse_points", "LHS"."rings_points" AS "rings_points", "LHS"."vault_points" AS "vault_points", "LHS"."parallel_bars_points" AS "parallel_bars_points", "LHS"."horizontal_bar_points" AS "horizontal_bar_points", "LHS"."total_points" AS "total_points", "RHS"."name" AS "name", "RHS"."age" AS "age", "RHS"."height" AS "height", "RHS"."hometown" AS "hometown" FROM "gymnast" AS "LHS" INNER JOIN "people" AS "RHS" ON ("LHS"."gymnast_id" = "RHS"."people_id"))) WHERE ("total_points" >= '57.5') ORDER BY hometown, "hometown" NULLS LAST;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT DISTINCT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID WHERE T1.Total_Points > 57.5;

/*
Prediction Result:
*/