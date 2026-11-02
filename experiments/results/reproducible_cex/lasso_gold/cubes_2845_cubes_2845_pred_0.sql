-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1001, 'Allison Hill', 1005.5, 1009.5, 'New Jamesside');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1002, 'Noah Rhodes', 1012.5, 1018.5, 'Robinsonshire');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1003, 'Angie Henderson', 1019.5, 1027.5, 'Lisatown');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1004, 'Daniel Wagner', 1026.5, 1036.5, 'Lake Roberto');
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1001, 1013.5, 1017.5, 1021.5, 1025.5, 1029.5, 1033.5, 1037.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1002, 1018.5, 1024.5, 1030.5, 1036.5, 1042.5, 1048.5, 1054.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1003, 1023.5, 1031.5, 1039.5, 1047.5, 1055.5, 1063.5, 1071.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1004, 1028.5, 1038.5, 1048.5, 1058.5, 1068.5, 1078.5, 1088.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.gymnast_id AS gymnast_id, LHS.floor_exercise_points AS floor_exercise_points, LHS.pommel_horse_points AS pommel_horse_points, LHS.rings_points AS rings_points, LHS.vault_points AS vault_points, LHS.parallel_bars_points AS parallel_bars_points, LHS.horizontal_bar_points AS horizontal_bar_points, LHS.total_points AS total_points, RHS.people_id AS people_id, RHS.name AS name, RHS.age AS age, RHS.height AS height, RHS.hometown AS hometown FROM gymnast AS LHS CROSS JOIN people AS RHS) ORDER BY rings_points DESC) LIMIT 1);

/*
Gold Result:
(1088.5,)
*/

-- Prediction Query
SELECT T1.Total_Points FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID ORDER BY T2.Age ASC, T1.gymnast_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1037.5,)
*/