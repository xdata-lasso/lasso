-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1153, 'Thomas Ellis', 1154.5, 1155.5, 'Donaldside');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1163, 'Ann Williams', 1155.5, 1156.5, 'Coxberg');
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1153, 1156.5, 1157.5, 1158.5, 1159.5, 1160.5, 1161.5, 1162.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1163, 1166.5, 1167.5, 1168.5, 1169.5, 1170.5, 1171.5, 1172.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points", "name", "age", "height", "hometown", "gymnast_id" AS "people_id" FROM (SELECT "LHS"."gymnast_id" AS "gymnast_id", "LHS"."floor_exercise_points" AS "floor_exercise_points", "LHS"."pommel_horse_points" AS "pommel_horse_points", "LHS"."rings_points" AS "rings_points", "LHS"."vault_points" AS "vault_points", "LHS"."parallel_bars_points" AS "parallel_bars_points", "LHS"."horizontal_bar_points" AS "horizontal_bar_points", "LHS"."total_points" AS "total_points", "RHS"."name" AS "name", "RHS"."age" AS "age", "RHS"."height" AS "height", "RHS"."hometown" AS "hometown" FROM "gymnast" AS "LHS" INNER JOIN "people" AS "RHS" ON ("LHS"."gymnast_id" = "RHS"."people_id"))) WHERE ("hometown" <> 'Santo Domingo') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Ann Williams',)
('Thomas Ellis',)
*/

-- Prediction Query
SELECT T2.Name FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID WHERE T2.Hometown <> 'Santo Domingo';

/*
Prediction Result:
('Thomas Ellis',)
('Ann Williams',)
*/