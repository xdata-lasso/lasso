-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'Great Northern', 'Doncaster', '1890', '4-4-0', 'York', 'OBJ-300');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'London Midland', 'Crewe', '1910', '4-6-2', 'London', 'OBJ-100');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (3, 'Southern', 'Brighton', '1925', '2-6-0', 'Brighton', 'OBJ-200');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (4, 'Western', 'Swindon', '1905', '4-6-0', 'Bristol', 'OBJ-050');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (3, 2, 'T-101', 'Flying Scotsman', 'London', 'Edinburgh');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (10, 2, 'T-102', 'Royal Scot', 'London', 'Glasgow');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (20, 4, 'T-201', 'Cornish Riviera', 'London', 'Penzance');
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (1, 'John Smith', 'UK', '2000', 45, 3);
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 1, '2010');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (4, 1, '2012');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT objectnumber FROM (SELECT * FROM railway AS LHS WHERE NOT EXISTS(SELECT 1 FROM train AS RHS WHERE (LHS.railway_id = RHS.railway_id))) ORDER BY objectnumber;

/*
Gold Result:
('OBJ-200',)
('OBJ-300',)
*/

-- Prediction Query
SELECT ObjectNumber FROM railway WHERE NOT Railway_ID IN (SELECT Railway_ID FROM train);

/*
Prediction Result:
('OBJ-300',)
('OBJ-200',)
*/