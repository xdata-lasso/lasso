-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (16, '25', '22', '26', NULL, '28', '29');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (15, '22', NULL, '22', '22', '22', '22');
INSERT INTO "train" ("train_id", "railway_id", "train_num", "name", "from", "arrival") VALUES (22, 16, '22', '22', '22', '22');
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (18, '22', '22', '22', 22, 22);
INSERT INTO "manager" ("manager_id", "name", "country", "working_year_starts", "age", "level") VALUES (17, '22', '22', '22', 22, 22);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT builder FROM (SELECT LHS.railway_id AS railway_id, LHS.railway AS railway, LHS.builder AS builder, LHS.built AS built, LHS.wheels AS wheels, LHS.location AS LOCATION, LHS.objectnumber AS objectnumber, LHS.n AS n FROM (SELECT LHS.railway_id AS railway_id, LHS.railway AS railway, LHS.builder AS builder, LHS.built AS built, LHS.wheels AS wheels, LHS.location AS LOCATION, LHS.objectnumber AS objectnumber, RHS.n AS n FROM railway AS LHS INNER JOIN (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder) AS RHS ON (LHS.builder = RHS.builder)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder)) AS RHS ON (LHS.n = RHS.n)) ORDER BY builder;

/*
Gold Result:
('22',)
*/

-- Prediction Query
SELECT Builder FROM railway GROUP BY Builder ORDER BY COUNT(*) DESC, Builder NULLS LAST LIMIT 1;

/*
Prediction Result:
('22',)
*/