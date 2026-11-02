-- Schema DDL
CREATE TABLE "gymnast" ("Gymnast_ID" INTEGER PRIMARY KEY, "Floor_Exercise_Points" REAL, "Pommel_Horse_Points" REAL, "Rings_Points" REAL, "Vault_Points" REAL, "Parallel_Bars_Points" REAL, "Horizontal_Bar_Points" REAL, "Total_Points" REAL, FOREIGN KEY ("Gymnast_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL, "Height" REAL, "Hometown" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (2, '5k5swwqcgs', 20.0, 171.746906, 'peo_78c428');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (3, 'n8c4pgu7v', 20.0, 86.520366, 'peo_78c428');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (4, '4h', 22.99, 268.82475, 'a2ypuzhsrwbb');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (5, '5k5swwqcgs', 23.0, 171.746906, 'n8c4pgu7v');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (6, '5k5swwqcgs', NULL, 171.746906, 'n8c4pgu7v');

INSERT INTO "people" ("people_id", "name", "age", "height", "hometown") VALUES (7, 'e4', NULL, 779.409124, 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT hometown FROM people WHERE (age < 23.0 AND age = 20.0) ORDER BY hometown;

/*
Gold Result:
('peo_78c428',)
*/

-- Prediction Query
SELECT Hometown FROM people WHERE Age > 23 INTERSECT SELECT Hometown FROM people WHERE Age < 20;

/*
Prediction Result:
*/