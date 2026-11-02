-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1025, 1026, 'start', 1027.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1025, 1026, 'end', 1028.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1036, 1037, 'start', NULL);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1036, 1037, 'end', NULL);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1036, 1040, 'start', 1041.5);
INSERT INTO "activity" ("machine_id", "process_id", "activity_type", "timestamp") VALUES (1036, 1040, 'end', 1042.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1025, 1.0)
(1036, 0.5)
*/

-- Prediction Query
SELECT START_ACTIVITY.MACHINE_ID, ROUND(AVG(END_ACTIVITY.TIMESTAMP - START_ACTIVITY.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS START_ACTIVITY INNER JOIN ACTIVITY AS END_ACTIVITY ON START_ACTIVITY.MACHINE_ID = END_ACTIVITY.MACHINE_ID AND START_ACTIVITY.PROCESS_ID = END_ACTIVITY.PROCESS_ID AND START_ACTIVITY.ACTIVITY_TYPE = 'start' AND END_ACTIVITY.ACTIVITY_TYPE = 'end' GROUP BY START_ACTIVITY.MACHINE_ID;

/*
Prediction Result:
(1025, 1.0)
(1036, 1.0)
*/