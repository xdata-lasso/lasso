-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'Great Northern', 'Baldwin', '1895', '4-4-0', 'Chicago', 'GN-101');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'Union Pacific', 'ALCO', '1910', '4-6-2', 'Omaha', 'UP-202');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (1, 1, 'T-10', 'Empire Builder', 'Chicago', 'Seattle');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (2, 2, 'T-20', 'Overland Flyer', 'Omaha', 'San Francisco');
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (1, 'John Smith', 'USA', '2010', 45, 3);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (2, 'Alice Brown', 'UK', '1998', 52, 1);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (3, 'Carlos Diaz', 'Spain', '2005', 38, 4);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (4, 'Diana Prince', 'Canada', '1998', 41, 2);
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 1, '2012');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (2, 1, '2015');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 3, '2008');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT working_year_starts FROM manager ORDER BY working_year_starts, manager.manager_id NULLS LAST;

/*
Gold Result:
('1998',)
('1998',)
('2005',)
('2010',)
*/

-- Prediction Query
SELECT Working_year_starts FROM manager ORDER BY LEVEL DESC, manager.manager_id NULLS LAST;

/*
Prediction Result:
('2005',)
('2010',)
('1998',)
('1998',)
*/