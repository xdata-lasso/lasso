-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (1, 'Zoe', NULL, 170.0, 'Detroit');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (2, 'Zoe', 27.0, 171.0, 'Houston');
INSERT INTO people (People_ID, Name, Age, Height, Hometown) VALUES (3, 'Aaron', 20.0, 185.0, 'San Diego');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT * FROM (SELECT * FROM people ORDER BY name DESC, people.people_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Age FROM people ORDER BY Height DESC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(20.0,)
*/