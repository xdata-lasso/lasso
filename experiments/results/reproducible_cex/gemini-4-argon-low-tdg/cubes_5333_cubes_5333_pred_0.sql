-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for maximum height with distinct ages (in reverse insertion order to test ORDER BY age ASC),
-- duplicate ages among the tied maximum heights (to catch spurious DISTINCT),
-- and the absence of a gymnast entry for one of the winning people (to catch spurious INNER JOIN with gymnast).
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (1, 'Alice', 30.0, 180.0, 'New York');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (2, 'Bob', 20.0, 180.0, 'Los Angeles');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (3, 'Charlie', 20.0, 180.0, 'Chicago');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (4, 'David', 40.0, 175.0, 'Houston');
INSERT INTO "people" ("People_ID", "Name", "Age", "Height", "Hometown") VALUES (5, 'Eve', 18.0, 160.0, 'Phoenix');
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (1, 14.5, 13.0, 14.0, 15.0, 14.2, 13.8, 84.5);
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (3, 15.0, 14.5, 14.8, 15.2, 15.0, 14.5, 89.0);
INSERT INTO "gymnast" ("Gymnast_ID", "Floor_Exercise_Points", "Pommel_Horse_Points", "Rings_Points", "Vault_Points", "Parallel_Bars_Points", "Horizontal_Bar_Points", "Total_Points") VALUES (4, 13.0, 12.5, 13.0, 14.0, 13.5, 13.0, 79.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.height AS height_other FROM people AS LHS CROSS JOIN (SELECT MAX(height) AS height FROM people) AS RHS) WHERE (height >= height_other) ORDER BY age;

/*
Gold Result:
(20.0,)
(20.0,)
(30.0,)
*/

-- Prediction Query
SELECT Age FROM people ORDER BY Height DESC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(30.0,)
*/