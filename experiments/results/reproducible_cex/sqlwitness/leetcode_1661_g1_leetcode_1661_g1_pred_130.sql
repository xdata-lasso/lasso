-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 0), (2, 3, 'end', 3), (0, 4, 'start', 0), (4, 2, 'end', 0), (2, 0, 'start', 2), (4, 4, 'end', NULL), (3, 2, 'end', 1), (3, 4, 'end', 3), (3, 3, 'start', 0), (3, 1, 'start', NULL), (1, 0, 'end', 0), (4, 1, 'start', 3), (4, 3, 'start', 2), (1, 4, 'end', NULL), (3, 3, 'end', 3), (4, 1, 'end', 0), (2, 3, 'start', 2), (1, 1, 'start', NULL), (2, 1, 'end', 1), (1, 3, 'end', 2), (4, 4, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(2, 1.0)
(3, 2.0)
(4, -1.5)
*/

-- Prediction Query
WITH E AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS END_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end'), S AS (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP AS START_TIME FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') SELECT E.MACHINE_ID, ROUND(AVG(E.END_TIME - S.START_TIME), 3) AS PROCESSING_TIME FROM E JOIN S ON E.MACHINE_ID = S.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID GROUP BY E.MACHINE_ID;

/*
Prediction Result:
(2, 1.0)
(3, 2.0)
(4, -3.0)
*/