-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1004, 'determine', 'religious', 'example', 'science', 'USS Lynch
FPO AE 70511', 'shoulder');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1005, 'election', 'religious', 'common', 'maintain', '503 Linda Locks
Carlshire, FM 94599', 'forward');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1006, 'difference', 'reality', 'money', 'individual', '42388 Burgess Meadow Suite 532
Daviston, VI 14872', 'claim');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1007, NULL, 'collection', 'structure', 'response', '6978 Maddox Wall
Lake Jenniferside, WV 35474', 'specific');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1008, NULL, 'collection', 'grow', 'brother', '0482 Monica Hills
East Nathaniel, GA 71198', 'start');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1009, NULL, 'nice', 'why', 'a', '15430 Natalie Common Apt. 718
East Donna, OH 22144', 'evidence');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT builder FROM (SELECT LHS.railway_id AS railway_id, LHS.railway AS railway, LHS.builder AS builder, LHS.built AS built, LHS.wheels AS wheels, LHS.location AS LOCATION, LHS.objectnumber AS objectnumber, LHS.n AS n FROM (SELECT LHS.railway_id AS railway_id, LHS.railway AS railway, LHS.builder AS builder, LHS.built AS built, LHS.wheels AS wheels, LHS.location AS LOCATION, LHS.objectnumber AS objectnumber, RHS.n AS n FROM railway AS LHS INNER JOIN (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder) AS RHS ON (LHS.builder = RHS.builder)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder)) AS RHS ON (LHS.n = RHS.n)) ORDER BY builder;

/*
Gold Result:
('collection',)
('religious',)
*/

-- Prediction Query
SELECT Builder FROM railway GROUP BY Builder ORDER BY COUNT(*) DESC, Builder NULLS LAST LIMIT 1;

/*
Prediction Result:
('collection',)
*/