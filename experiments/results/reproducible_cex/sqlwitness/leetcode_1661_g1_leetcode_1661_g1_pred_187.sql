-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (2, 3, 'end', 4), (0, 0, 'start', 0), (1, 1, 'end', 1), (0, 4, 'start', 3), (1, 0, 'start', 0), (1, 2, 'start', 2), (1, 4, 'start', 1), (1, 0, 'end', 4), (4, 1, 'start', NULL), (2, 4, 'start', NULL), (4, 3, 'start', 1), (2, 2, 'end', 3), (1, 2, 'end', NULL), (0, 3, 'start', 1), (1, 4, 'end', 2), (4, 3, 'end', 3), (2, 3, 'start', NULL), (1, 1, 'start', 2), (3, 0, 'start', 0), (2, 1, 'end', 3), (0, 1, 'end', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(1, 1.0)
(2, None)
(4, 2.0)
*/

-- Prediction Query
SELECT T1.MACHINE_ID, ROUND(AVG(T2.TIMESTAMP - T1.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS T1 INNER JOIN ACTIVITY AS T2 USING (MACHINE_ID, PROCESS_ID) WHERE T1.ACTIVITY_TYPE = 'start' AND T2.ACTIVITY_TYPE = 'end' GROUP BY 1 ORDER BY 1, T1.MACHINE_ID NULLS LAST, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(1, 1.333)
(2, None)
(4, 2.0)
*/