-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (10, 'Carlos', 28.0, 174.0, 'Madrid');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (20, 'Ana', 21.0, 162.0, 'Rome');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (30, 'Bruno', 26.0, 181.0, 'Santo Domingo ');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (40, 'Diana', 24.0, 169.0, 'Santo Domingo');
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (10, 11.5, 12.1, 13.2, 14.3, 15.4, 10.5, 77.0);
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (20, 15.5, 14.1, 13.8, 12.3, 11.4, 16.0, 83.1);
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (30, 10.0, 10.0, 10.0, 10.0, 10.0, 10.0, 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points", "name", "age", "height", "hometown", "gymnast_id" AS "people_id" FROM (SELECT "LHS"."gymnast_id" AS "gymnast_id", "LHS"."floor_exercise_points" AS "floor_exercise_points", "LHS"."pommel_horse_points" AS "pommel_horse_points", "LHS"."rings_points" AS "rings_points", "LHS"."vault_points" AS "vault_points", "LHS"."parallel_bars_points" AS "parallel_bars_points", "LHS"."horizontal_bar_points" AS "horizontal_bar_points", "LHS"."total_points" AS "total_points", "RHS"."name" AS "name", "RHS"."age" AS "age", "RHS"."height" AS "height", "RHS"."hometown" AS "hometown" FROM "gymnast" AS "LHS" INNER JOIN "people" AS "RHS" ON ("LHS"."gymnast_id" = "RHS"."people_id"))) WHERE ("hometown" <> 'Santo Domingo') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Ana',)
('Bruno',)
('Carlos',)
*/

-- Prediction Query
SELECT T2.Name FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID WHERE T2.Hometown <> 'Santo Domingo';

/*
Prediction Result:
('Carlos',)
('Ana',)
('Bruno',)
*/