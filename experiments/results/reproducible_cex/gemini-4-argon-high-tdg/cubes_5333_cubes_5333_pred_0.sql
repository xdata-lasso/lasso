-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'David', 32.0, 190.0, 'Austin');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Eve', 21.0, 190.0, 'Seattle');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Frank', 21.0, 190.0, 'Miami');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (4, 'Grace', 18.0, 175.0, 'Portland');
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (1, 13.0, 13.5, 14.0, 14.5, 13.8, 13.2, 82.0);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (3, 14.0, 14.2, 14.1, 14.8, 14.5, 14.4, 86.0);
INSERT INTO gymnast (Gymnast_ID, Floor_Exercise_Points, Pommel_Horse_Points, Rings_Points, Vault_Points, Parallel_Bars_Points, Horizontal_Bar_Points, Total_Points) VALUES (4, 15.0, 15.1, 15.2, 15.3, 15.4, 15.5, 91.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.height AS height_other FROM people AS LHS CROSS JOIN (SELECT MAX(height) AS height FROM people) AS RHS) WHERE (height >= height_other) ORDER BY age;

/*
Gold Result:
(21.0,)
(21.0,)
(32.0,)
*/

-- Prediction Query
SELECT Age FROM people ORDER BY Height DESC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(32.0,)
*/