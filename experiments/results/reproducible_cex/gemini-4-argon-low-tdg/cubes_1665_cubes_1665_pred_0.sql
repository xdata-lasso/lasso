-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'R1', 'Siemens', '1990', '4-4-0', 'Loc1', 'OBJ1');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'R2', 'Alstom', '1995', '2-6-0', 'Loc2', 'OBJ2');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (3, 'R2', 'Alstom', '1995', '2-6-0', 'Loc2', 'OBJ3');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (4, 'R4', 'Bombardier', '2000', '0-6-0', 'Loc3', 'OBJ4');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (5, 'R5', 'Bombardier', '2005', '0-6-0', 'Loc4', 'OBJ5');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (6, 'R6', 'Bombardier', '2010', '0-6-0', 'Loc5', 'OBJ6');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (1, 1, 'T1', 'Express1', 'CityA', '10:00');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (2, 1, 'T2', 'Express2', 'CityB', '12:00');
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (1, 'John', 'USA', '2000', 45, 3);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (2, 'Jane', 'UK', '2005', 38, 2);
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 1, '2010');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 2, '2012');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT builder FROM (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder) WHERE (n <> 1) ORDER BY builder;

/*
Gold Result:
('Alstom',)
('Bombardier',)
*/

-- Prediction Query
SELECT Builder FROM railway GROUP BY Builder ORDER BY COUNT(*) DESC, Builder NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bombardier',)
*/