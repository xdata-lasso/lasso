-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (10, 'North Line', 'Builder A', '1950', '4-6-2', 'London', 'OBJ-10');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (20, 'South Line', 'Builder B', '1960', '2-8-0', 'Manchester', 'OBJ-20');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (1, 20, 'T99', 'Zebra Express', 'York', '14:00');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (2, 20, 'T50', 'Alpha Flyer', 'Leeds', '18:00');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (3, 10, 'T10', 'Alpha Flyer', 'Bath', '09:00');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (4, 10, 'T05', 'Beta Local', 'Bristol', '11:30');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (5, 20, 'T01', 'Beta Local', 'Oxford', '11:30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, arrival FROM train ORDER BY name, train.train_id NULLS LAST;

/*
Gold Result:
('Alpha Flyer', '18:00')
('Alpha Flyer', '09:00')
('Beta Local', '11:30')
('Beta Local', '11:30')
('Zebra Express', '14:00')
*/

-- Prediction Query
SELECT Name, Arrival FROM train;

/*
Prediction Result:
('Zebra Express', '14:00')
('Alpha Flyer', '18:00')
('Alpha Flyer', '09:00')
('Beta Local', '11:30')
('Beta Local', '11:30')
*/