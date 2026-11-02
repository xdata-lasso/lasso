-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, age, height, hometown) VALUES (1, NULL, 0.0, 1.0, 'default2'), (0, 'default1', 1.0, 1.0, NULL);
INSERT INTO gymnast (gymnast_id, floor_exercise_points, pommel_horse_points, rings_points, vault_points, parallel_bars_points, horizontal_bar_points, total_points) VALUES (1, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0, 1.0), (0, 0.0, 1.0, 1.0, NULL, 1.0, 0.0, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM gymnast ORDER BY total_points, gymnast.gymnast_id NULLS LAST;

/*
Gold Result:
(0.0,)
(1.0,)
*/

-- Prediction Query
SELECT Total_Points FROM gymnast ORDER BY Total_Points DESC, gymnast.gymnast_id NULLS LAST;

/*
Prediction Result:
(1.0,)
(0.0,)
*/