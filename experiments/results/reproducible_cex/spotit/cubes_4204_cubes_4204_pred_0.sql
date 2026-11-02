-- Schema DDL
CREATE TABLE "RAILWAY" (
    "RAILWAY_ID" INT,
    "RAILWAY" TEXT,
    "BUILDER" TEXT,
    "BUILT" TEXT,
    "WHEELS" TEXT,
    "LOCATION" TEXT,
    "OBJECTNUMBER" TEXT,
    PRIMARY KEY ("RAILWAY_ID")
);
CREATE TABLE "TRAIN" (
    "TRAIN_ID" INT,
    "RAILWAY_ID" INT,
    "TRAIN_NUM" TEXT,
    "NAME" TEXT,
    "FROM" TEXT,
    "ARRIVAL" TEXT,
    PRIMARY KEY ("TRAIN_ID"),
    FOREIGN KEY ("RAILWAY_ID") REFERENCES "RAILWAY"("RAILWAY_ID")
);
CREATE TABLE "MANAGER" (
    "MANAGER_ID" INT,
    "NAME" TEXT,
    "COUNTRY" TEXT,
    "WORKING_YEAR_STARTS" TEXT,
    "AGE" INT,
    "LEVEL" INT,
    PRIMARY KEY ("MANAGER_ID")
);
CREATE TABLE "RAILWAY_MANAGE" (
    "RAILWAY_ID" INT,
    "MANAGER_ID" INT,
    "FROM_YEAR" TEXT,
    PRIMARY KEY ("RAILWAY_ID", "MANAGER_ID"),
    FOREIGN KEY ("RAILWAY_ID") REFERENCES "RAILWAY"("RAILWAY_ID"),
    FOREIGN KEY ("MANAGER_ID") REFERENCES "MANAGER"("MANAGER_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO RAILWAY VALUES (0, 16, 0, 17, 18, 19, 20);
INSERT INTO RAILWAY VALUES (1, 10, -1, 11, 12, 13, 14);
INSERT INTO TRAIN VALUES (-1, 1, 0, 0, 0, 0);
INSERT INTO TRAIN VALUES (0, 1, 0, 0, 0, 0);
INSERT INTO MANAGER VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO MANAGER VALUES (-1, 0, 0, 0, 0, 0);
INSERT INTO RAILWAY_MANAGE VALUES (1, 0, 0);
INSERT INTO RAILWAY_MANAGE VALUES (0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT builder FROM (SELECT LHS.railway_id AS railway_id, LHS.railway AS railway, LHS.builder AS builder, LHS.built AS built, LHS.wheels AS wheels, LHS.location AS LOCATION, LHS.objectnumber AS objectnumber, LHS.n AS n FROM (SELECT LHS.railway_id AS railway_id, LHS.railway AS railway, LHS.builder AS builder, LHS.built AS built, LHS.wheels AS wheels, LHS.location AS LOCATION, LHS.objectnumber AS objectnumber, RHS.n AS n FROM railway AS LHS INNER JOIN (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder) AS RHS ON (LHS.builder = RHS.builder)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT builder, COUNT(*) AS n FROM railway GROUP BY builder)) AS RHS ON (LHS.n = RHS.n)) ORDER BY builder;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT Builder FROM railway GROUP BY Builder ORDER BY COUNT(*) DESC, Builder NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/