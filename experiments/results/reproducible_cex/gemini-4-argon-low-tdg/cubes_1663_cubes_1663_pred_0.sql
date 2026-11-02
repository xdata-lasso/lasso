-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (1, 'Great Western', 'Swindon', '1930', '4-6-0', 'London', 'GW101');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (2, 'Pacific Union', 'Baldwin', '1945', '4-8-4', 'Omaha', 'PU202');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (1, 1, 'T100', 'Flying Scotsman', 'London', 'Edinburgh');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (2, 2, 'T200', 'Big Boy', 'Omaha', 'Ogden');
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (1, 'John', 'USA', '2010', 45, 5);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (2, 'Jane', 'USA', '2012', 30, 5);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (3, 'Alice', 'Canada', '2008', 46, 6);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (4, 'Bob', 'UK', '2005', 47, 7);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (5, 'Charlie', 'France', '2001', 49, 8);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (6, 'David', 'Germany', '1999', 50, 9);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (7, 'Eve', 'Spain', '1995', 51, 10);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (8, 'Frank', 'Brazil', '2018', 25, 3);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (9, 'Grace', 'Australia', '2015', NULL, 4);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (10, 'Heidi', NULL, '2016', 40, 4);
INSERT INTO "railway_manage" ("Railway_ID", "Manager_ID", "From_Year") VALUES (1, 1, '2015');
INSERT INTO "railway_manage" ("Railway_ID", "Manager_ID", "From_Year") VALUES (2, 4, '2016');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM manager WHERE (age < 50 AND age <= 46) ORDER BY country;

/*
Gold Result:
(None,)
('Brazil',)
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT Country FROM manager WHERE Age > 50 INTERSECT SELECT Country FROM manager WHERE Age < 46;

/*
Prediction Result:
*/