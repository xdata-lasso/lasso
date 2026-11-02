-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, age, height, hometown) VALUES (1, 'default2', 1.0, 0.0, NULL), (0, 'default2', 0.0, 1.0, 'default2');
INSERT INTO gymnast (gymnast_id, floor_exercise_points, pommel_horse_points, rings_points, vault_points, parallel_bars_points, horizontal_bar_points, total_points) VALUES (0, NULL, 2.0, NULL, 2.0, 0.0, 0.0, 0.0), (1, 2.0, 0.0, 1.0, 0.0, 1.0, 2.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT total_points FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.gymnast_id AS gymnast_id, LHS.floor_exercise_points AS floor_exercise_points, LHS.pommel_horse_points AS pommel_horse_points, LHS.rings_points AS rings_points, LHS.vault_points AS vault_points, LHS.parallel_bars_points AS parallel_bars_points, LHS.horizontal_bar_points AS horizontal_bar_points, LHS.total_points AS total_points, RHS.people_id AS people_id, RHS.name AS name, RHS.age AS age, RHS.height AS height, RHS.hometown AS hometown FROM gymnast AS LHS CROSS JOIN people AS RHS) ORDER BY rings_points DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.Total_Points FROM gymnast AS T1 JOIN people AS T2 ON T1.Gymnast_ID = T2.People_ID ORDER BY T2.Age ASC, T1.gymnast_id NULLS LAST, T2.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(0.0,)
*/