-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (0, 0, 'start', 4), (3, 4, 'start', 1), (1, 1, 'end', NULL), (1, 0, 'start', 0), (3, 2, 'end', NULL), (1, 2, 'start', 0), (1, 4, 'start', 2), (0, 2, 'end', 1), (1, 0, 'end', 4), (0, 4, 'end', 4), (4, 3, 'start', NULL), (2, 2, 'end', 0), (1, 2, 'end', 4), (2, 1, 'start', NULL), (3, 3, 'end', 3), (4, 1, 'end', NULL), (2, 3, 'start', 2), (1, 1, 'start', 1), (1, 3, 'end', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, 2.667)
*/

-- Prediction Query
WITH PROCESS_TIMES AS (SELECT A1.MACHINE_ID, A1.PROCESS_ID, (A2.TIMESTAMP - A1.TIMESTAMP) AS PROCESS_TIME FROM ACTIVITY AS A1 INNER JOIN ACTIVITY AS A2 ON A1.MACHINE_ID = A2.MACHINE_ID AND A1.PROCESS_ID = A2.PROCESS_ID AND A1.ACTIVITY_TYPE = 'start' AND A2.ACTIVITY_TYPE = 'end') SELECT MACHINE_ID, ROUND(AVG(PROCESS_TIME), 3) AS PROCESSING_TIME FROM PROCESS_TIMES GROUP BY 1 ORDER BY 1, MACHINE_ID NULLS LAST, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(1, 4.0)
*/