-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC) and lexicographical vs numerical sorting
-- Also includes an unreferenced row in 'people' to catch incorrect JOINs (e.g., RIGHT/FULL JOIN or querying the wrong table)
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (1, 'John Doe', 22.0, 175.0, 'New York');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (2, 'Jane Smith', 19.0, 165.0, 'Los Angeles');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (3, 'Jim Brown', 25.0, 180.0, 'Chicago');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (4, 'Unreferenced Person', 30.0, 170.0, 'Houston');
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (1, 15.0, 15.0, 15.0, 15.0, 20.0, 20.0, 100.0);
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (2, 5.0, 5.0, 5.0, 5.0, 0.0, 0.0, 20.0);
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (3, 1.0, 1.0, 1.0, 1.0, 2.5, 3.0, 9.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM gymnast ORDER BY total_points, gymnast.gymnast_id NULLS LAST;

/*
Gold Result:
(9.5,)
(20.0,)
(100.0,)
*/

-- Prediction Query
SELECT Total_Points FROM gymnast ORDER BY Floor_Exercise_Points DESC, gymnast.gymnast_id NULLS LAST;

/*
Prediction Result:
(100.0,)
(20.0,)
(9.5,)
*/