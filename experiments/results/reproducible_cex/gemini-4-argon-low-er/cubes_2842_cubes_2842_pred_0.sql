-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Alice', 20.0, 160.0, 'TownA');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Bob', 30.0, 170.0, 'TownB');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (1, 10.0, 10.0, 10.0, 10.0, 10.0, 10.0, 50.0);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (2, 10.0, 10.0, 10.0, 10.0, 10.0, 10.0, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT LHS.gymnast_id AS gymnast_id, LHS.floor_exercise_points AS floor_exercise_points, LHS.pommel_horse_points AS pommel_horse_points, LHS.rings_points AS rings_points, LHS.vault_points AS vault_points, LHS.parallel_bars_points AS parallel_bars_points, LHS.horizontal_bar_points AS horizontal_bar_points, LHS.total_points AS total_points, RHS.name AS name, RHS.age AS age, RHS.height AS height, RHS.hometown AS hometown FROM gymnast AS LHS INNER JOIN people AS RHS ON (LHS.gymnast_id = RHS.people_id)) ORDER BY age;

/*
Gold Result:
(20.0,)
(30.0,)
*/

-- Prediction Query
SELECT T2.Age FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID ORDER BY T1.Total_Points DESC, T1.gymnast_id NULLS LAST, T2.people_id NULLS LAST;

/*
Prediction Result:
(30.0,)
(20.0,)
*/