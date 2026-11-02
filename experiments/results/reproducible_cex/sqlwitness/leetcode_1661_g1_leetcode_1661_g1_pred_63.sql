-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 1), (0, 0, 'start', 1), (3, 4, 'start', 1), (3, 0, 'end', 1), (2, 2, 'start', 2), (3, 2, 'end', 0), (3, 4, 'end', 2), (3, 3, 'start', 3), (0, 4, 'end', 0), (4, 3, 'start', 3), (2, 0, 'end', NULL), (2, 2, 'end', 3), (2, 1, 'start', 0), (3, 3, 'end', 1), (4, 1, 'end', 3), (3, 0, 'start', NULL), (4, 0, 'start', 3), (0, 3, 'end', 2), (4, 2, 'start', 4), (4, 4, 'start', 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(2, 1.0)
(3, -0.5)
*/

-- Prediction Query
SELECT ACTIVITY_START.MACHINE_ID, ROUND(AVG(ACTIVITY_END.TIMESTAMP - ACTIVITY_START.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS ACTIVITY_START INNER JOIN ACTIVITY AS ACTIVITY_END ON ACTIVITY_START.MACHINE_ID = ACTIVITY_END.MACHINE_ID AND ACTIVITY_START.PROCESS_ID = ACTIVITY_END.PROCESS_ID AND ACTIVITY_START.ACTIVITY_TYPE = 'start' AND ACTIVITY_END.ACTIVITY_TYPE = 'end' GROUP BY ACTIVITY_START.MACHINE_ID;

/*
Prediction Result:
(2, 1.0)
(3, -0.667)
*/