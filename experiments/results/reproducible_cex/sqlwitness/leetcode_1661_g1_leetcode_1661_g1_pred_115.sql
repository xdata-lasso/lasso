-- Schema DDL
CREATE TABLE "Activity" ("machine_id" INTEGER, "process_id" INTEGER, "activity_type" TEXT(255), "timestamp" REAL, PRIMARY KEY ("machine_id", "process_id", "activity_type"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (machine_id, process_id, activity_type, timestamp) VALUES (3, 2, 'start', NULL), (2, 3, 'end', 3), (3, 2, 'end', 2), (3, 0, 'start', NULL), (3, 0, 'end', 4), (2, 1, 'end', 3), (0, 0, 'end', 3), (0, 3, 'start', 4), (1, 4, 'end', 4), (3, 3, 'start', 0), (4, 0, 'end', 3), (3, 3, 'end', 3), (4, 1, 'start', 0), (0, 3, 'end', 3), (4, 3, 'start', 3), (2, 2, 'start', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.MACHINE_ID, ROUND(CAST(SUM(T2.TIMESTAMP - T1.TIMESTAMP) AS REAL) / COUNT(DISTINCT T1.PROCESS_ID), 3) AS PROCESSING_TIME FROM (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'start') AS T1 INNER JOIN (SELECT MACHINE_ID, PROCESS_ID, TIMESTAMP FROM ACTIVITY WHERE ACTIVITY_TYPE = 'end') AS T2 ON T1.MACHINE_ID = T2.MACHINE_ID AND T1.PROCESS_ID = T2.PROCESS_ID GROUP BY T1.MACHINE_ID;

/*
Gold Result:
(0, -1.0)
(3, 1.0)
*/

-- Prediction Query
SELECT S.MACHINE_ID, ROUND(AVG((E.TIMESTAMP - S.TIMESTAMP)), 3) AS PROCESSING_TIME FROM ACTIVITY AS S JOIN ACTIVITY AS E ON S.MACHINE_ID = E.MACHINE_ID WHERE S.ACTIVITY_TYPE = 'start' AND E.ACTIVITY_TYPE = 'end' AND S.PROCESS_ID = E.PROCESS_ID GROUP BY S.MACHINE_ID;

/*
Prediction Result:
(0, -1.0)
(3, 3.0)
*/