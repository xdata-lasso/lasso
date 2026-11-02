-- Schema DDL
CREATE TABLE "i011_1" ("VehicleID" INTEGER, "Name" TEXT);

CREATE TABLE "i011_2" ("LocationID" INTEGER, "VehicleID" INTEGER, "City" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "i011_1" ("VehicleID", "Name") VALUES (1, 'Truck');
INSERT INTO "i011_1" ("VehicleID", "Name") VALUES (2, 'Van');
INSERT INTO "i011_1" ("VehicleID", "Name") VALUES (3, 'Car');
INSERT INTO "i011_2" ("LocationID", "VehicleID", "City") VALUES (101, 1, 'NY');
INSERT INTO "i011_2" ("LocationID", "VehicleID", "City") VALUES (102, 2, 'LA');
INSERT INTO "i011_2" ("LocationID", "VehicleID", "City") VALUES (103, 2, 'Seattle');
INSERT INTO "i011_2" ("LocationID", "VehicleID", "City") VALUES (104, 4, 'Miami');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "vehicleid", "name", "concatcity" FROM (SELECT "LHS"."vehicleid" AS "vehicleid", "LHS"."name" AS "name", "RHS"."concatcity" AS "concatcity" FROM "i011_1" AS "LHS" INNER JOIN (SELECT "vehicleid", GROUP_CONCAT("city", ', ') AS concatcity FROM i011_2 GROUP BY vehicleid) AS RHS ON (LHS.vehicleid = RHS.vehicleid)) ORDER BY vehicleid, "vehicleid" NULLS LAST, "name" NULLS LAST, "concatcity" NULLS LAST;

/*
Gold Result:
(1, 'Truck', 'NY')
(2, 'Van', 'LA, Seattle')
*/

-- Prediction Query
SELECT i011_1.VehicleID, i011_1.Name, t.concatLocations FROM (SELECT VehicleID, City AS concatLocations FROM i011_2 GROUP BY VehicleID) AS t JOIN i011_1 ON i011_1.VehicleID = t.VehicleID;

/*
Prediction Result:
(1, 'Truck', 'NY')
(2, 'Van', 'LA')
*/