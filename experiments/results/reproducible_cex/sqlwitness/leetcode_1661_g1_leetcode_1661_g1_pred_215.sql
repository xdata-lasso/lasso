-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'end', -1), (0, 0, 'start', -1), (0, 4, 'start', 4), (0, -1, 'end', 2), (4, 2, 'end', NULL), (-1, 3, 'end', 3), (2, 2, 'start', 3), (0, 0, 'end', 0), (1, 4, 'start', 2), (0, 2, 'end', 2), (4, 1, 'start', NULL), (2, 4, 'start', NULL), (0, 4, 'end', NULL), (2, 0, 'end', NULL), (2, 1, 'start', 3), (-1, 0, 'end', 0), (3, -1, 'start', NULL), (1, 1, 'start', 3), (0, 1, 'end', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, 0.5)
*/

-- Prediction Query
WITH START AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start'), END AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end'), TEMP AS (SELECT START.MACHINE_ID, (END_TIMESTAMP - START_TIMESTAMP) AS TIMES FROM START JOIN END ON START.MACHINE_ID = END.MACHINE_ID AND START.PROCESS_ID = END.PROCESS_ID) SELECT MACHINE_ID, COALESCE(ROUND(AVG(TIMES), 3), 0) AS PROCESSING_TIME FROM TEMP GROUP BY MACHINE_ID;

/*
Prediction Result:
(0, 1.0)
*/