-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Aaron', 21.0, 172.0, 'Seattle');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Charlie', 25.0, 160.0, 'Austin');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Alice', 22.0, 165.0, 'Chicago');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (4, 'Bob', 19.0, 175.0, 'Denver');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (5, 'Zack', 28.0, 180.0, 'Miami');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (2, 13.8, 13.8, 15.1, 14.8, 14.2, 12.0, 83.7);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (3, 14.5, 13.0, 14.0, 15.0, 13.5, 14.2, 84.2);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (4, 15.2, 14.5, 13.2, 14.1, 15.0, 14.5, 86.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.gymnast_id AS gymnast_id, LHS.floor_exercise_points AS floor_exercise_points, LHS.pommel_horse_points AS pommel_horse_points, LHS.rings_points AS rings_points, LHS.vault_points AS vault_points, LHS.parallel_bars_points AS parallel_bars_points, LHS.horizontal_bar_points AS horizontal_bar_points, LHS.total_points AS total_points, RHS.name AS name, RHS.age AS age, RHS.height AS height, RHS.hometown AS hometown FROM gymnast AS LHS INNER JOIN people AS RHS ON (LHS.gymnast_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT T2.Name FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID;

/*
Prediction Result:
('Charlie',)
('Alice',)
('Bob',)
*/