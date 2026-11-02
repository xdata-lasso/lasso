-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, name, age, height, hometown) VALUES (1, 'default2', 0.0, NULL, 'default1'), (2, NULL, 0.0, 1.0, NULL), (0, 'default2', NULL, NULL, 'default2');
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
(0.0,)
*/