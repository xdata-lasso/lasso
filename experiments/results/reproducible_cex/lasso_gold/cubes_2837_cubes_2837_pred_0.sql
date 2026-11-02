-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (0, 'Tommy Walter', 1123.5, 1124.5, 'Jasonfort');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (150, 'Thomas Ellis', 1133.5, 1134.5, 'Donaldside');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (20, 'Nicole Patterson', 1143.5, 1144.5, 'Coxberg');
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (0, 1125.5, 1126.5, 1127.5, 1128.5, 1129.5, 1130.5, 1131.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (150, 1135.5, 1136.5, 1137.5, 1138.5, 1139.5, 1140.5, 1131.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (20, 1145.5, 1146.5, 1147.5, 1148.5, 1149.5, 1150.5, 1132.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM gymnast ORDER BY total_points, gymnast.gymnast_id NULLS LAST;

/*
Gold Result:
(1131.5,)
(1131.5,)
(1132.5,)
*/

-- Prediction Query
SELECT Total_Points FROM gymnast ORDER BY Floor_Exercise_Points DESC, gymnast.gymnast_id NULLS LAST;

/*
Prediction Result:
(1132.5,)
(1131.5,)
(1131.5,)
*/