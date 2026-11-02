-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Alice', 20.0, 165.0, 'Zeta');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Bob', 20.0, 175.0, 'Alpha');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Charlie', 20.0, 180.0, 'Alpha');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (4, 'David', 22.0, 170.0, 'Beta');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (5, 'Eve', 23.0, 160.0, 'Gamma');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (6, 'Frank', 25.0, 185.0, 'Delta');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (7, 'Grace', 19.0, 155.0, 'Epsilon');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (2, 14.5, 13.0, 14.0, 15.0, 14.2, 13.8, 84.5);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (4, 15.0, 14.0, 14.5, 15.2, 14.8, 14.1, 87.6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM people WHERE (age < 23.0 AND age = 20.0) ORDER BY hometown;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT Hometown FROM people WHERE Age > 23 INTERSECT SELECT Hometown FROM people WHERE Age < 20;

/*
Prediction Result:
*/