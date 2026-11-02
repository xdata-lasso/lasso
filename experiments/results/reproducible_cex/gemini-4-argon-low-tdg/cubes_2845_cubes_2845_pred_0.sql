-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Alice', 22.0, 165.0, 'New York');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Bob', 25.0, 175.0, 'Chicago');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Charlie', 20.0, 180.0, 'Los Angeles');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (1, 15.5, 14.0, 16.0, 13.5, 14.5, 15.0, 88.5);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (2, 16.0, 15.5, 14.5, 15.0, 16.0, 15.5, 92.5);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (3, 14.0, 13.5, 15.0, 16.0, 13.0, 14.0, 85.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.gymnast_id AS gymnast_id, LHS.floor_exercise_points AS floor_exercise_points, LHS.pommel_horse_points AS pommel_horse_points, LHS.rings_points AS rings_points, LHS.vault_points AS vault_points, LHS.parallel_bars_points AS parallel_bars_points, LHS.horizontal_bar_points AS horizontal_bar_points, LHS.total_points AS total_points, RHS.people_id AS people_id, RHS.name AS name, RHS.age AS age, RHS.height AS height, RHS.hometown AS hometown FROM gymnast AS LHS CROSS JOIN people AS RHS) ORDER BY rings_points DESC) LIMIT 1);

/*
Gold Result:
(88.5,)
*/

-- Prediction Query
SELECT T1.Total_Points FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID ORDER BY T2.Age ASC, T1.gymnast_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(85.5,)
*/