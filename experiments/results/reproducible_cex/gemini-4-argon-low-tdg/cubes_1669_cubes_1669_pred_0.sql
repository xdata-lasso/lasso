-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicates (SELECT vs SELECT DISTINCT), NULL handling in Working_year_starts, and extraneous INNER JOINs with railway_manage.
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (1, 'Great Western', 'Swindon', '1920', '4-6-0', 'London', 'GW1');
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (1, 'Alice', 'UK', '2005', 45, 3);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (2, 'Bob', 'USA', '1998', 52, 5);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (3, 'Charlie', 'UK', '2005', 39, 2);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (4, 'Diana', 'Canada', NULL, 29, 1);
INSERT INTO "railway_manage" ("Railway_ID", "Manager_ID", "From_Year") VALUES (1, 1, '2010');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT working_year_starts FROM manager ORDER BY working_year_starts, manager.manager_id NULLS LAST;

/*
Gold Result:
(None,)
('1998',)
('2005',)
('2005',)
*/

-- Prediction Query
SELECT Working_year_starts FROM manager ORDER BY LEVEL DESC, manager.manager_id NULLS LAST;

/*
Prediction Result:
('1998',)
('2005',)
('2005',)
(None,)
*/