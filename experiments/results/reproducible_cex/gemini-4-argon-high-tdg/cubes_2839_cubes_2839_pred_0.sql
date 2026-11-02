-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Alice', 20.0, 170.0, 'Chicago');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Bob', 20.0, 180.0, 'Chicago');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Charlie', 20.0, 165.0, 'Atlanta');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (4, 'Aaron', 20.0, 175.0, 'Denver');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (5, 'David', 19.0, 20.0, 'Boston');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (6, 'Eve', 22.0, 160.0, 'Miami');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (7, 'Frank', 23.0, 170.0, 'Seattle');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (8, 'Grace', 25.0, 168.0, 'Dallas');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (9, 'Heidi', NULL, 172.0, 'Phoenix');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (1, 9.5, 9.0, 9.2, 9.8, 9.1, 9.4, 56.0);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (5, 8.5, 8.0, 8.2, 8.8, 8.1, 8.4, 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM people WHERE (age < 23.0 AND age = 20.0) ORDER BY hometown;

/*
Gold Result:
('Atlanta',)
('Chicago',)
('Denver',)
*/

-- Prediction Query
SELECT Hometown FROM people WHERE Age > 23 INTERSECT SELECT Hometown FROM people WHERE Age < 20;

/*
Prediction Result:
*/