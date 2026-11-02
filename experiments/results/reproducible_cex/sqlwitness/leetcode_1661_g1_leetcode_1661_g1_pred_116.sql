-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', 4), (2, 3, 'end', NULL), (3, 0, 'end', 1), (0, 4, 'start', 1), (2, 2, 'start', 3), (3, 3, 'start', 1), (3, 1, 'start', 3), (0, 0, 'end', 1), (0, 4, 'end', 1), (2, 0, 'end', 3), (2, 2, 'end', 1), (0, 1, 'start', 3), (0, 3, 'start', 2), (1, 4, 'end', 2), (3, 3, 'end', 3), (1, 3, 'start', 0), (4, 3, 'end', 3), (2, 3, 'start', 3), (3, 0, 'start', 4), (2, 1, 'end', 1), (4, 2, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, 0.0)
(2, -1.0)
(3, -0.5)
*/

-- Prediction Query
SELECT S.MACHINE_ID, ROUND(AVG(E.TIMESTAMP - S.TIMESTAMP), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID AND S.PROCESS_ID = E.PROCESS_ID AND S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' GROUP BY S.MACHINE_ID ORDER BY S.MACHINE_ID, PROCESSING_TIME NULLS LAST;

/*
Prediction Result:
(0, 0.0)
(2, -2.0)
(3, -0.5)
*/