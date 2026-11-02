-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 1, 'end', 1), (1, 1, 'start', NULL), (3, 3, 'end', 1), (2, 0, 'end', 1), (2, 3, 'end', 0), (1, 0, 'end', 3), (4, 1, 'start', 2), (0, 1, 'end', 3), (1, 2, 'start', 0), (2, 2, 'start', NULL), (0, 2, 'end', 4), (2, 4, 'start', 4), (2, 2, 'end', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
SELECT T1.MACHINE_ID, ROUND(AVG(T2.TIMESTAMP - T1.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS T1 JOIN ACTIVITY AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID WHERE T1.TIMESTAMP < T2.TIMESTAMP GROUP BY T1.MACHINE_ID;

/*
Prediction Result:
*/