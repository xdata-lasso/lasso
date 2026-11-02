-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, age, height, hometown) VALUES (0, 'default1', 24.0, 1.0, 'default2'), (22, 'default1', 24.0, 24.0, 'default1'), (1, 'default1', 20.0, 23.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM people WHERE (age < 23.0 AND age = 20.0) ORDER BY hometown;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT Hometown FROM people WHERE Age > 23 INTERSECT SELECT Hometown FROM people WHERE Age < 20;

/*
Prediction Result:
*/