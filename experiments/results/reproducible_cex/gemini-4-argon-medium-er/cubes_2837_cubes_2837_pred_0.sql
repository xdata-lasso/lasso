-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (1, 'Alice', 20.0, 160.0, 'CityA');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (2, 'Bob', 22.0, 170.0, 'CityB');
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Total_Points") VALUES (1, 10.0, 50.0);
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Total_Points") VALUES (2, 20.0, 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM gymnast ORDER BY total_points, gymnast.gymnast_id NULLS LAST;

/*
Gold Result:
(50.0,)
(60.0,)
*/

-- Prediction Query
SELECT Total_Points FROM gymnast ORDER BY Floor_Exercise_Points DESC, gymnast.gymnast_id NULLS LAST;

/*
Prediction Result:
(60.0,)
(50.0,)
*/