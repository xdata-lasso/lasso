-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'Great Western', 'Swindon', '1923', '4-6-0', 'London', 'OBJ-01');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'Pacific Union', 'Baldwin', '1935', '4-8-4', 'Chicago', 'OBJ-02');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (1, 1, 'T100', 'Flying Scotsman', 'London', 'Edinburgh');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (2, 2, 'T200', 'Zephyr', 'Chicago', 'Denver');
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (1, 'Zack', 'USA', '2010', 45, 3);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (2, 'Alice', 'UK', '2015', 38, 5);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (3, 'Bob', 'Canada', '2012', 50, 1);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (4, 'Alice', 'Australia', '2018', 29, 2);
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 1, '2015');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (2, 1, '2018');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 2, '2019');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM manager ORDER BY name, manager.manager_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM manager ORDER BY LEVEL ASC, manager.manager_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Alice',)
('Zack',)
('Alice',)
*/