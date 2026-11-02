-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'start', 4), (3, 2, 'start', 0), (3, 2, 'end', 4), (3, 4, 'start', 2), (1, 1, 'end', 0), (1, 1, 'start', 3), (1, 2, 'start', 3), (2, 1, 'start', 1), (3, 3, 'start', 3), (3, 0, 'end', 2), (0, 2, 'start', NULL), (1, 0, 'end', 2), (4, 1, 'start', 4), (2, 4, 'start', 3), (4, 2, 'end', 1), (0, 4, 'end', 4), (2, 0, 'start', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, -3.0)
(3, 4.0)
*/

-- Prediction Query
SELECT MACHINE_ID, ROUND(CAST(SUM(PROCESSING_TIME) AS REAL) / COUNT(PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP - LAG(TIMESTAMP, 1) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY TIMESTAMP) AS PROCESSING_TIME FROM ACTIVITY) AS T WHERE NOT PROCESSING_TIME IS NULL GROUP BY MACHINE_ID;

/*
Prediction Result:
(1, 3.0)
(3, 4.0)
*/