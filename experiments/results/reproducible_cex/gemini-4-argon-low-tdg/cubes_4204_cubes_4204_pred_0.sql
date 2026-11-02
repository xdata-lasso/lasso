-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'R1', 'Builder_Z', '1910', '4-6-2', 'Loc1', 'Obj1');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'R2', 'Builder_Z', '1911', '4-6-2', 'Loc2', 'Obj2');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (3, 'R3', 'Builder_A', '1912', '2-8-2', 'Loc3', 'Obj3');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (4, 'R4', 'Builder_A', '1913', '2-8-2', 'Loc4', 'Obj4');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (5, 'R5', 'Builder_M', '1914', '0-4-0', 'Loc5', 'Obj5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT builder FROM (SELECT LHS.railway_id AS railway_id, LHS.railway AS railway, LHS.builder AS builder, LHS.built AS built, LHS.wheels AS wheels, LHS.location AS LOCATION, LHS.objectnumber AS objectnumber, LHS.n AS n FROM (SELECT LHS.railway_id AS railway_id, LHS.railway AS railway, LHS.builder AS builder, LHS.built AS built, LHS.wheels AS wheels, LHS.location AS LOCATION, LHS.objectnumber AS objectnumber, RHS.n AS n FROM railway AS LHS INNER JOIN (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder) AS RHS ON (LHS.builder = RHS.builder)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder)) AS RHS ON (LHS.n = RHS.n)) ORDER BY builder;

/*
Gold Result:
('Builder_A',)
('Builder_Z',)
*/

-- Prediction Query
SELECT Builder FROM railway GROUP BY Builder ORDER BY COUNT(*) DESC, Builder NULLS LAST LIMIT 1;

/*
Prediction Result:
('Builder_A',)
*/