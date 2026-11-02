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
INSERT INTO REPAIR VALUES (0, 0, 0, 0);
INSERT INTO REPAIR VALUES (-2, 0, 0, 0);
INSERT INTO MACHINE VALUES (1, 0, 125, 126, NULL, 128, -1);
INSERT INTO MACHINE VALUES (0, 0, NULL, NULL, 131, 132, 0);
INSERT INTO TECHNICIAN VALUES (2, 12, 13, 14, 0);
INSERT INTO TECHNICIAN VALUES (1, -2, 15, 16, 0);
INSERT INTO REPAIR_ASSIGNMENT VALUES (2, 0, 0);
INSERT INTO REPAIR_ASSIGNMENT VALUES (1, -2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.machine_id AS machine_id, LHS.making_year AS making_year, LHS.class AS CLASS, LHS.team AS team, LHS.machine_series AS machine_series, LHS.value_points AS value_points, LHS.quality_rank AS quality_rank, RHS.name AS name, RHS.team AS team_other, RHS.starting_year AS starting_year, RHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id_other FROM machine AS LHS INNER JOIN (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id FROM technician AS LHS INNER JOIN repair_assignment AS RHS ON (LHS.technician_id = RHS.technician_id)) AS RHS ON (LHS.machine_id = RHS.technician_id)) ORDER BY name;

/*
Gold Result:
('-2',)
*/

-- Prediction Query
SELECT T3.Name FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id = T2.machine_id JOIN technician AS T3 ON T1.technician_ID = T3.technician_ID ORDER BY T2.quality_rank, T1.technician_id NULLS LAST, T1.repair_id NULLS LAST, T1.machine_id NULLS LAST, T2.machine_id NULLS LAST, T3.technician_id NULLS LAST;

/*
Prediction Result:
('-2',)
('12',)
*/