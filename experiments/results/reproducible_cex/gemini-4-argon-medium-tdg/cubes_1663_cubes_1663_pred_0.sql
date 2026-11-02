-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests age boundaries (45, 46, 47, 49, 50, 51) and ORDER BY with non-matching insertion order
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (1, 'Alice', 'USA', '2010', 46, 1);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (2, 'Bob', 'Canada', '2012', 45, 2);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (3, 'Charlie', 'Mexico', '2015', 47, 3);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (4, 'David', 'UK', '2008', 49, 1);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (5, 'Eve', 'France', '2011', 50, 2);
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (6, 'Frank', 'Germany', '2005', 51, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM manager WHERE (age < 50 AND age <= 46) ORDER BY country;

/*
Gold Result:
('Canada',)
('USA',)
*/

-- Prediction Query
SELECT Country FROM manager WHERE Age > 50 INTERSECT SELECT Country FROM manager WHERE Age < 46;

/*
Prediction Result:
*/