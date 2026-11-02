-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (1, 'Great Western', 'Swindon', '1920', '4-6-0', 'London', 'GW101');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (2, 'Eastern Rail', 'Doncaster', '1935', '4-6-2', 'York', 'ER202');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (1, 1, 'T100', 'Flying Scotsman', 'London', 'Edinburgh');
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (1, 'Alice', 'USA', '2010', 45, 5);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (2, 'Bob', 'Australia', '2015', 30, 2);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (3, 'Charlie', 'Canada', '2005', 60, 10);
INSERT INTO "railway_manage" ("Railway_ID", "Manager_ID", "From_Year") VALUES (1, 1, '2012');
INSERT INTO "railway_manage" ("Railway_ID", "Manager_ID", "From_Year") VALUES (2, 3, '2008');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LEVEL AS max_level_ FROM (SELECT * FROM (SELECT * FROM (SELECT LEVEL, manager_id, MAX(country) AS country FROM manager GROUP BY LEVEL, manager_id) ORDER BY country) LIMIT 1);

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT MAX(LEVEL) FROM manager WHERE Country <> 'Australia ';

/*
Prediction Result:
(10,)
*/