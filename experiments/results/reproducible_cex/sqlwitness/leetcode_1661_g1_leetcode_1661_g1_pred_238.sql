-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 3), (3, 4, 'start', 4), (1, 1, 'end', 3), (1, 0, 'start', 3), (4, 0, 'end', 1), (4, 4, 'end', 2), (3, 2, 'end', 1), (1, 2, 'start', 4), (3, 3, 'start', 1), (0, 2, 'end', 1), (2, 1, 'start', 4), (3, 1, 'end', 4), (3, 3, 'end', NULL), (2, 4, 'end', 3), (0, 1, 'end', 4), (4, 0, 'start', 4), (0, 3, 'end', 2), (1, 3, 'end', 1), (4, 4, 'start', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(3, -1.0)
(4, -1.0)
*/

-- Prediction Query
SELECT E.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS E JOIN ACTIVITY AS S ON E.MACHINE_ID = S.MACHINE_ID AND E.PROCESS_ID = S.PROCESS_ID AND E.ACTIVITY_TYPE = 'end' AND S.ACTIVITY_TYPE = 'start' GROUP BY E.MACHINE_ID;

/*
Prediction Result:
(3, -2.0)
(4, -1.0)
*/