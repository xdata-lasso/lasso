-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1022, 'Jonathan Johnson', 1023.5, 1024.5, 'Lake Debra');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1032, 'Connie Lawrence', 1033.5, 1034.5, 'Port Lindachester');
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1022, 1025.5, 1026.5, 1027.5, 1028.5, 1029.5, 1030.5, 1032.5);
INSERT INTO "gymnast" ("gymnast_id", "floor_exercise_points", "pommel_horse_points", "rings_points", "vault_points", "parallel_bars_points", "horizontal_bar_points", "total_points") VALUES (1032, 1026.5, 1027.5, 1028.5, 1029.5, 1030.5, 1031.5, 1031.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM gymnast ORDER BY total_points, gymnast.gymnast_id NULLS LAST;

/*
Gold Result:
(1031.5,)
(1032.5,)
*/

-- Prediction Query
SELECT Total_Points FROM gymnast ORDER BY Total_Points DESC, gymnast.gymnast_id NULLS LAST;

/*
Prediction Result:
(1032.5,)
(1031.5,)
*/