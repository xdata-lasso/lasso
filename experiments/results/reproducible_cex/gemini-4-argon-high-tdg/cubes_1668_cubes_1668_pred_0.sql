-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'Great Western', 'Swindon', '1925', '4-6-0', 'London', 'GW-101');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'Pacific Express', 'Baldwin', '1932', '4-6-2', 'Chicago', 'PE-202');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (1, 1, 'T-10', 'Flying Scotsman', 'London', 'Edinburgh');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (2, 2, 'T-20', 'Zephyr', 'Chicago', 'Denver');
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (1, 'Alice Smith', 'USA', '1995', 51, 3);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (2, 'Bob Martin', 'France', '1998', 50, 4);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (3, 'Clara Weber', 'Germany', '2010', 45, 2);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (4, 'David Roy', 'Canada', '2005', 46, 2);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (5, 'Eduardo Silva', 'Brazil', '1988', 60, 5);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (6, 'Fiona Taylor', 'Australia', '2001', 48, 3);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (7, 'Gabriel Costa', 'Brazil', '2015', 40, 1);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (8, 'Harpreet Singh', 'India', '2000', NULL, 2);
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 1, '2012');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (2, 1, '2016');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 2, '2018');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM manager WHERE (age > 50 OR age < 46) ORDER BY country, manager.manager_id NULLS LAST;

/*
Gold Result:
('Brazil',)
('Brazil',)
('Germany',)
('USA',)
*/

-- Prediction Query
SELECT Country FROM manager WHERE Age > 50 OR Age < 46;

/*
Prediction Result:
('USA',)
('Germany',)
('Brazil',)
('Brazil',)
*/