-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1, 'rhs_d678bd', 1.0, 1.0, 'rhs_75b92e');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (3, 'rhs_d678bd', 1.0, 1.0, 'rhs_75b92e');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (2, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (4, 'hria2ypu', 882.963176, 841.297061, 'rwbbp');

-- Inserting into table: gymnast --
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 57.5);

INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (2, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 57.5);

INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (3, 320.851235, 113.643485, 855.355181, 179.378884, 304.02808, 182.319045, 57.5);

INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (4, 998.421621, 207.290264, 787.938887, 986.066566, 666.330692, 46.9162, 776.327423);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "hometown" FROM (SELECT "gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points", "name", "age", "height", "hometown", "gymnast_id" AS "people_id" FROM (SELECT "LHS"."gymnast_id" AS "gymnast_id", "LHS"."floor_exercise_points" AS "floor_exercise_points", "LHS"."pommel_horse_points" AS "pommel_horse_points", "LHS"."rings_points" AS "rings_points", "LHS"."vault_points" AS "vault_points", "LHS"."parallel_bars_points" AS "parallel_bars_points", "LHS"."horizontal_bar_points" AS "horizontal_bar_points", "LHS"."total_points" AS "total_points", "RHS"."name" AS "name", "RHS"."age" AS "age", "RHS"."height" AS "height", "RHS"."hometown" AS "hometown" FROM "gymnast" AS "LHS" INNER JOIN "people" AS "RHS" ON ("LHS"."gymnast_id" = "RHS"."people_id"))) WHERE ("total_points" >= '57.5') ORDER BY hometown, "hometown" NULLS LAST;

/*
Gold Result:
('8c4pgu7vfe',)
('rhs_75b92e',)
('rwbbp',)
*/

-- Prediction Query
SELECT DISTINCT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID WHERE T1.Total_Points > 57.5;

/*
Prediction Result:
('rwbbp',)
*/