-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'start', NULL), (3, 2, 'end', 0), (3, 2, 'start', 4), (3, 4, 'start', 1), (1, 1, 'end', 1), (3, 4, 'end', 3), (1, 2, 'start', 0), (3, 3, 'start', 2), (0, 3, 'start', 3), (0, 4, 'start', 3), (4, 0, 'start', 0), (3, 3, 'end', NULL), (4, 1, 'start', 1), (4, 2, 'start', 3), (4, 3, 'end', 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(3, -0.667)
*/

-- Prediction Query
SELECT START_ACTIVITY.MACHINE_ID, ROUND(AVG(END_ACTIVITY.TIMESTAMP - START_ACTIVITY.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS START_ACTIVITY INNER JOIN ACTIVITY AS END_ACTIVITY ON START_ACTIVITY.MACHINE_ID = END_ACTIVITY.MACHINE_ID AND START_ACTIVITY.PROCESS_ID = END_ACTIVITY.PROCESS_ID AND START_ACTIVITY.ACTIVITY_TYPE = 'start' AND END_ACTIVITY.ACTIVITY_TYPE = 'end' GROUP BY START_ACTIVITY.MACHINE_ID;

/*
Prediction Result:
(3, -1.0)
*/