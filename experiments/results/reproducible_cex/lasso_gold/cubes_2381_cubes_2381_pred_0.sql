-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1001, 'Allison Hill', 1005.5, 1009.5, 'agreement', 'Pakistan');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1002, 'Noah Rhodes', 1012.5, 1018.5, 'option', 'Reunion');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1003, 'Angie Henderson', 1019.5, 1027.5, 'decide', 'Mayotte');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1004, 'Daniel Wagner', 1026.5, 1036.5, 'sense', 'Italy');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM mountain ORDER BY mountain_id) LIMIT 1);

/*
Gold Result:
('Allison Hill',)
*/

-- Prediction Query
SELECT Name FROM mountain ORDER BY Height DESC, mountain.mountain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Daniel Wagner',)
*/