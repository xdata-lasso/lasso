-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 3), (3, 4, 'start', 1), (0, 2, 'start', 2), (3, 0, 'end', NULL), (0, 4, 'start', 2), (4, 2, 'end', 3), (2, 0, 'start', 2), (2, 2, 'start', 4), (3, 2, 'end', 1), (3, 4, 'end', 3), (3, 3, 'start', 4), (0, 4, 'end', 1), (4, 3, 'start', 0), (3, 1, 'end', 2), (1, 4, 'end', 1), (3, 3, 'end', 3), (4, 3, 'end', 0), (1, 3, 'start', 4), (2, 4, 'end', 3), (2, 3, 'start', 2), (1, 1, 'start', 1), (3, 0, 'start', 3), (0, 1, 'end', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, -1.0)
(3, -0.25)
(4, 0.0)
*/

-- Prediction Query
WITH T1 AS (SELECT MACHINE_ID, PROCESS_ID, START_TIME, END_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS CTE1 JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS CTE2 USING (MACHINE_ID, PROCESS_ID)) SELECT MACHINE_ID, ROUND(AVG(END_TIME - START_TIME), 3) AS PROCESSING_TIME FROM T1 WHERE NOT END_TIME IS NULL GROUP BY MACHINE_ID ORDER BY MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(0, -1.0)
(3, -0.333)
(4, 0.0)
*/