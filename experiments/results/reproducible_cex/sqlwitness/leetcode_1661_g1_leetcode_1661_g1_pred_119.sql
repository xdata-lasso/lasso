-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'start', 4), (3, 2, 'start', NULL), (3, 2, 'end', 3), (0, 0, 'start', 1), (1, 1, 'start', 4), (3, 4, 'end', 4), (3, 4, 'start', 1), (3, 0, 'start', 1), (3, 3, 'start', 0), (2, 1, 'start', NULL), (1, 2, 'end', 2), (1, 4, 'start', 2), (0, 0, 'end', NULL), (4, 0, 'start', 2), (0, 2, 'end', 3), (3, 3, 'end', 3), (4, 2, 'start', 2), (4, 3, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, None)
(3, 2.0)
*/

-- Prediction Query
SELECT T1.MACHINE_ID AS MACHINE_ID, ROUND(AVG(T2.TIMESTAMP - T1.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS T1 JOIN ACTIVITY AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID AND T1.ACTIVITY_TYPE <> T2.ACTIVITY_TYPE AND T1.ACTIVITY_TYPE = 'start' GROUP BY T1.MACHINE_ID;

/*
Prediction Result:
(0, None)
(3, 3.0)
*/