-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1020, 'Jamie Arnold', 'Djibouti', 'fall', 1024, 1028);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1021, 'Lisa Hensley', 'Tonga', 'long', 1035.0, 1028);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1022, 'Michele Williams', 'Bolivia', 'prove', 1046.0, 1028);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1023, 'Dylan Miller', 'Hong Kong', 'they', 1057.0, 1028);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1029, 'Jacob Clark', NULL, 'reveal', 1033, 1037);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1030, 'Timothy Wong', NULL, 'garden', 1044.0, 1037);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1031, 'Carolyn Daniel', NULL, 'threat', 1055.0, 1037);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (1032, 'James Mayo', NULL, 'special', 1066.0, 1037);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LEVEL AS max_level_ FROM (SELECT * FROM (SELECT * FROM (SELECT LEVEL, manager_id, MAX(country) AS country FROM manager GROUP BY LEVEL, manager_id) ORDER BY country) LIMIT 1);

/*
Gold Result:
(1037,)
*/

-- Prediction Query
SELECT MAX(LEVEL) FROM manager WHERE Country <> 'Australia ';

/*
Prediction Result:
(1028,)
*/