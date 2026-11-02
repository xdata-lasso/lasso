-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Alex', 21.0, 170.0, 'Seattle');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Blake', 22.0, 175.0, 'Austin');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Casey', 20.0, 168.0, 'Denver');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (4, 'Drew', 23.0, 180.0, 'Miami');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (1, 9.6, 9.6, 9.6, 9.6, 9.6, 9.6, 57.6);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (2, 9.5, 9.6, 9.6, 9.6, 9.6, 9.6, 57.5);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (3, 9.5, 9.5, 9.6, 9.6, 9.6, 9.69, 57.49);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "hometown" FROM (SELECT "gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points", "name", "age", "height", "hometown", "gymnast_id" AS "people_id" FROM (SELECT "LHS"."gymnast_id" AS "gymnast_id", "LHS"."floor_exercise_points" AS "floor_exercise_points", "LHS"."pommel_horse_points" AS "pommel_horse_points", "LHS"."rings_points" AS "rings_points", "LHS"."vault_points" AS "vault_points", "LHS"."parallel_bars_points" AS "parallel_bars_points", "LHS"."horizontal_bar_points" AS "horizontal_bar_points", "LHS"."total_points" AS "total_points", "RHS"."name" AS "name", "RHS"."age" AS "age", "RHS"."height" AS "height", "RHS"."hometown" AS "hometown" FROM "gymnast" AS "LHS" INNER JOIN "people" AS "RHS" ON ("LHS"."gymnast_id" = "RHS"."people_id"))) WHERE ("total_points" >= '57.5') ORDER BY hometown, "hometown" NULLS LAST;

/*
Gold Result:
('Austin',)
('Seattle',)
*/

-- Prediction Query
SELECT DISTINCT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID WHERE T1.Total_Points > 57.5;

/*
Prediction Result:
('Seattle',)
*/