-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE predicate (age = 20.0), DISTINCT deduplication, and ORDER BY ascending vs insertion order.
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Alice', 20.0, 165.0, 'Zeta');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Bob', 20.0, 175.0, 'Alpha');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Charlie', 20.0, 180.0, 'Alpha');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (4, 'Diana', 20.0, 160.0, 'Beta');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM people WHERE (age < 23.0 AND age = 20.0) ORDER BY hometown;

/*
Gold Result:
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT Hometown FROM people WHERE Age > 23 INTERSECT SELECT Hometown FROM people WHERE Age < 20;

/*
Prediction Result:
*/