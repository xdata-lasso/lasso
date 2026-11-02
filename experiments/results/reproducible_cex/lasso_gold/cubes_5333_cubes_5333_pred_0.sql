-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1056, 'Nathan Cortez', 1059.5, NULL, 'East Nathaniel');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1057, 'Pamela Romero', 1066.5, NULL, 'New Stephanie');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1058, 'Mario Skinner', 1073.5, NULL, 'New Mariotown');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1065, 'Jack Galloway', 1068.5, NULL, 'Port Amandaberg');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1066, 'Cynthia Allen', 1075.5, NULL, 'Lake Thomas');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1067, 'Angela Dennis', 1082.5, NULL, 'West Allison');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT LHS.people_id AS people_id, LHS.name AS name, LHS.age AS age, LHS.height AS height, LHS.hometown AS hometown, RHS.height AS height_other FROM people AS LHS CROSS JOIN (SELECT MAX(height) AS height FROM people) AS RHS) WHERE (height >= height_other) ORDER BY age;

/*
Gold Result:
*/

-- Prediction Query
SELECT Age FROM people ORDER BY Height DESC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1059.5,)
*/