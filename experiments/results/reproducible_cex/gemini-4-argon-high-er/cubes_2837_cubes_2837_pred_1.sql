-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (1, 'Alice', 20.0, 160.0, 'Town A');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (2, 'Bob', 22.0, 175.0, 'Town B');
INSERT INTO "gymnast" ("Gymnast_ID", "Total_Points") VALUES (1, 10.0);
INSERT INTO "gymnast" ("Gymnast_ID", "Total_Points") VALUES (2, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM gymnast ORDER BY total_points, gymnast.gymnast_id NULLS LAST;

/*
Gold Result:
(10.0,)
(20.0,)
*/

-- Prediction Query
SELECT Total_Points FROM gymnast ORDER BY Total_Points DESC, gymnast.gymnast_id NULLS LAST;

/*
Prediction Result:
(20.0,)
(10.0,)
*/