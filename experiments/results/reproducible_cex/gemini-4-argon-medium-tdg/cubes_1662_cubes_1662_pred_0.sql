-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Deduplication (DISTINCT), alphabetical sorting (ORDER BY country ASC vs DESC vs insertion order), and erroneous INNER JOINs with railway_manage/railway/train (some managers are not in railway_manage).
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (1, 'Great Western', 'Swindon', '1923', '4-6-0', 'London', 'OBJ-01');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (1, 1, 'T100', 'Flying Scotsman', 'London', 'Edinburgh');
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (1, 'John', 'Zambia', '1995', 55, 1);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (2, 'Alice', 'Australia', '2010', 30, 5);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (3, 'Bob', 'Canada', '2005', 40, 3);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (4, 'Charlie', 'Australia', '2015', 25, 2);
INSERT INTO "railway_manage" ("Railway_ID", "Manager_ID", "From_Year") VALUES (1, 2, '2012');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM manager ORDER BY country;

/*
Gold Result:
('Australia',)
('Canada',)
('Zambia',)
*/

-- Prediction Query
SELECT DISTINCT Country FROM manager;

/*
Prediction Result:
('Zambia',)
('Australia',)
('Canada',)
*/