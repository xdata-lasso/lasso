-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'Great Western', 'Swindon Works', '1905', '4-6-0', 'Swindon', 'OBJ-101');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'London North', 'Doncaster', '1898', '0-6-0', 'York', 'OBJ-102');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (3, 'Midland', 'Derby Works', '1912', '0-6-0', 'Acton', 'OBJ-103');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (4, 'Southern', 'Brighton', '1920', '2-4-0', 'Brighton', 'OBJ-104');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (10, 1, 'T-01', 'Flying Scotsman', 'London', 'Edinburgh');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (11, 1, 'T-02', 'Cornish Riviera', 'Paddington', 'Penzance');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (12, 2, 'T-03', 'Yorkshire Pullman', 'Kings Cross', 'Leeds');
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (100, 'Arthur Pendelton', 'UK', '2001', 52, 3);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (101, 'Beatrice Clarke', 'UK', '2010', 41, 2);
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 100, '2012');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 101, '2015');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (3, 100, '2018');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT wheels, LOCATION FROM railway ORDER BY wheels, railway.railway_id NULLS LAST;

/*
Gold Result:
('0-6-0', 'York')
('0-6-0', 'Acton')
('2-4-0', 'Brighton')
('4-6-0', 'Swindon')
*/

-- Prediction Query
SELECT Wheels, LOCATION FROM railway;

/*
Prediction Result:
('4-6-0', 'Swindon')
('0-6-0', 'York')
('0-6-0', 'Acton')
('2-4-0', 'Brighton')
*/