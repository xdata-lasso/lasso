-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'Great North', 'Beta', '1901', '4-4-0', 'York', 'OBJ-101');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'Midland', 'Gamma', '1905', '0-6-0', 'Derby', 'OBJ-102');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (3, 'Western', 'Alpha', '1910', '4-6-0', 'Swindon', 'OBJ-103');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (4, 'Southern', 'Beta', '1912', '2-6-0', 'Brighton', 'OBJ-104');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (5, 'Eastern', 'Gamma', '1915', '4-4-2', 'Doncaster', 'OBJ-105');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (6, 'Highland', 'Alpha', '1918', '4-6-2', 'Inverness', 'OBJ-106');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (7, 'Caledonian', 'Alpha', '1920', '0-4-4', 'Glasgow', 'OBJ-107');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (8, 'Cambrian', 'Beta', '1922', '2-4-0', 'Oswestry', 'OBJ-108');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (9, 'Furness', 'Beta', '1925', '0-6-2', 'Barrow', 'OBJ-109');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (10, 'SharedLine', 'Delta', '1930', '2-8-0', 'Crewe', 'OBJ-110');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (11, 'SharedLine', 'Epsilon', '1930', '2-8-0', 'Crewe', 'OBJ-110');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (1, 10, 'T100', 'Express A', 'Crewe', 'London');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (2, 10, 'T101', 'Express B', 'Crewe', 'Manchester');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (3, 1, 'T102', 'Northern Star', 'York', 'Edinburgh');
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (1, 'John Smith', 'UK', '2000', 50, 3);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (2, 'Alice Brown', 'UK', '2005', 45, 2);
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (10, 1, '2010');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (10, 2, '2012');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (3, 1, '2015');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT builder FROM (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder) WHERE (n <> 1) ORDER BY builder;

/*
Gold Result:
('Alpha',)
('Beta',)
('Gamma',)
*/

-- Prediction Query
SELECT Builder FROM railway GROUP BY Builder ORDER BY COUNT(*) DESC, Builder NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beta',)
*/