-- Schema DDL
CREATE TABLE "REPAIR" (
    "REPAIR_ID" INT,
    "NAME" TEXT,
    "LAUNCH_DATE" TEXT,
    "NOTES" TEXT,
    PRIMARY KEY ("REPAIR_ID")
);
CREATE TABLE "MACHINE" (
    "MACHINE_ID" INT,
    "MAKING_YEAR" INT,
    "CLASS" TEXT,
    "TEAM" TEXT,
    "MACHINE_SERIES" TEXT,
    "VALUE_POINTS" FLOAT,
    "QUALITY_RANK" INT,
    PRIMARY KEY ("MACHINE_ID")
);
CREATE TABLE "TECHNICIAN" (
    "TECHNICIAN_ID" FLOAT,
    "NAME" TEXT,
    "TEAM" TEXT,
    "STARTING_YEAR" FLOAT,
    "AGE" INT,
    PRIMARY KEY ("TECHNICIAN_ID")
);
CREATE TABLE "REPAIR_ASSIGNMENT" (
    "TECHNICIAN_ID" INT,
    "REPAIR_ID" INT,
    "MACHINE_ID" INT,
    PRIMARY KEY ("TECHNICIAN_ID", "REPAIR_ID", "MACHINE_ID"),
    FOREIGN KEY ("MACHINE_ID") REFERENCES "MACHINE"("MACHINE_ID"),
    FOREIGN KEY ("REPAIR_ID") REFERENCES "REPAIR"("REPAIR_ID"),
    FOREIGN KEY ("TECHNICIAN_ID") REFERENCES "TECHNICIAN"("TECHNICIAN_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO REPAIR VALUES (1, 0, 0, 0);
INSERT INTO REPAIR VALUES (0, 0, 0, 0);
INSERT INTO MACHINE VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO MACHINE VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO TECHNICIAN VALUES (0, -2, 29, 30, -1);
INSERT INTO TECHNICIAN VALUES (1, -2, 31, 32, 0);
INSERT INTO REPAIR_ASSIGNMENT VALUES (0, 1, 0);
INSERT INTO REPAIR_ASSIGNMENT VALUES (1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id FROM technician AS LHS INNER JOIN repair_assignment AS RHS ON (LHS.technician_id = RHS.technician_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('-2', 1)
('-2', 1)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM repair_assignment AS T1 JOIN technician AS T2 ON T1.technician_ID = T2.technician_ID GROUP BY T2.Name;

/*
Prediction Result:
('-2', 2)
*/