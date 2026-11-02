-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, age, height, hometown) VALUES (0, 'default2', 0.0, 3.0, 'default2'), (1, NULL, 2.0, NULL, 'default1'), (3, NULL, 3.0, NULL, NULL), (2, NULL, 2.0, 1.0, 'default2');
INSERT INTO gymnast (gymnast_id, floor_exercise_points, pommel_horse_points, rings_points, vault_points, parallel_bars_points, horizontal_bar_points, total_points) VALUES (2, 3.0, 2.0, 0.0, 0.0, NULL, 0.0, NULL), (3, 2.0, 2.0, 3.0, NULL, 2.0, 1.0, 2.0), (0, 1.0, 3.0, 1.0, 1.0, 2.0, 3.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.rings_points AS rings_points, RHS.vault_points AS vault_points FROM people AS LHS INNER JOIN (SELECT * FROM (SELECT rings_points, vault_points, COUNT(*) AS n FROM gymnast GROUP BY rings_points, vault_points) WHERE (n <= 2)) AS RHS ON (LHS.people_id = RHS.n)) ORDER BY hometown;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T2.Hometown FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID GROUP BY T2.Hometown HAVING COUNT(*) >= 2;

/*
Prediction Result:
('default2',)
*/