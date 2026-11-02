-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (1, 'Alice', 'Austria', '2010', 35, 1);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (2, 'Bob', 'Belgium', '2012', 40, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LEVEL AS max_level_ FROM (SELECT * FROM (SELECT * FROM (SELECT LEVEL, manager_id, MAX(country) AS country FROM manager GROUP BY LEVEL, manager_id) ORDER BY country) LIMIT 1);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT MAX(LEVEL) FROM manager WHERE Country <> 'Australia ';

/*
Prediction Result:
(10,)
*/