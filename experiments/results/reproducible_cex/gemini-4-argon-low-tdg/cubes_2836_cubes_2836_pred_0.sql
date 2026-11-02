-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests COUNT(*) boundaries (n=1, n=2, n=3), DISTINCT on joined results, and ORDER BY hometown.
-- Also tests mutation of joining on Gymnast_ID instead of COUNT(*) (n).
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Alice', 20.0, 160.0, 'Zeta');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Bob', 21.0, 170.0, 'Alpha');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Charlie', 22.0, 175.0, 'Beta');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (4, 'David', 23.0, 180.0, 'Gamma');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (5, 'Eve', 24.0, 165.0, 'Delta');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (6, 'Frank', 25.0, 185.0, 'Epsilon');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (7, 'Grace', 26.0, 155.0, 'Omega');
-- Group 1: (10.0, 10.0) -> count = 1 (Matches People_ID = 1, 'Zeta')
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (4, 9.0, 9.0, 10.0, 10.0, 9.0, 9.0, 55.0);
-- Group 2: (11.0, 11.0) -> count = 1 (Matches People_ID = 1, 'Zeta' again, testing DISTINCT)
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (5, 9.0, 9.0, 11.0, 11.0, 9.0, 9.0, 57.0);
-- Group 3: (12.0, 12.0) -> count = 2 (Matches People_ID = 2, 'Alpha')
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (6, 9.0, 9.0, 12.0, 12.0, 9.0, 9.0, 59.0);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (7, 9.0, 9.0, 12.0, 12.0, 9.0, 9.0, 59.0);
-- Group 4: (13.0, 13.0) -> count = 3 (Filtered out by n <= 2; would match People_ID = 3 'Beta' if filter fails)
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (1, 9.0, 9.0, 13.0, 13.0, 9.0, 9.0, 61.0);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (2, 9.0, 9.0, 13.0, 13.0, 9.0, 9.0, 61.0);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (3, 9.0, 9.0, 13.0, 13.0, 9.0, 9.0, 61.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.rings_points AS rings_points, RHS.vault_points AS vault_points FROM people AS LHS INNER JOIN (SELECT * FROM (SELECT rings_points, vault_points, COUNT(*) AS n FROM gymnast GROUP BY rings_points, vault_points) WHERE (n <= 2)) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY hometown;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID GROUP BY T2.Hometown HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/