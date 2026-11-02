-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 0, 'start', 2), (3, 4, 'start', 3), (2, 0, 'end', NULL), (1, 2, 'start', 2), (0, 2, 'start', 3), (3, 3, 'start', 0), (0, 2, 'end', 0), (3, 3, 'end', 4), (4, 1, 'start', 0), (4, 1, 'end', 1), (4, 2, 'start', 3), (4, 2, 'end', 2), (4, 3, 'start', 1), (1, 3, 'start', 0), (2, 4, 'end', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, -3.0)
(2, None)
(3, 4.0)
(4, 0.0)
*/

-- Prediction Query
WITH T1 AS (SELECT MACHINE_ID, PROCESS_ID, LAG(TIMESTAMP) OVER (PARTITION BY MACHINE_ID, PROCESS_ID ORDER BY ACTIVITY_TYPE) AS START_TIME, TIMESTAMP AS END_TIME FROM ACTIVITY), T2 AS (SELECT MACHINE_ID, PROCESS_ID, (END_TIME - START_TIME) AS PROCESSING_TIME FROM T1 WHERE NOT END_TIME IS NULL AND NOT START_TIME IS NULL GROUP BY MACHINE_ID, PROCESS_ID) SELECT MACHINE_ID, ROUND(AVG(PROCESSING_TIME), 3) AS PROCESSING_TIME FROM T2 GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, 3.0)
(3, -4.0)
(4, 0.0)
*/