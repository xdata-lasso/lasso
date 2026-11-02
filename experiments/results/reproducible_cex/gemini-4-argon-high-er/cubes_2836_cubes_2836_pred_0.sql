-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Alice', 20.0, 170.0, 'TownA');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (1, 10.0, 10.0, 10.0, 10.0, 10.0, 10.0, 60.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.rings_points AS rings_points, RHS.vault_points AS vault_points FROM people AS LHS INNER JOIN (SELECT * FROM (SELECT rings_points, vault_points, COUNT(*) AS n FROM gymnast GROUP BY rings_points, vault_points) WHERE (n <= 2)) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY hometown;

/*
Gold Result:
('TownA',)
*/

-- Prediction Query
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID GROUP BY T2.Hometown HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/