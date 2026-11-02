-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Alice', 22.0, 165.0, 'Zurich');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Bob', 24.0, 175.0, 'Amsterdam');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Charlie', 26.0, 180.0, 'Madrid');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (10, 'Diana', 19.0, 160.0, 'Boston');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (20, 'Evan', 20.0, 170.0, 'Chicago');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (21, 'Fiona', 21.0, 168.0, 'Denver');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (30, 'George', 23.0, 172.0, 'Seattle');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (31, 'Hannah', 25.0, 164.0, 'Miami');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (32, 'Ian', 27.0, 178.0, 'Dallas');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (10, 9.1, 8.1, 9.5, 9.0, 8.5, 8.0, 52.2);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (20, 8.2, 7.2, 8.5, 8.0, 7.5, 7.0, 46.4);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (21, 8.9, 7.9, 8.5, 8.0, 7.8, 7.4, 48.5);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (30, 7.1, 6.1, 7.5, 7.0, 6.5, 6.0, 40.2);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (31, 7.2, 6.2, 7.5, 7.0, 6.6, 6.1, 40.6);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (32, 7.3, 6.3, 7.5, 7.0, 6.7, 6.2, 41.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.rings_points AS rings_points, RHS.vault_points AS vault_points FROM people AS LHS INNER JOIN (SELECT * FROM (SELECT rings_points, vault_points, COUNT(*) AS n FROM gymnast GROUP BY rings_points, vault_points) WHERE (n <= 2)) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY hometown;

/*
Gold Result:
('Amsterdam',)
('Zurich',)
*/

-- Prediction Query
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID GROUP BY T2.Hometown HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/