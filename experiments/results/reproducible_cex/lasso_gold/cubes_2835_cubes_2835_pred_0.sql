-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1001, 'Allison Hill', 1005.5, 1009.5, 'New Jamesside');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1002, 'Noah Rhodes', 1012.5, 1018.5, 'Robinsonshire');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1003, 'Angie Henderson', 1019.5, 1027.5, 'Lisatown');
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (1004, 'Daniel Wagner', 1026.5, 1036.5, 'Lake Roberto');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT * FROM (SELECT * FROM people ORDER BY name DESC, people.people_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(1012.5,)
*/

-- Prediction Query
SELECT Age FROM people ORDER BY Height DESC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1026.5,)
*/