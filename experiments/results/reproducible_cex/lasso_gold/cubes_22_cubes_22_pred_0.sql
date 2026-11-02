-- Schema DDL
CREATE TABLE "i011_1" ("VehicleID" INTEGER, "Name" TEXT);

CREATE TABLE "i011_2" ("LocationID" INTEGER, "VehicleID" INTEGER, "City" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1003, 'Stephanie Miller');
INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1005, 'Jonathan Johnson');
INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1005, 'Connie Lawrence');
INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (1004, 1003, 'Johnsonland');
INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (1006, 1005, NULL);
INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (1007, 1005, 'Port Lindachester');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "vehicleid", "name", "concatcity" FROM (SELECT "LHS"."vehicleid" AS "vehicleid", "LHS"."name" AS "name", "RHS"."concatcity" AS "concatcity" FROM "i011_1" AS "LHS" INNER JOIN (SELECT "vehicleid", GROUP_CONCAT("city", ', ') AS concatcity FROM i011_2 GROUP BY vehicleid) AS RHS ON (LHS.vehicleid = RHS.vehicleid)) ORDER BY vehicleid, "vehicleid" NULLS LAST, "name" NULLS LAST, "concatcity" NULLS LAST;

/*
Gold Result:
(1003, 'Stephanie Miller', 'Johnsonland')
(1005, 'Connie Lawrence', 'Port Lindachester')
(1005, 'Jonathan Johnson', 'Port Lindachester')
*/

-- Prediction Query
SELECT i011_1.VehicleID, i011_1.Name, t.concatLocations FROM (SELECT VehicleID, City AS concatLocations FROM i011_2 GROUP BY VehicleID) AS t JOIN i011_1 ON i011_1.VehicleID = t.VehicleID;

/*
Prediction Result:
(1003, 'Stephanie Miller', 'Johnsonland')
(1005, 'Jonathan Johnson', None)
(1005, 'Connie Lawrence', None)
*/