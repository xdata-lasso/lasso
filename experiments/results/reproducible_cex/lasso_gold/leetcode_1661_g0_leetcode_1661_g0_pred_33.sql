-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1020, 1021, 'start', 1022.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1020, 1021, 'end', 1023.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1024, 1025, 'start', NULL);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1024, 1025, 'end', NULL);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1024, 1028, 'start', 1029.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1024, 1028, 'end', 1030.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID;

/*
Gold Result:
(1020, 1.0)
(1024, 1.0)
*/

-- Prediction Query
SELECT SUB1.MACHINE_ID, ROUND(CAST(SUM(SUB2.TIMESTAMP - SUB1.TIMESTAMP) AS REAL) / COUNT(*), 3) AS PROCESSING_TIME FROM ACTIVITY AS SUB1 LEFT JOIN ACTIVITY AS SUB2 ON SUB1.MACHINE_ID = SUB2.MACHINE_ID WHERE SUB1.PROCESS_ID = SUB2.PROCESS_ID AND SUB1.ACTIVITY_TYPE = 'start' AND SUB2.ACTIVITY_TYPE = 'end' GROUP BY 1;

/*
Prediction Result:
(1020, 1.0)
(1024, 0.5)
*/